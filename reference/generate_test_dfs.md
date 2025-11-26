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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        866
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        635
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        946
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        176
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        997
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        545
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        666
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        526
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        161
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        872
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        568
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        399
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        645
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        546
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        359
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        851
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        773
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        774
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        316
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        825
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        654
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        643
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        169
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        364
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        249
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        365
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        515
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        216
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        628
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        279
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        283
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        121
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        706
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        996
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        169
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        773
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        278
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        785
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        932
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        636
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        594
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        597
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        264
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        363
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        772
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        835
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        975
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        950
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        703
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        895
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        915
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        942
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        390
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        229
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        954
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        973
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        742
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        905
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        551
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        845
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        676
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        842
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        761
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        758
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        869
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        931
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        651
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        292
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        255
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        554
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        111
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        537
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        908
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        141
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        677
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        201
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        970
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        893
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        927
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        601
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        369
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        872
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        586
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        470
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        852
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        968
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        884
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        112
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        708
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        516
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        688
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        387
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        296
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        922
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        622
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        903
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        362
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        762
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        571
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        645
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        555
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        940
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        460
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        777
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        976
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        336
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        636
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        920
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        262
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        144
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        309
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        506
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        270
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        103
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        517
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        908
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        181
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        705
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        303
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        406
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        483
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        244
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        813
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        847
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        368
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        531
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        906
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        312
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        804
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        614
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        874
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        788
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        297
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        574
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        367
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        394
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        494
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        141
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        139
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        857
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        212
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        591
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        343
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        626
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        911
#>     indicator2 indicator3
#> 1          696        759
#> 2          925        103
#> 3          128        438
#> 4          941        226
#> 5          583        568
#> 6          713        761
#> 7          241        632
#> 8          933        339
#> 9          552        182
#> 10         565        351
#> 11         648        785
#> 12         463        241
#> 13         743        895
#> 14         950        695
#> 15         155        760
#> 16         407        937
#> 17         796        226
#> 18         756        106
#> 19         570        234
#> 20         642        605
#> 21         576        105
#> 22         791        488
#> 23         557        623
#> 24         123        363
#> 25         867        494
#> 26         700        131
#> 27         621        499
#> 28         940        686
#> 29         822        965
#> 30         956        557
#> 31         278        238
#> 32         640        107
#> 33         148        821
#> 34         178        569
#> 35         802        473
#> 36         890        552
#> 37         968        178
#> 38         642        296
#> 39         594        767
#> 40         409        239
#> 41         139        572
#> 42         234        384
#> 43         790        786
#> 44         191        127
#> 45         203        820
#> 46         879        196
#> 47         870        972
#> 48         499        983
#> 49         683        355
#> 50         495        693
#> 51         859        859
#> 52         421        403
#> 53         682        481
#> 54         821        579
#> 55         637        250
#> 56         931        291
#> 57         479        494
#> 58         516        637
#> 59         216        490
#> 60         317        297
#> 61         997        248
#> 62         156        652
#> 63         142        665
#> 64         388        416
#> 65         627        801
#> 66         186        738
#> 67         242        559
#> 68         974        621
#> 69         131        611
#> 70         311        173
#> 71         318        415
#> 72         676        126
#> 73         671        901
#> 74         892        269
#> 75         736        682
#> 76         237        282
#> 77         654        919
#> 78         834        143
#> 79         983        752
#> 80         985        639
#> 81         466        723
#> 82         159        474
#> 83         162        829
#> 84         541        805
#> 85         930        812
#> 86         801        141
#> 87         645        105
#> 88         861        144
#> 89         141        157
#> 90         405        837
#> 91         520        549
#> 92         118        844
#> 93         695        900
#> 94         305        116
#> 95         197        932
#> 96         968        767
#> 97         745        836
#> 98         150        924
#> 99         212        853
#> 100        267        390
#> 101        833        115
#> 102        569        450
#> 103        753        140
#> 104        611        623
#> 105        166        496
#> 106        117        849
#> 107        498        456
#> 108        191        427
#> 109        223        969
#> 110        635        798
#> 111        778        160
#> 112        957        996
#> 113        408        503
#> 114        939        781
#> 115        893        518
#> 116        338        181
#> 117        264        650
#> 118        755        113
#> 119        662        845
#> 120        455        306
#> 121        896        389
#> 122        124        632
#> 123        336        105
#> 124        186        482
#> 125        918        781
#> 126        386        672
#> 127        765        554
#> 128        347        905
#> 129        486        582
#> 130        244        647
#> 131        674        454
#> 132        388        329
#> 133        588        135
#> 134        147        557
#> 135        333        403
#> 136        974        362
#> 137        568        302
#> 138        501        595
#> 139        589        560
#> 140        446        956
#> 141        251        492
#> 142        581        820
#> 143        311        926
#> 144        424        783
#> 145        481        977
#> 146        239        277
#> 147        783        854
#> 148        634        877
#> 149        592        736
#> 150        151        208
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
