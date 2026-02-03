## Running eesyscreener in Docker

If you're not a regular R user or don't want to set up R and all the dependencies on your machine, you can use Docker to run eesyscreener in a containerised R environment.

These instructions assume you already have Docker installed. If you don't, please refer to the [Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.

1. Open a terminal and go to the repository root.

2. Build the image:

	```sh
	docker build -f docker/Dockerfile-eesyscreener-dev -t eesyscreener-dev .
	```

3. Start a container:

	```sh
	docker run -ti --name eesyscreener-dev -v ".:/home/r" -w /home/r eesyscreener-dev
	```

4. In the R console, run:

	```r
	devtools::load_all()
	```

5. Screen away in the R console! For example:

	```r
	screen_dfs(example_data, example_meta) # use example data objects built into package
	```

	```r
	screen_csv("sample-data/example.csv", "sample-data/example.meta.csv") # use your own CSVs within a 'sample-data' folder in the repo root
	```

	Refer to the README and docs for more guidance on using the package, and use `quit()` to stop the R session.

	To restart the container at a later time:

	```sh
	docker start eesyscreener-dev
	```
	