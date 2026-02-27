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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        283
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        121
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        706
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        996
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        773
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        278
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        785
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        932
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        636
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        594
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        597
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        264
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        363
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        772
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        835
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        975
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        950
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        703
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        895
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        915
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        942
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        390
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        229
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        954
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        973
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        742
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        905
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        551
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        845
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        676
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        842
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        761
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        758
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        869
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        931
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        651
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        292
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        255
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        554
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        111
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        537
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        908
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        141
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        677
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        201
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        970
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        893
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        927
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        601
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        369
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        872
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        586
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        470
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        852
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        968
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        884
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        112
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        708
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        516
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        688
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        387
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        296
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        922
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        622
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        903
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        362
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        762
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        571
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        645
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        555
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        940
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        406
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        460
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        777
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        976
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        336
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        636
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        920
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        262
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        144
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        309
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        506
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        270
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        103
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        517
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        908
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        181
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        705
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        303
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        483
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        244
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        813
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        847
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        368
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        531
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        906
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        312
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        583
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        804
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        614
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        874
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        788
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        297
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        574
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        367
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        394
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        494
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        141
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        139
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        857
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        212
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        591
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        343
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        626
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        565
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        911
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        696
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        925
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        128
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        941
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        583
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        713
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        241
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        933
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        552
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        565
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        648
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        463
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        743
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        950
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        155
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        407
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        796
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        756
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        570
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        642
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        576
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        791
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        557
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        123
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        867
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        700
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        621
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        940
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        822
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        956
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        278
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        640
#>     indicator2 indicator3
#> 1          148        821
#> 2          178        569
#> 3          802        473
#> 4          890        552
#> 5          968        178
#> 6          642        296
#> 7          594        767
#> 8          409        239
#> 9          139        572
#> 10         234        384
#> 11         790        786
#> 12         191        127
#> 13         203        820
#> 14         879        196
#> 15         870        972
#> 16         499        983
#> 17         683        355
#> 18         495        693
#> 19         859        859
#> 20         421        403
#> 21         682        481
#> 22         821        579
#> 23         637        250
#> 24         931        291
#> 25         479        494
#> 26         516        637
#> 27         216        490
#> 28         317        297
#> 29         997        248
#> 30         156        652
#> 31         142        665
#> 32         388        416
#> 33         627        801
#> 34         186        738
#> 35         242        559
#> 36         974        621
#> 37         131        611
#> 38         311        173
#> 39         318        415
#> 40         676        126
#> 41         671        901
#> 42         892        269
#> 43         736        682
#> 44         237        282
#> 45         654        919
#> 46         834        143
#> 47         983        752
#> 48         985        639
#> 49         466        723
#> 50         159        474
#> 51         162        829
#> 52         541        805
#> 53         930        812
#> 54         801        141
#> 55         645        105
#> 56         861        144
#> 57         141        157
#> 58         405        837
#> 59         520        549
#> 60         118        844
#> 61         695        900
#> 62         305        116
#> 63         197        932
#> 64         968        767
#> 65         745        836
#> 66         150        924
#> 67         212        853
#> 68         267        390
#> 69         833        115
#> 70         569        450
#> 71         753        140
#> 72         611        623
#> 73         166        496
#> 74         117        849
#> 75         498        456
#> 76         191        427
#> 77         223        969
#> 78         635        798
#> 79         778        160
#> 80         957        996
#> 81         408        503
#> 82         939        781
#> 83         893        518
#> 84         338        181
#> 85         264        650
#> 86         755        113
#> 87         662        845
#> 88         455        306
#> 89         896        389
#> 90         124        632
#> 91         336        105
#> 92         186        482
#> 93         918        781
#> 94         386        672
#> 95         765        554
#> 96         347        905
#> 97         486        582
#> 98         244        647
#> 99         674        454
#> 100        388        329
#> 101        588        135
#> 102        147        557
#> 103        333        403
#> 104        974        362
#> 105        568        302
#> 106        501        595
#> 107        589        560
#> 108        446        956
#> 109        251        492
#> 110        581        820
#> 111        311        926
#> 112        424        783
#> 113        481        977
#> 114        239        277
#> 115        783        854
#> 116        634        877
#> 117        592        736
#> 118        151        208
#> 119        759        788
#> 120        103        113
#> 121        438        240
#> 122        226        718
#> 123        568        237
#> 124        761        360
#> 125        632        771
#> 126        339        840
#> 127        182        494
#> 128        351        979
#> 129        785        170
#> 130        241        666
#> 131        895        667
#> 132        695        915
#> 133        760        414
#> 134        937        937
#> 135        226        981
#> 136        106        143
#> 137        234        306
#> 138        605        895
#> 139        105        168
#> 140        488        616
#> 141        623        112
#> 142        363        420
#> 143        494        824
#> 144        131        223
#> 145        499        940
#> 146        686        359
#> 147        965        110
#> 148        557        131
#> 149        238        337
#> 150        107        569
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
