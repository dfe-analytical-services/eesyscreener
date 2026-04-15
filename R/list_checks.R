#' List all checks run by screen_csv()
#'
#' Returns the full list of `check_` and `precheck_` functions in the order
#' they are executed by [screen_csv()], along with the title from each
#' function's documentation and the stage they belong to. The list is derived
#' dynamically from the bodies of [screen_filenames()] and [screen_dfs()], so
#' it always reflects the current execution order.
#'
#' @param print logical. If `TRUE` (default), a formatted table is printed to
#'   the console and the data frame is returned invisibly. If `FALSE`, the data
#'   frame is returned directly without printing.
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{function_name}{Name of the check or precheck function}
#'   \item{title}{Title from the function's documentation}
#'   \item{stage}{Stage the function belongs to, as used in [screen_dfs()]}
#' }
#' Returned invisibly when `print = TRUE`.
#'
#' @examples
#' list_checks()
#' list_checks(print = FALSE)
#' @export
list_checks <- function(print = TRUE) {
  checks <- get_checks_in_order()
  checks$title <- vapply(checks$function_name, get_rd_title, character(1))
  checks <- checks[, c("function_name", "title", "stage")]

  if (print) {
    print_checks(checks)
    return(invisible(checks))
  }

  checks
}

# Internal: build data frame of (function_name, stage) in execution order -----
get_checks_in_order <- function() {
  rbind(
    extract_filename_checks(),
    extract_df_checks()
  )
}

# Walks the AST of screen_filenames() to collect check_filename_* calls in the
# order they appear. Uses a recursive helper with <<- to accumulate results
# across nested expressions without passing state through return values.
extract_filename_checks <- function() {
  fn_body <- body(screen_filenames)
  seen <- character(0)

  # Recursively visit every node in the expression tree; record any function
  # call whose name starts with "check_filename", preserving first-seen order.
  collect_fns <- function(expr) {
    if (!is.call(expr)) {
      return()
    }
    if (is.name(expr[[1]])) {
      fn_name <- as.character(expr[[1]])
      if (grepl("^check_filename", fn_name) && !fn_name %in% seen) {
        seen <<- c(seen, fn_name)
      }
    }
    # Visit each argument of the call (skip index 1, which is the function name)
    for (i in seq_along(expr)[-1]) {
      collect_fns(expr[[i]])
    }
  }

  # Skip index 1 of fn_body — that is the `{` token, not a real statement
  for (i in seq_along(fn_body)[-1]) {
    collect_fns(fn_body[[i]])
  }

  data.frame(
    function_name = seen,
    stage = "Check filenames",
    stringsAsFactors = FALSE
  )
}

# Walks the AST of screen_dfs() statement-by-statement to collect every
# (function_name, stage) pair. screen_dfs() uses three patterns that need
# handling:
#   1. Direct run_and_log_check() calls with an inline rbind() of checks
#   2. Assignments of check groups into intermediate variables (var <- rbind(...))
#      that are later passed by name to run_and_log_check()
#   3. Conditional blocks (if (dd_checks) { ... }) that append optional checks
#      to an intermediate variable before it is consumed by run_and_log_check()
extract_df_checks <- function() {
  fn_body <- body(screen_dfs)
  result <- list()
  # Tracks rbind() assignments (var <- rbind(...)) so they can be resolved when
  # referenced by name inside a later run_and_log_check() call
  intermediate_vars <- list()

  for (i in seq_along(fn_body)[-1]) {
    stmt <- fn_body[[i]]
    if (!is.call(stmt)) {
      next
    }

    # Pattern 1: res <- run_and_log_check(all_results, <checks>, "Stage", ...)
    # The stage label is the 3rd argument; the checks are the 2nd argument and
    # can be either an inline rbind() or a reference to an intermediate variable.
    if (
      identical(stmt[[1]], as.name("<-")) &&
        is.call(stmt[[3]]) &&
        identical(stmt[[3]][[1]], as.name("run_and_log_check"))
    ) {
      rlc <- stmt[[3]]
      stage <- as.character(rlc[[4]])
      second_arg <- rlc[[3]]

      if (is.call(second_arg) && identical(second_arg[[1]], as.name("rbind"))) {
        # Inline rbind() — extract function names directly
        fns <- check_fns_from_rbind(second_arg, intermediate_vars)
      } else if (is.name(second_arg)) {
        # Named variable — look up the previously recorded function list
        fns <- intermediate_vars[[as.character(second_arg)]]
      } else {
        fns <- character(0)
      }

      for (fn in fns) {
        result[[length(result) + 1]] <- list(function_name = fn, stage = stage)
      }
      next
    }

    # Pattern 2: var <- rbind(...) — a named group of checks assembled before
    # being passed to run_and_log_check(). Store for later resolution.
    if (
      identical(stmt[[1]], as.name("<-")) &&
        is.name(stmt[[2]]) &&
        is.call(stmt[[3]]) &&
        identical(stmt[[3]][[1]], as.name("rbind"))
    ) {
      lhs <- as.character(stmt[[2]])
      intermediate_vars[[lhs]] <- check_fns_from_rbind(
        stmt[[3]],
        intermediate_vars
      )
      next
    }

    # Pattern 3: if (dd_checks) { var <- rbind(var, new_fn()) }
    # An optional block that appends data-dictionary checks to an intermediate
    # variable. Update the tracked variable so Pattern 1 resolves it correctly.
    if (
      identical(stmt[[1]], as.name("if")) &&
        is.name(stmt[[2]]) &&
        identical(stmt[[2]], as.name("dd_checks"))
    ) {
      if_body <- stmt[[3]]
      # Unwrap the braces block `{ ... }` into individual statements
      stmts <- if (is.call(if_body) && identical(if_body[[1]], as.name("{"))) {
        lapply(seq_along(if_body)[-1], function(j) if_body[[j]])
      } else {
        list(if_body)
      }
      for (sub_stmt in stmts) {
        if (
          is.call(sub_stmt) &&
            identical(sub_stmt[[1]], as.name("<-")) &&
            is.name(sub_stmt[[2]]) &&
            is.call(sub_stmt[[3]]) &&
            identical(sub_stmt[[3]][[1]], as.name("rbind"))
        ) {
          lhs <- as.character(sub_stmt[[2]])
          intermediate_vars[[lhs]] <- check_fns_from_rbind(
            sub_stmt[[3]],
            intermediate_vars
          )
        }
      }
    }
  }

  if (length(result) == 0) {
    return(data.frame(
      function_name = character(0),
      stage = character(0),
      stringsAsFactors = FALSE
    ))
  }

  do.call(rbind, lapply(result, as.data.frame, stringsAsFactors = FALSE))
}

# Extracts check/precheck function names from an rbind() call in the AST.
# Arguments can be direct function calls (e.g. check_foo()) or references to
# intermediate variables accumulated earlier; both are resolved here.
check_fns_from_rbind <- function(rbind_call, intermediate_vars) {
  fns <- character(0)
  # Skip index 1 — that is the `rbind` symbol itself, not an argument
  for (i in seq_along(rbind_call)[-1]) {
    arg <- rbind_call[[i]]
    if (is.call(arg)) {
      # A direct call like check_foo() — extract the function name
      fn_name <- as.character(arg[[1]])
      if (grepl("^(pre)?check_", fn_name)) fns <- c(fns, fn_name)
    } else if (is.name(arg)) {
      # A variable reference — look up functions stored under that name
      var_name <- as.character(arg)
      if (var_name %in% names(intermediate_vars)) {
        fns <- c(fns, intermediate_vars[[var_name]])
      }
    }
  }
  fns
}

# Internal: read title from Rd file -------------------------------------------
get_rd_title <- function(fn_name) {
  man_dir <- system.file("man", package = "eesyscreener")
  rd_file <- file.path(man_dir, paste0(fn_name, ".Rd"))

  if (!file.exists(rd_file)) {
    return(NA_character_)
  }

  rd <- tools::parse_Rd(rd_file)

  for (block in rd) {
    if (identical(attr(block, "Rd_tag"), "\\title")) {
      raw <- trimws(paste(unlist(block), collapse = ""))
      # Take first line only — some titles include the description paragraph
      # when no blank line separates the two in the roxygen source
      return(trimws(strsplit(raw, "\n")[[1]][1]))
    }
  }

  NA_character_
}

# Internal: print formatted output --------------------------------------------
print_checks <- function(checks) {
  for (stage in unique(checks$stage)) {
    cli::cli_rule(left = stage)
    stage_checks <- checks[checks$stage == stage, ]
    cli::cli_dl(setNames(stage_checks$title, stage_checks$function_name))
  }
}
