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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        365
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        515
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        216
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        628
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        279
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        283
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        121
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        706
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        996
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        278
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        785
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        932
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        636
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        594
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        597
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        264
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        363
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        772
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        835
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        975
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        950
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        703
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        895
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        915
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        942
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        390
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        229
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        954
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        973
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        742
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        905
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        551
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        845
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        676
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        842
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        761
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        758
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        869
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        931
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        651
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        292
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        255
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        554
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        111
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        537
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        908
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        141
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        677
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        201
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        970
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        893
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        927
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        601
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        369
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        872
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        586
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        470
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        852
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        968
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        884
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        112
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        708
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        516
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        688
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        387
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        296
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        922
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        622
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        903
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        362
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        762
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        571
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        645
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        555
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        940
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        406
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        460
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        777
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        976
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        336
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        636
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        920
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        262
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        144
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        309
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        506
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        270
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        103
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        517
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        908
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        181
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        705
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        303
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        483
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        244
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        813
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        847
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        368
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        531
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        906
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        312
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        583
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        804
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        614
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        874
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        788
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        297
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        574
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        367
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        394
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        494
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        141
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        139
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        857
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        212
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        591
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        343
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        626
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        565
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        911
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        696
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        925
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        128
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        941
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        713
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        241
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        933
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        552
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        648
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        463
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        743
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        950
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        155
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        407
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        796
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        756
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        570
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        642
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        576
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        791
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        557
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        123
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        867
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        700
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        621
#>     indicator2 indicator3
#> 1          940        686
#> 2          822        965
#> 3          956        557
#> 4          278        238
#> 5          640        107
#> 6          148        821
#> 7          178        569
#> 8          802        473
#> 9          890        552
#> 10         968        178
#> 11         642        296
#> 12         594        767
#> 13         409        239
#> 14         139        572
#> 15         234        384
#> 16         790        786
#> 17         191        127
#> 18         203        820
#> 19         879        196
#> 20         870        972
#> 21         499        983
#> 22         683        355
#> 23         495        693
#> 24         859        859
#> 25         421        403
#> 26         682        481
#> 27         821        579
#> 28         637        250
#> 29         931        291
#> 30         479        494
#> 31         516        637
#> 32         216        490
#> 33         317        297
#> 34         997        248
#> 35         156        652
#> 36         142        665
#> 37         388        416
#> 38         627        801
#> 39         186        738
#> 40         242        559
#> 41         974        621
#> 42         131        611
#> 43         311        173
#> 44         318        415
#> 45         676        126
#> 46         671        901
#> 47         892        269
#> 48         736        682
#> 49         237        282
#> 50         654        919
#> 51         834        143
#> 52         983        752
#> 53         985        639
#> 54         466        723
#> 55         159        474
#> 56         162        829
#> 57         541        805
#> 58         930        812
#> 59         801        141
#> 60         645        105
#> 61         861        144
#> 62         141        157
#> 63         405        837
#> 64         520        549
#> 65         118        844
#> 66         695        900
#> 67         305        116
#> 68         197        932
#> 69         968        767
#> 70         745        836
#> 71         150        924
#> 72         212        853
#> 73         267        390
#> 74         833        115
#> 75         569        450
#> 76         753        140
#> 77         611        623
#> 78         166        496
#> 79         117        849
#> 80         498        456
#> 81         191        427
#> 82         223        969
#> 83         635        798
#> 84         778        160
#> 85         957        996
#> 86         408        503
#> 87         939        781
#> 88         893        518
#> 89         338        181
#> 90         264        650
#> 91         755        113
#> 92         662        845
#> 93         455        306
#> 94         896        389
#> 95         124        632
#> 96         336        105
#> 97         186        482
#> 98         918        781
#> 99         386        672
#> 100        765        554
#> 101        347        905
#> 102        486        582
#> 103        244        647
#> 104        674        454
#> 105        388        329
#> 106        588        135
#> 107        147        557
#> 108        333        403
#> 109        974        362
#> 110        568        302
#> 111        501        595
#> 112        589        560
#> 113        446        956
#> 114        251        492
#> 115        581        820
#> 116        311        926
#> 117        424        783
#> 118        481        977
#> 119        239        277
#> 120        783        854
#> 121        634        877
#> 122        592        736
#> 123        151        208
#> 124        759        788
#> 125        103        113
#> 126        438        240
#> 127        226        718
#> 128        568        237
#> 129        761        360
#> 130        632        771
#> 131        339        840
#> 132        182        494
#> 133        351        979
#> 134        785        170
#> 135        241        666
#> 136        895        667
#> 137        695        915
#> 138        760        414
#> 139        937        937
#> 140        226        981
#> 141        106        143
#> 142        234        306
#> 143        605        895
#> 144        105        168
#> 145        488        616
#> 146        623        112
#> 147        363        420
#> 148        494        824
#> 149        131        223
#> 150        499        940
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
