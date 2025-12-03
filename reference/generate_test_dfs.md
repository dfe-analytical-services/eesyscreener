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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        946
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        176
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        997
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        545
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        666
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        526
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        161
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        872
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        568
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        399
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        645
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        546
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        359
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        851
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        774
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        316
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        825
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        654
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        643
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        364
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        249
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        365
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        515
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        216
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        628
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        279
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        283
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        121
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        706
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        996
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        169
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        773
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        278
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        785
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        932
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        636
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        594
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        597
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        264
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        363
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        772
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        835
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        975
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        950
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        703
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        895
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        915
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        942
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        390
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        229
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        954
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        973
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        742
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        905
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        551
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        845
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        676
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        842
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        761
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        758
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        869
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        931
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        651
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        292
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        255
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        554
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        111
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        537
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        908
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        141
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        677
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        201
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        970
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        893
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        927
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        601
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        369
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        872
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        586
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        470
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        852
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        968
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        884
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        112
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        708
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        516
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        688
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        387
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        296
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        922
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        622
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        903
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        362
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        762
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        571
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        645
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        555
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        940
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        460
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        777
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        976
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        336
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        636
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        920
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        262
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        144
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        309
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        506
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        270
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        103
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        517
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        908
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        181
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        705
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        303
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        406
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        483
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        244
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        813
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        847
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        368
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        531
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        906
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        312
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        804
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        614
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        874
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        788
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        297
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        574
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        367
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        394
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        494
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        141
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        139
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        857
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        212
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        591
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        343
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        626
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        911
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        696
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        925
#>     indicator2 indicator3
#> 1          128        438
#> 2          941        226
#> 3          583        568
#> 4          713        761
#> 5          241        632
#> 6          933        339
#> 7          552        182
#> 8          565        351
#> 9          648        785
#> 10         463        241
#> 11         743        895
#> 12         950        695
#> 13         155        760
#> 14         407        937
#> 15         796        226
#> 16         756        106
#> 17         570        234
#> 18         642        605
#> 19         576        105
#> 20         791        488
#> 21         557        623
#> 22         123        363
#> 23         867        494
#> 24         700        131
#> 25         621        499
#> 26         940        686
#> 27         822        965
#> 28         956        557
#> 29         278        238
#> 30         640        107
#> 31         148        821
#> 32         178        569
#> 33         802        473
#> 34         890        552
#> 35         968        178
#> 36         642        296
#> 37         594        767
#> 38         409        239
#> 39         139        572
#> 40         234        384
#> 41         790        786
#> 42         191        127
#> 43         203        820
#> 44         879        196
#> 45         870        972
#> 46         499        983
#> 47         683        355
#> 48         495        693
#> 49         859        859
#> 50         421        403
#> 51         682        481
#> 52         821        579
#> 53         637        250
#> 54         931        291
#> 55         479        494
#> 56         516        637
#> 57         216        490
#> 58         317        297
#> 59         997        248
#> 60         156        652
#> 61         142        665
#> 62         388        416
#> 63         627        801
#> 64         186        738
#> 65         242        559
#> 66         974        621
#> 67         131        611
#> 68         311        173
#> 69         318        415
#> 70         676        126
#> 71         671        901
#> 72         892        269
#> 73         736        682
#> 74         237        282
#> 75         654        919
#> 76         834        143
#> 77         983        752
#> 78         985        639
#> 79         466        723
#> 80         159        474
#> 81         162        829
#> 82         541        805
#> 83         930        812
#> 84         801        141
#> 85         645        105
#> 86         861        144
#> 87         141        157
#> 88         405        837
#> 89         520        549
#> 90         118        844
#> 91         695        900
#> 92         305        116
#> 93         197        932
#> 94         968        767
#> 95         745        836
#> 96         150        924
#> 97         212        853
#> 98         267        390
#> 99         833        115
#> 100        569        450
#> 101        753        140
#> 102        611        623
#> 103        166        496
#> 104        117        849
#> 105        498        456
#> 106        191        427
#> 107        223        969
#> 108        635        798
#> 109        778        160
#> 110        957        996
#> 111        408        503
#> 112        939        781
#> 113        893        518
#> 114        338        181
#> 115        264        650
#> 116        755        113
#> 117        662        845
#> 118        455        306
#> 119        896        389
#> 120        124        632
#> 121        336        105
#> 122        186        482
#> 123        918        781
#> 124        386        672
#> 125        765        554
#> 126        347        905
#> 127        486        582
#> 128        244        647
#> 129        674        454
#> 130        388        329
#> 131        588        135
#> 132        147        557
#> 133        333        403
#> 134        974        362
#> 135        568        302
#> 136        501        595
#> 137        589        560
#> 138        446        956
#> 139        251        492
#> 140        581        820
#> 141        311        926
#> 142        424        783
#> 143        481        977
#> 144        239        277
#> 145        783        854
#> 146        634        877
#> 147        592        736
#> 148        151        208
#> 149        759        788
#> 150        103        113
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
