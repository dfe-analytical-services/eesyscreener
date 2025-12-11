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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        666
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        526
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        161
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        872
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        568
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        399
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        645
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        546
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        359
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        851
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        774
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        316
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        825
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        654
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        643
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        364
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        249
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        365
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        515
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        216
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        628
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        279
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        283
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        121
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        706
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        996
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        169
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        773
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        278
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        785
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        932
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        636
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        594
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        597
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        264
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        363
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        772
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        835
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        975
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        950
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        703
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        895
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        915
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        942
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        390
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        229
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        954
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        973
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        742
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        905
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        551
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        845
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        676
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        842
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        761
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        758
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        869
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        931
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        651
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        292
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        255
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        554
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        111
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        537
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        908
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        141
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        677
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        201
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        970
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        893
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        927
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        601
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        369
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        872
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        586
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        470
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        852
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        968
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        884
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        112
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        708
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        516
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        688
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        387
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        296
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        922
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        622
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        903
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        362
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        762
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        571
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        645
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        555
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        940
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        460
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        777
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        976
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        336
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        636
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        920
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        262
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        144
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        309
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        506
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        270
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        103
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        517
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        908
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        181
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        705
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        303
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        406
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        483
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        244
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        813
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        847
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        368
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        531
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        906
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        312
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        583
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        804
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        614
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        874
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        788
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        297
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        574
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        367
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        394
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        494
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        141
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        139
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        857
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        212
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        591
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        343
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        626
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        911
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        696
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        925
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        128
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        941
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        583
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        713
#>     indicator2 indicator3
#> 1          241        632
#> 2          933        339
#> 3          552        182
#> 4          565        351
#> 5          648        785
#> 6          463        241
#> 7          743        895
#> 8          950        695
#> 9          155        760
#> 10         407        937
#> 11         796        226
#> 12         756        106
#> 13         570        234
#> 14         642        605
#> 15         576        105
#> 16         791        488
#> 17         557        623
#> 18         123        363
#> 19         867        494
#> 20         700        131
#> 21         621        499
#> 22         940        686
#> 23         822        965
#> 24         956        557
#> 25         278        238
#> 26         640        107
#> 27         148        821
#> 28         178        569
#> 29         802        473
#> 30         890        552
#> 31         968        178
#> 32         642        296
#> 33         594        767
#> 34         409        239
#> 35         139        572
#> 36         234        384
#> 37         790        786
#> 38         191        127
#> 39         203        820
#> 40         879        196
#> 41         870        972
#> 42         499        983
#> 43         683        355
#> 44         495        693
#> 45         859        859
#> 46         421        403
#> 47         682        481
#> 48         821        579
#> 49         637        250
#> 50         931        291
#> 51         479        494
#> 52         516        637
#> 53         216        490
#> 54         317        297
#> 55         997        248
#> 56         156        652
#> 57         142        665
#> 58         388        416
#> 59         627        801
#> 60         186        738
#> 61         242        559
#> 62         974        621
#> 63         131        611
#> 64         311        173
#> 65         318        415
#> 66         676        126
#> 67         671        901
#> 68         892        269
#> 69         736        682
#> 70         237        282
#> 71         654        919
#> 72         834        143
#> 73         983        752
#> 74         985        639
#> 75         466        723
#> 76         159        474
#> 77         162        829
#> 78         541        805
#> 79         930        812
#> 80         801        141
#> 81         645        105
#> 82         861        144
#> 83         141        157
#> 84         405        837
#> 85         520        549
#> 86         118        844
#> 87         695        900
#> 88         305        116
#> 89         197        932
#> 90         968        767
#> 91         745        836
#> 92         150        924
#> 93         212        853
#> 94         267        390
#> 95         833        115
#> 96         569        450
#> 97         753        140
#> 98         611        623
#> 99         166        496
#> 100        117        849
#> 101        498        456
#> 102        191        427
#> 103        223        969
#> 104        635        798
#> 105        778        160
#> 106        957        996
#> 107        408        503
#> 108        939        781
#> 109        893        518
#> 110        338        181
#> 111        264        650
#> 112        755        113
#> 113        662        845
#> 114        455        306
#> 115        896        389
#> 116        124        632
#> 117        336        105
#> 118        186        482
#> 119        918        781
#> 120        386        672
#> 121        765        554
#> 122        347        905
#> 123        486        582
#> 124        244        647
#> 125        674        454
#> 126        388        329
#> 127        588        135
#> 128        147        557
#> 129        333        403
#> 130        974        362
#> 131        568        302
#> 132        501        595
#> 133        589        560
#> 134        446        956
#> 135        251        492
#> 136        581        820
#> 137        311        926
#> 138        424        783
#> 139        481        977
#> 140        239        277
#> 141        783        854
#> 142        634        877
#> 143        592        736
#> 144        151        208
#> 145        759        788
#> 146        103        113
#> 147        438        240
#> 148        226        718
#> 149        568        237
#> 150        761        360
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
