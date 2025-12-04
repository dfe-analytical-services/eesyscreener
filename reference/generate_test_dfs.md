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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        997
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        545
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        666
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        526
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        161
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        872
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        568
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        399
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        645
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        546
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        359
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        851
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        774
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        316
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        825
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        654
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        643
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        364
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        249
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        365
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        515
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        216
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        628
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        279
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        283
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        121
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        706
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        996
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        169
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        773
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        278
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        785
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        932
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        636
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        594
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        597
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        264
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        363
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        772
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        835
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        975
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        950
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        703
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        895
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        915
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        942
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        390
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        229
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        954
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        973
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        742
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        905
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        551
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        845
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        676
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        842
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        761
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        758
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        869
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        931
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        651
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        292
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        255
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        554
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        111
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        537
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        908
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        141
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        677
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        201
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        970
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        893
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        927
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        601
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        369
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        872
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        586
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        470
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        852
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        968
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        884
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        112
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        708
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        516
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        688
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        387
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        296
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        922
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        622
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        903
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        362
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        762
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        571
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        645
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        555
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        940
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        460
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        777
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        976
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        336
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        636
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        920
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        262
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        144
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        309
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        506
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        270
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        103
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        517
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        908
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        181
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        705
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        303
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        406
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        483
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        244
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        813
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        847
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        368
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        531
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        906
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        312
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        583
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        804
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        614
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        874
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        788
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        297
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        574
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        367
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        394
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        494
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        141
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        139
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        857
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        212
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        591
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        343
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        626
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        911
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        696
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        925
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        128
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        941
#>     indicator2 indicator3
#> 1          583        568
#> 2          713        761
#> 3          241        632
#> 4          933        339
#> 5          552        182
#> 6          565        351
#> 7          648        785
#> 8          463        241
#> 9          743        895
#> 10         950        695
#> 11         155        760
#> 12         407        937
#> 13         796        226
#> 14         756        106
#> 15         570        234
#> 16         642        605
#> 17         576        105
#> 18         791        488
#> 19         557        623
#> 20         123        363
#> 21         867        494
#> 22         700        131
#> 23         621        499
#> 24         940        686
#> 25         822        965
#> 26         956        557
#> 27         278        238
#> 28         640        107
#> 29         148        821
#> 30         178        569
#> 31         802        473
#> 32         890        552
#> 33         968        178
#> 34         642        296
#> 35         594        767
#> 36         409        239
#> 37         139        572
#> 38         234        384
#> 39         790        786
#> 40         191        127
#> 41         203        820
#> 42         879        196
#> 43         870        972
#> 44         499        983
#> 45         683        355
#> 46         495        693
#> 47         859        859
#> 48         421        403
#> 49         682        481
#> 50         821        579
#> 51         637        250
#> 52         931        291
#> 53         479        494
#> 54         516        637
#> 55         216        490
#> 56         317        297
#> 57         997        248
#> 58         156        652
#> 59         142        665
#> 60         388        416
#> 61         627        801
#> 62         186        738
#> 63         242        559
#> 64         974        621
#> 65         131        611
#> 66         311        173
#> 67         318        415
#> 68         676        126
#> 69         671        901
#> 70         892        269
#> 71         736        682
#> 72         237        282
#> 73         654        919
#> 74         834        143
#> 75         983        752
#> 76         985        639
#> 77         466        723
#> 78         159        474
#> 79         162        829
#> 80         541        805
#> 81         930        812
#> 82         801        141
#> 83         645        105
#> 84         861        144
#> 85         141        157
#> 86         405        837
#> 87         520        549
#> 88         118        844
#> 89         695        900
#> 90         305        116
#> 91         197        932
#> 92         968        767
#> 93         745        836
#> 94         150        924
#> 95         212        853
#> 96         267        390
#> 97         833        115
#> 98         569        450
#> 99         753        140
#> 100        611        623
#> 101        166        496
#> 102        117        849
#> 103        498        456
#> 104        191        427
#> 105        223        969
#> 106        635        798
#> 107        778        160
#> 108        957        996
#> 109        408        503
#> 110        939        781
#> 111        893        518
#> 112        338        181
#> 113        264        650
#> 114        755        113
#> 115        662        845
#> 116        455        306
#> 117        896        389
#> 118        124        632
#> 119        336        105
#> 120        186        482
#> 121        918        781
#> 122        386        672
#> 123        765        554
#> 124        347        905
#> 125        486        582
#> 126        244        647
#> 127        674        454
#> 128        388        329
#> 129        588        135
#> 130        147        557
#> 131        333        403
#> 132        974        362
#> 133        568        302
#> 134        501        595
#> 135        589        560
#> 136        446        956
#> 137        251        492
#> 138        581        820
#> 139        311        926
#> 140        424        783
#> 141        481        977
#> 142        239        277
#> 143        783        854
#> 144        634        877
#> 145        592        736
#> 146        151        208
#> 147        759        788
#> 148        103        113
#> 149        438        240
#> 150        226        718
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
