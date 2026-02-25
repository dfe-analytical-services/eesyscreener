# EES-ily generate some beefy test files

Mostly for ease of performance benchmarking. A bit crude, only does
PCons for simplicity so far.

## Usage

``` r
generate_test_dfs(
  years = 3000,
  pcon_names = "Sheffield Central",
  pcon_codes = "E14000919",
  num_filters = 1,
  num_indicators = 1,
  verbose = FALSE
)
```

## Arguments

- years:

  A vector of 4 digit years

- pcon_names:

  A vector of PCon names

- pcon_codes:

  A vector of PCon codes

- num_filters:

  The number of filters to generate, currently will give each filter 5
  items

- num_indicators:

  The number of indicators to generate, currently generates random
  numbers between 100 and 1000

- verbose:

  Optional console messages highlighting the number of rows being
  created

## Value

A list containing two data frames, one data and associated meta

## Examples

``` r
generate_test_dfs(2010:2015, "Sheffield Central", "E14000919", 2, 3)
#> $data
#>     time_period time_identifier           geographic_level country_name
#> 1          2010   Calendar year Parliamentary constituency      England
#> 2          2011   Calendar year Parliamentary constituency      England
#> 3          2012   Calendar year Parliamentary constituency      England
#> 4          2013   Calendar year Parliamentary constituency      England
#> 5          2014   Calendar year Parliamentary constituency      England
#> 6          2015   Calendar year Parliamentary constituency      England
#> 7          2010   Calendar year Parliamentary constituency      England
#> 8          2011   Calendar year Parliamentary constituency      England
#> 9          2012   Calendar year Parliamentary constituency      England
#> 10         2013   Calendar year Parliamentary constituency      England
#> 11         2014   Calendar year Parliamentary constituency      England
#> 12         2015   Calendar year Parliamentary constituency      England
#> 13         2010   Calendar year Parliamentary constituency      England
#> 14         2011   Calendar year Parliamentary constituency      England
#> 15         2012   Calendar year Parliamentary constituency      England
#> 16         2013   Calendar year Parliamentary constituency      England
#> 17         2014   Calendar year Parliamentary constituency      England
#> 18         2015   Calendar year Parliamentary constituency      England
#> 19         2010   Calendar year Parliamentary constituency      England
#> 20         2011   Calendar year Parliamentary constituency      England
#> 21         2012   Calendar year Parliamentary constituency      England
#> 22         2013   Calendar year Parliamentary constituency      England
#> 23         2014   Calendar year Parliamentary constituency      England
#> 24         2015   Calendar year Parliamentary constituency      England
#> 25         2010   Calendar year Parliamentary constituency      England
#> 26         2011   Calendar year Parliamentary constituency      England
#> 27         2012   Calendar year Parliamentary constituency      England
#> 28         2013   Calendar year Parliamentary constituency      England
#> 29         2014   Calendar year Parliamentary constituency      England
#> 30         2015   Calendar year Parliamentary constituency      England
#> 31         2010   Calendar year Parliamentary constituency      England
#> 32         2011   Calendar year Parliamentary constituency      England
#> 33         2012   Calendar year Parliamentary constituency      England
#> 34         2013   Calendar year Parliamentary constituency      England
#> 35         2014   Calendar year Parliamentary constituency      England
#> 36         2015   Calendar year Parliamentary constituency      England
#> 37         2010   Calendar year Parliamentary constituency      England
#> 38         2011   Calendar year Parliamentary constituency      England
#> 39         2012   Calendar year Parliamentary constituency      England
#> 40         2013   Calendar year Parliamentary constituency      England
#> 41         2014   Calendar year Parliamentary constituency      England
#> 42         2015   Calendar year Parliamentary constituency      England
#> 43         2010   Calendar year Parliamentary constituency      England
#> 44         2011   Calendar year Parliamentary constituency      England
#> 45         2012   Calendar year Parliamentary constituency      England
#> 46         2013   Calendar year Parliamentary constituency      England
#> 47         2014   Calendar year Parliamentary constituency      England
#> 48         2015   Calendar year Parliamentary constituency      England
#> 49         2010   Calendar year Parliamentary constituency      England
#> 50         2011   Calendar year Parliamentary constituency      England
#> 51         2012   Calendar year Parliamentary constituency      England
#> 52         2013   Calendar year Parliamentary constituency      England
#> 53         2014   Calendar year Parliamentary constituency      England
#> 54         2015   Calendar year Parliamentary constituency      England
#> 55         2010   Calendar year Parliamentary constituency      England
#> 56         2011   Calendar year Parliamentary constituency      England
#> 57         2012   Calendar year Parliamentary constituency      England
#> 58         2013   Calendar year Parliamentary constituency      England
#> 59         2014   Calendar year Parliamentary constituency      England
#> 60         2015   Calendar year Parliamentary constituency      England
#> 61         2010   Calendar year Parliamentary constituency      England
#> 62         2011   Calendar year Parliamentary constituency      England
#> 63         2012   Calendar year Parliamentary constituency      England
#> 64         2013   Calendar year Parliamentary constituency      England
#> 65         2014   Calendar year Parliamentary constituency      England
#> 66         2015   Calendar year Parliamentary constituency      England
#> 67         2010   Calendar year Parliamentary constituency      England
#> 68         2011   Calendar year Parliamentary constituency      England
#> 69         2012   Calendar year Parliamentary constituency      England
#> 70         2013   Calendar year Parliamentary constituency      England
#> 71         2014   Calendar year Parliamentary constituency      England
#> 72         2015   Calendar year Parliamentary constituency      England
#> 73         2010   Calendar year Parliamentary constituency      England
#> 74         2011   Calendar year Parliamentary constituency      England
#> 75         2012   Calendar year Parliamentary constituency      England
#> 76         2013   Calendar year Parliamentary constituency      England
#> 77         2014   Calendar year Parliamentary constituency      England
#> 78         2015   Calendar year Parliamentary constituency      England
#> 79         2010   Calendar year Parliamentary constituency      England
#> 80         2011   Calendar year Parliamentary constituency      England
#> 81         2012   Calendar year Parliamentary constituency      England
#> 82         2013   Calendar year Parliamentary constituency      England
#> 83         2014   Calendar year Parliamentary constituency      England
#> 84         2015   Calendar year Parliamentary constituency      England
#> 85         2010   Calendar year Parliamentary constituency      England
#> 86         2011   Calendar year Parliamentary constituency      England
#> 87         2012   Calendar year Parliamentary constituency      England
#> 88         2013   Calendar year Parliamentary constituency      England
#> 89         2014   Calendar year Parliamentary constituency      England
#> 90         2015   Calendar year Parliamentary constituency      England
#> 91         2010   Calendar year Parliamentary constituency      England
#> 92         2011   Calendar year Parliamentary constituency      England
#> 93         2012   Calendar year Parliamentary constituency      England
#> 94         2013   Calendar year Parliamentary constituency      England
#> 95         2014   Calendar year Parliamentary constituency      England
#> 96         2015   Calendar year Parliamentary constituency      England
#> 97         2010   Calendar year Parliamentary constituency      England
#> 98         2011   Calendar year Parliamentary constituency      England
#> 99         2012   Calendar year Parliamentary constituency      England
#> 100        2013   Calendar year Parliamentary constituency      England
#> 101        2014   Calendar year Parliamentary constituency      England
#> 102        2015   Calendar year Parliamentary constituency      England
#> 103        2010   Calendar year Parliamentary constituency      England
#> 104        2011   Calendar year Parliamentary constituency      England
#> 105        2012   Calendar year Parliamentary constituency      England
#> 106        2013   Calendar year Parliamentary constituency      England
#> 107        2014   Calendar year Parliamentary constituency      England
#> 108        2015   Calendar year Parliamentary constituency      England
#> 109        2010   Calendar year Parliamentary constituency      England
#> 110        2011   Calendar year Parliamentary constituency      England
#> 111        2012   Calendar year Parliamentary constituency      England
#> 112        2013   Calendar year Parliamentary constituency      England
#> 113        2014   Calendar year Parliamentary constituency      England
#> 114        2015   Calendar year Parliamentary constituency      England
#> 115        2010   Calendar year Parliamentary constituency      England
#> 116        2011   Calendar year Parliamentary constituency      England
#> 117        2012   Calendar year Parliamentary constituency      England
#> 118        2013   Calendar year Parliamentary constituency      England
#> 119        2014   Calendar year Parliamentary constituency      England
#> 120        2015   Calendar year Parliamentary constituency      England
#> 121        2010   Calendar year Parliamentary constituency      England
#> 122        2011   Calendar year Parliamentary constituency      England
#> 123        2012   Calendar year Parliamentary constituency      England
#> 124        2013   Calendar year Parliamentary constituency      England
#> 125        2014   Calendar year Parliamentary constituency      England
#> 126        2015   Calendar year Parliamentary constituency      England
#> 127        2010   Calendar year Parliamentary constituency      England
#> 128        2011   Calendar year Parliamentary constituency      England
#> 129        2012   Calendar year Parliamentary constituency      England
#> 130        2013   Calendar year Parliamentary constituency      England
#> 131        2014   Calendar year Parliamentary constituency      England
#> 132        2015   Calendar year Parliamentary constituency      England
#> 133        2010   Calendar year Parliamentary constituency      England
#> 134        2011   Calendar year Parliamentary constituency      England
#> 135        2012   Calendar year Parliamentary constituency      England
#> 136        2013   Calendar year Parliamentary constituency      England
#> 137        2014   Calendar year Parliamentary constituency      England
#> 138        2015   Calendar year Parliamentary constituency      England
#> 139        2010   Calendar year Parliamentary constituency      England
#> 140        2011   Calendar year Parliamentary constituency      England
#> 141        2012   Calendar year Parliamentary constituency      England
#> 142        2013   Calendar year Parliamentary constituency      England
#> 143        2014   Calendar year Parliamentary constituency      England
#> 144        2015   Calendar year Parliamentary constituency      England
#> 145        2010   Calendar year Parliamentary constituency      England
#> 146        2011   Calendar year Parliamentary constituency      England
#> 147        2012   Calendar year Parliamentary constituency      England
#> 148        2013   Calendar year Parliamentary constituency      England
#> 149        2014   Calendar year Parliamentary constituency      England
#> 150        2015   Calendar year Parliamentary constituency      England
#>     country_code         pcon_name pcon_code filter1 filter2 indicator1
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        249
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        365
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        515
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        216
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        628
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        279
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        283
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        121
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        706
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        996
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        278
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        785
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        932
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        636
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        594
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        597
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        264
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        363
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        772
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        835
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        975
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        950
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        703
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        895
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        915
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        942
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        390
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        229
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        954
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        973
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        742
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        905
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        551
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        845
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        676
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        842
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        761
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        758
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        869
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        931
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        651
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        292
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        255
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        554
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        111
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        537
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        908
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        141
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        677
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        201
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        970
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        893
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        927
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        601
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        369
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        872
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        586
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        470
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        852
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        968
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        884
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        112
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        708
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        516
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        688
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        387
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        296
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        922
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        622
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        903
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        362
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        762
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        571
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        645
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        555
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        940
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        406
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        460
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        777
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        976
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        336
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        636
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        920
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        262
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        144
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        309
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        506
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        270
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        103
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        517
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        908
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        181
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        705
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        303
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        483
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        244
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        813
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        847
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        368
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        531
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        906
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        312
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        583
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        804
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        614
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        874
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        788
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        297
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        574
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        367
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        394
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        494
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        141
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        139
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        857
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        212
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        591
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        343
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        626
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        565
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        911
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        696
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        925
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        128
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        941
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        713
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        241
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        933
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        552
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        648
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        463
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        743
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        950
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        155
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        407
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        796
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        756
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        570
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        642
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        576
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        791
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        557
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        123
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        867
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        700
#>     indicator2 indicator3
#> 1          621        499
#> 2          940        686
#> 3          822        965
#> 4          956        557
#> 5          278        238
#> 6          640        107
#> 7          148        821
#> 8          178        569
#> 9          802        473
#> 10         890        552
#> 11         968        178
#> 12         642        296
#> 13         594        767
#> 14         409        239
#> 15         139        572
#> 16         234        384
#> 17         790        786
#> 18         191        127
#> 19         203        820
#> 20         879        196
#> 21         870        972
#> 22         499        983
#> 23         683        355
#> 24         495        693
#> 25         859        859
#> 26         421        403
#> 27         682        481
#> 28         821        579
#> 29         637        250
#> 30         931        291
#> 31         479        494
#> 32         516        637
#> 33         216        490
#> 34         317        297
#> 35         997        248
#> 36         156        652
#> 37         142        665
#> 38         388        416
#> 39         627        801
#> 40         186        738
#> 41         242        559
#> 42         974        621
#> 43         131        611
#> 44         311        173
#> 45         318        415
#> 46         676        126
#> 47         671        901
#> 48         892        269
#> 49         736        682
#> 50         237        282
#> 51         654        919
#> 52         834        143
#> 53         983        752
#> 54         985        639
#> 55         466        723
#> 56         159        474
#> 57         162        829
#> 58         541        805
#> 59         930        812
#> 60         801        141
#> 61         645        105
#> 62         861        144
#> 63         141        157
#> 64         405        837
#> 65         520        549
#> 66         118        844
#> 67         695        900
#> 68         305        116
#> 69         197        932
#> 70         968        767
#> 71         745        836
#> 72         150        924
#> 73         212        853
#> 74         267        390
#> 75         833        115
#> 76         569        450
#> 77         753        140
#> 78         611        623
#> 79         166        496
#> 80         117        849
#> 81         498        456
#> 82         191        427
#> 83         223        969
#> 84         635        798
#> 85         778        160
#> 86         957        996
#> 87         408        503
#> 88         939        781
#> 89         893        518
#> 90         338        181
#> 91         264        650
#> 92         755        113
#> 93         662        845
#> 94         455        306
#> 95         896        389
#> 96         124        632
#> 97         336        105
#> 98         186        482
#> 99         918        781
#> 100        386        672
#> 101        765        554
#> 102        347        905
#> 103        486        582
#> 104        244        647
#> 105        674        454
#> 106        388        329
#> 107        588        135
#> 108        147        557
#> 109        333        403
#> 110        974        362
#> 111        568        302
#> 112        501        595
#> 113        589        560
#> 114        446        956
#> 115        251        492
#> 116        581        820
#> 117        311        926
#> 118        424        783
#> 119        481        977
#> 120        239        277
#> 121        783        854
#> 122        634        877
#> 123        592        736
#> 124        151        208
#> 125        759        788
#> 126        103        113
#> 127        438        240
#> 128        226        718
#> 129        568        237
#> 130        761        360
#> 131        632        771
#> 132        339        840
#> 133        182        494
#> 134        351        979
#> 135        785        170
#> 136        241        666
#> 137        895        667
#> 138        695        915
#> 139        760        414
#> 140        937        937
#> 141        226        981
#> 142        106        143
#> 143        234        306
#> 144        605        895
#> 145        105        168
#> 146        488        616
#> 147        623        112
#> 148        363        420
#> 149        494        824
#> 150        131        223
#> 
#> $meta
#>     col_name  col_type      label indicator_grouping indicator_unit
#> 1    filter1    Filter    FILTER1                 NA             NA
#> 2    filter2    Filter    FILTER2                 NA             NA
#> 3 indicator1 Indicator INDICATOR1                 NA             NA
#> 4 indicator2 Indicator INDICATOR2                 NA             NA
#> 5 indicator3 Indicator INDICATOR3                 NA             NA
#>   indicator_dp filter_hint filter_grouping_column
#> 1           NA          NA                     NA
#> 2           NA          NA                     NA
#> 3           NA          NA                     NA
#> 4           NA          NA                     NA
#> 5           NA          NA                     NA
#> 
```
