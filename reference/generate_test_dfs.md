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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        364
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        249
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        365
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        515
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        216
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        628
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        279
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        283
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        121
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        706
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        996
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        278
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        785
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        932
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        636
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        594
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        597
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        264
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        363
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        772
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        835
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        975
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        950
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        703
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        895
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        915
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        942
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        390
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        229
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        954
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        973
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        742
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        905
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        551
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        845
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        676
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        842
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        761
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        758
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        869
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        931
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        651
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        292
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        255
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        554
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        111
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        537
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        908
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        141
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        677
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        201
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        970
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        893
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        927
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        601
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        369
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        872
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        586
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        470
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        852
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        968
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        884
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        112
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        708
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        516
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        688
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        387
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        296
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        922
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        622
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        903
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        362
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        762
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        571
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        645
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        555
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        940
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        406
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        460
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        777
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        976
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        336
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        636
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        920
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        262
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        144
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        309
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        506
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        270
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        103
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        517
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        908
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        181
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        705
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        303
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        483
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        244
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        813
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        847
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        368
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        531
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        906
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        312
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        583
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        804
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        614
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        874
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        788
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        297
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        574
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        367
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        394
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        494
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        141
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        139
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        857
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        212
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        591
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        343
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        626
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        565
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        911
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        696
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        925
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        128
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        941
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        713
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        241
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        933
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        552
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        648
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        463
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        743
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        950
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        155
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        407
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        796
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        756
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        570
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        642
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        576
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        791
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        557
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        123
#>     indicator2 indicator3
#> 1          867        494
#> 2          700        131
#> 3          621        499
#> 4          940        686
#> 5          822        965
#> 6          956        557
#> 7          278        238
#> 8          640        107
#> 9          148        821
#> 10         178        569
#> 11         802        473
#> 12         890        552
#> 13         968        178
#> 14         642        296
#> 15         594        767
#> 16         409        239
#> 17         139        572
#> 18         234        384
#> 19         790        786
#> 20         191        127
#> 21         203        820
#> 22         879        196
#> 23         870        972
#> 24         499        983
#> 25         683        355
#> 26         495        693
#> 27         859        859
#> 28         421        403
#> 29         682        481
#> 30         821        579
#> 31         637        250
#> 32         931        291
#> 33         479        494
#> 34         516        637
#> 35         216        490
#> 36         317        297
#> 37         997        248
#> 38         156        652
#> 39         142        665
#> 40         388        416
#> 41         627        801
#> 42         186        738
#> 43         242        559
#> 44         974        621
#> 45         131        611
#> 46         311        173
#> 47         318        415
#> 48         676        126
#> 49         671        901
#> 50         892        269
#> 51         736        682
#> 52         237        282
#> 53         654        919
#> 54         834        143
#> 55         983        752
#> 56         985        639
#> 57         466        723
#> 58         159        474
#> 59         162        829
#> 60         541        805
#> 61         930        812
#> 62         801        141
#> 63         645        105
#> 64         861        144
#> 65         141        157
#> 66         405        837
#> 67         520        549
#> 68         118        844
#> 69         695        900
#> 70         305        116
#> 71         197        932
#> 72         968        767
#> 73         745        836
#> 74         150        924
#> 75         212        853
#> 76         267        390
#> 77         833        115
#> 78         569        450
#> 79         753        140
#> 80         611        623
#> 81         166        496
#> 82         117        849
#> 83         498        456
#> 84         191        427
#> 85         223        969
#> 86         635        798
#> 87         778        160
#> 88         957        996
#> 89         408        503
#> 90         939        781
#> 91         893        518
#> 92         338        181
#> 93         264        650
#> 94         755        113
#> 95         662        845
#> 96         455        306
#> 97         896        389
#> 98         124        632
#> 99         336        105
#> 100        186        482
#> 101        918        781
#> 102        386        672
#> 103        765        554
#> 104        347        905
#> 105        486        582
#> 106        244        647
#> 107        674        454
#> 108        388        329
#> 109        588        135
#> 110        147        557
#> 111        333        403
#> 112        974        362
#> 113        568        302
#> 114        501        595
#> 115        589        560
#> 116        446        956
#> 117        251        492
#> 118        581        820
#> 119        311        926
#> 120        424        783
#> 121        481        977
#> 122        239        277
#> 123        783        854
#> 124        634        877
#> 125        592        736
#> 126        151        208
#> 127        759        788
#> 128        103        113
#> 129        438        240
#> 130        226        718
#> 131        568        237
#> 132        761        360
#> 133        632        771
#> 134        339        840
#> 135        182        494
#> 136        351        979
#> 137        785        170
#> 138        241        666
#> 139        895        667
#> 140        695        915
#> 141        760        414
#> 142        937        937
#> 143        226        981
#> 144        106        143
#> 145        234        306
#> 146        605        895
#> 147        105        168
#> 148        488        616
#> 149        623        112
#> 150        363        420
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
