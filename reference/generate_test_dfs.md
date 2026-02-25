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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        216
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        628
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        279
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        283
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        121
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        706
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        996
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        278
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        785
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        932
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        636
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        594
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        597
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        264
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        363
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        772
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        835
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        975
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        950
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        703
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        895
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        915
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        942
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        390
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        229
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        954
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        973
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        742
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        905
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        551
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        845
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        676
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        842
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        761
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        758
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        869
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        931
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        651
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        292
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        255
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        554
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        111
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        537
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        908
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        141
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        677
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        201
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        970
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        893
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        927
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        601
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        369
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        872
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        586
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        470
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        852
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        968
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        884
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        112
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        708
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        516
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        688
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        387
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        296
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        922
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        622
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        903
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        362
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        762
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        571
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        645
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        555
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        940
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        406
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        460
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        777
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        976
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        336
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        636
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        920
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        262
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        144
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        309
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        506
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        270
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        103
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        517
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        908
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        181
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        705
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        303
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        483
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        244
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        813
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        847
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        368
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        531
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        906
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        312
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        583
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        804
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        614
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        874
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        788
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        297
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        574
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        367
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        394
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        494
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        141
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        139
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        857
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        212
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        591
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        343
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        626
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        565
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        911
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        696
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        925
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        128
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        941
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        583
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        713
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        241
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        933
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        552
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        565
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        648
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        463
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        743
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        950
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        155
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        407
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        796
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        756
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        570
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        642
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        576
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        791
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        557
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        123
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        867
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        700
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        621
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        940
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        822
#>     indicator2 indicator3
#> 1          956        557
#> 2          278        238
#> 3          640        107
#> 4          148        821
#> 5          178        569
#> 6          802        473
#> 7          890        552
#> 8          968        178
#> 9          642        296
#> 10         594        767
#> 11         409        239
#> 12         139        572
#> 13         234        384
#> 14         790        786
#> 15         191        127
#> 16         203        820
#> 17         879        196
#> 18         870        972
#> 19         499        983
#> 20         683        355
#> 21         495        693
#> 22         859        859
#> 23         421        403
#> 24         682        481
#> 25         821        579
#> 26         637        250
#> 27         931        291
#> 28         479        494
#> 29         516        637
#> 30         216        490
#> 31         317        297
#> 32         997        248
#> 33         156        652
#> 34         142        665
#> 35         388        416
#> 36         627        801
#> 37         186        738
#> 38         242        559
#> 39         974        621
#> 40         131        611
#> 41         311        173
#> 42         318        415
#> 43         676        126
#> 44         671        901
#> 45         892        269
#> 46         736        682
#> 47         237        282
#> 48         654        919
#> 49         834        143
#> 50         983        752
#> 51         985        639
#> 52         466        723
#> 53         159        474
#> 54         162        829
#> 55         541        805
#> 56         930        812
#> 57         801        141
#> 58         645        105
#> 59         861        144
#> 60         141        157
#> 61         405        837
#> 62         520        549
#> 63         118        844
#> 64         695        900
#> 65         305        116
#> 66         197        932
#> 67         968        767
#> 68         745        836
#> 69         150        924
#> 70         212        853
#> 71         267        390
#> 72         833        115
#> 73         569        450
#> 74         753        140
#> 75         611        623
#> 76         166        496
#> 77         117        849
#> 78         498        456
#> 79         191        427
#> 80         223        969
#> 81         635        798
#> 82         778        160
#> 83         957        996
#> 84         408        503
#> 85         939        781
#> 86         893        518
#> 87         338        181
#> 88         264        650
#> 89         755        113
#> 90         662        845
#> 91         455        306
#> 92         896        389
#> 93         124        632
#> 94         336        105
#> 95         186        482
#> 96         918        781
#> 97         386        672
#> 98         765        554
#> 99         347        905
#> 100        486        582
#> 101        244        647
#> 102        674        454
#> 103        388        329
#> 104        588        135
#> 105        147        557
#> 106        333        403
#> 107        974        362
#> 108        568        302
#> 109        501        595
#> 110        589        560
#> 111        446        956
#> 112        251        492
#> 113        581        820
#> 114        311        926
#> 115        424        783
#> 116        481        977
#> 117        239        277
#> 118        783        854
#> 119        634        877
#> 120        592        736
#> 121        151        208
#> 122        759        788
#> 123        103        113
#> 124        438        240
#> 125        226        718
#> 126        568        237
#> 127        761        360
#> 128        632        771
#> 129        339        840
#> 130        182        494
#> 131        351        979
#> 132        785        170
#> 133        241        666
#> 134        895        667
#> 135        695        915
#> 136        760        414
#> 137        937        937
#> 138        226        981
#> 139        106        143
#> 140        234        306
#> 141        605        895
#> 142        105        168
#> 143        488        616
#> 144        623        112
#> 145        363        420
#> 146        494        824
#> 147        131        223
#> 148        499        940
#> 149        686        359
#> 150        965        110
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
