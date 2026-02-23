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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        643
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        364
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        249
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        365
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        515
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        216
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        628
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        279
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        283
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        121
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        706
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        996
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        278
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        785
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        932
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        636
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        594
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        597
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        264
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        363
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        772
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        835
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        975
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        950
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        703
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        895
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        915
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        942
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        390
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        229
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        954
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        973
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        742
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        905
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        551
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        845
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        676
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        842
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        761
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        758
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        869
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        931
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        651
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        292
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        255
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        554
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        111
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        537
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        908
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        141
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        677
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        201
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        970
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        893
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        927
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        601
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        369
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        872
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        586
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        470
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        852
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        968
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        884
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        112
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        708
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        516
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        688
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        387
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        296
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        922
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        622
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        903
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        362
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        762
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        571
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        645
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        555
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        940
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        406
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        460
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        777
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        976
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        336
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        636
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        920
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        262
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        144
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        309
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        506
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        270
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        103
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        517
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        908
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        181
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        705
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        303
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        483
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        244
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        813
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        847
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        368
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        531
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        906
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        312
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        583
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        804
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        614
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        874
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        788
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        297
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        574
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        367
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        394
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        494
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        141
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        139
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        857
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        212
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        591
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        343
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        626
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        565
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        911
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        696
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        925
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        128
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        941
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        713
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        241
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        933
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        552
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        648
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        463
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        743
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        950
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        155
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        407
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        796
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        756
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        570
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        642
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        576
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        791
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        557
#>     indicator2 indicator3
#> 1          123        363
#> 2          867        494
#> 3          700        131
#> 4          621        499
#> 5          940        686
#> 6          822        965
#> 7          956        557
#> 8          278        238
#> 9          640        107
#> 10         148        821
#> 11         178        569
#> 12         802        473
#> 13         890        552
#> 14         968        178
#> 15         642        296
#> 16         594        767
#> 17         409        239
#> 18         139        572
#> 19         234        384
#> 20         790        786
#> 21         191        127
#> 22         203        820
#> 23         879        196
#> 24         870        972
#> 25         499        983
#> 26         683        355
#> 27         495        693
#> 28         859        859
#> 29         421        403
#> 30         682        481
#> 31         821        579
#> 32         637        250
#> 33         931        291
#> 34         479        494
#> 35         516        637
#> 36         216        490
#> 37         317        297
#> 38         997        248
#> 39         156        652
#> 40         142        665
#> 41         388        416
#> 42         627        801
#> 43         186        738
#> 44         242        559
#> 45         974        621
#> 46         131        611
#> 47         311        173
#> 48         318        415
#> 49         676        126
#> 50         671        901
#> 51         892        269
#> 52         736        682
#> 53         237        282
#> 54         654        919
#> 55         834        143
#> 56         983        752
#> 57         985        639
#> 58         466        723
#> 59         159        474
#> 60         162        829
#> 61         541        805
#> 62         930        812
#> 63         801        141
#> 64         645        105
#> 65         861        144
#> 66         141        157
#> 67         405        837
#> 68         520        549
#> 69         118        844
#> 70         695        900
#> 71         305        116
#> 72         197        932
#> 73         968        767
#> 74         745        836
#> 75         150        924
#> 76         212        853
#> 77         267        390
#> 78         833        115
#> 79         569        450
#> 80         753        140
#> 81         611        623
#> 82         166        496
#> 83         117        849
#> 84         498        456
#> 85         191        427
#> 86         223        969
#> 87         635        798
#> 88         778        160
#> 89         957        996
#> 90         408        503
#> 91         939        781
#> 92         893        518
#> 93         338        181
#> 94         264        650
#> 95         755        113
#> 96         662        845
#> 97         455        306
#> 98         896        389
#> 99         124        632
#> 100        336        105
#> 101        186        482
#> 102        918        781
#> 103        386        672
#> 104        765        554
#> 105        347        905
#> 106        486        582
#> 107        244        647
#> 108        674        454
#> 109        388        329
#> 110        588        135
#> 111        147        557
#> 112        333        403
#> 113        974        362
#> 114        568        302
#> 115        501        595
#> 116        589        560
#> 117        446        956
#> 118        251        492
#> 119        581        820
#> 120        311        926
#> 121        424        783
#> 122        481        977
#> 123        239        277
#> 124        783        854
#> 125        634        877
#> 126        592        736
#> 127        151        208
#> 128        759        788
#> 129        103        113
#> 130        438        240
#> 131        226        718
#> 132        568        237
#> 133        761        360
#> 134        632        771
#> 135        339        840
#> 136        182        494
#> 137        351        979
#> 138        785        170
#> 139        241        666
#> 140        895        667
#> 141        695        915
#> 142        760        414
#> 143        937        937
#> 144        226        981
#> 145        106        143
#> 146        234        306
#> 147        605        895
#> 148        105        168
#> 149        488        616
#> 150        623        112
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
