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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        643
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        364
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        249
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        365
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        515
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        216
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        628
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        279
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        283
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        121
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        706
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        996
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        278
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        785
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        932
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        636
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        594
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        597
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        264
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        363
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        772
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        835
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        975
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        950
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        703
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        895
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        915
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        942
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        390
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        229
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        954
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        973
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        742
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        905
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        551
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        845
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        676
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        842
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        761
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        758
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        869
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        931
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        651
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        292
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        255
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        554
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        111
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        537
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        908
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        141
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        677
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        201
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        970
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        893
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        927
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        601
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        369
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        872
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        586
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        470
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        852
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        968
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        884
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        112
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        708
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        516
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        688
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        387
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        296
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        922
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        622
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        903
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        362
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        762
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        571
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        645
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        555
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        940
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        406
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        460
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        777
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        976
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        336
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        636
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        920
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        262
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        144
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        309
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        506
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        270
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        103
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        517
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        908
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        181
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        705
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        303
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        483
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        244
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        813
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        847
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        368
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        531
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        906
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        312
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        583
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        804
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        614
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        874
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        788
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        297
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        574
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        367
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        394
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        494
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        141
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        139
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        857
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        212
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        591
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        343
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        626
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        565
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        911
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        696
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        925
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        128
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        941
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        583
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        713
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        241
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        933
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        552
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        648
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        463
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        743
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        950
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        155
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        407
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        796
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        756
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        570
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        642
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        576
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        791
#>     indicator2 indicator3
#> 1          557        623
#> 2          123        363
#> 3          867        494
#> 4          700        131
#> 5          621        499
#> 6          940        686
#> 7          822        965
#> 8          956        557
#> 9          278        238
#> 10         640        107
#> 11         148        821
#> 12         178        569
#> 13         802        473
#> 14         890        552
#> 15         968        178
#> 16         642        296
#> 17         594        767
#> 18         409        239
#> 19         139        572
#> 20         234        384
#> 21         790        786
#> 22         191        127
#> 23         203        820
#> 24         879        196
#> 25         870        972
#> 26         499        983
#> 27         683        355
#> 28         495        693
#> 29         859        859
#> 30         421        403
#> 31         682        481
#> 32         821        579
#> 33         637        250
#> 34         931        291
#> 35         479        494
#> 36         516        637
#> 37         216        490
#> 38         317        297
#> 39         997        248
#> 40         156        652
#> 41         142        665
#> 42         388        416
#> 43         627        801
#> 44         186        738
#> 45         242        559
#> 46         974        621
#> 47         131        611
#> 48         311        173
#> 49         318        415
#> 50         676        126
#> 51         671        901
#> 52         892        269
#> 53         736        682
#> 54         237        282
#> 55         654        919
#> 56         834        143
#> 57         983        752
#> 58         985        639
#> 59         466        723
#> 60         159        474
#> 61         162        829
#> 62         541        805
#> 63         930        812
#> 64         801        141
#> 65         645        105
#> 66         861        144
#> 67         141        157
#> 68         405        837
#> 69         520        549
#> 70         118        844
#> 71         695        900
#> 72         305        116
#> 73         197        932
#> 74         968        767
#> 75         745        836
#> 76         150        924
#> 77         212        853
#> 78         267        390
#> 79         833        115
#> 80         569        450
#> 81         753        140
#> 82         611        623
#> 83         166        496
#> 84         117        849
#> 85         498        456
#> 86         191        427
#> 87         223        969
#> 88         635        798
#> 89         778        160
#> 90         957        996
#> 91         408        503
#> 92         939        781
#> 93         893        518
#> 94         338        181
#> 95         264        650
#> 96         755        113
#> 97         662        845
#> 98         455        306
#> 99         896        389
#> 100        124        632
#> 101        336        105
#> 102        186        482
#> 103        918        781
#> 104        386        672
#> 105        765        554
#> 106        347        905
#> 107        486        582
#> 108        244        647
#> 109        674        454
#> 110        388        329
#> 111        588        135
#> 112        147        557
#> 113        333        403
#> 114        974        362
#> 115        568        302
#> 116        501        595
#> 117        589        560
#> 118        446        956
#> 119        251        492
#> 120        581        820
#> 121        311        926
#> 122        424        783
#> 123        481        977
#> 124        239        277
#> 125        783        854
#> 126        634        877
#> 127        592        736
#> 128        151        208
#> 129        759        788
#> 130        103        113
#> 131        438        240
#> 132        226        718
#> 133        568        237
#> 134        761        360
#> 135        632        771
#> 136        339        840
#> 137        182        494
#> 138        351        979
#> 139        785        170
#> 140        241        666
#> 141        895        667
#> 142        695        915
#> 143        760        414
#> 144        937        937
#> 145        226        981
#> 146        106        143
#> 147        234        306
#> 148        605        895
#> 149        105        168
#> 150        488        616
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
