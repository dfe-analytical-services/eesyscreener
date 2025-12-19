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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        872
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        568
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        399
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        645
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        546
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        359
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        851
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        774
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        316
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        825
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        654
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        643
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        364
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        249
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        365
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        515
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        216
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        628
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        279
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        283
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        121
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        706
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        996
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        169
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        773
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        278
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        785
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        932
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        636
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        594
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        597
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        264
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        363
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        772
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        835
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        975
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        950
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        703
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        895
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        915
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        942
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        390
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        229
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        954
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        973
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        742
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        905
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        551
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        845
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        676
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        842
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        761
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        758
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        869
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        931
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        651
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        292
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        255
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        554
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        111
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        537
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        908
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        141
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        677
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        201
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        970
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        893
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        927
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        601
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        369
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        872
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        586
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        470
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        852
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        968
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        884
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        112
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        708
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        516
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        688
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        387
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        296
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        922
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        622
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        903
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        362
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        762
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        571
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        645
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        555
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        940
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        460
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        777
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        976
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        336
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        636
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        920
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        262
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        144
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        309
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        506
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        270
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        103
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        517
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        908
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        181
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        705
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        303
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        406
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        483
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        244
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        813
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        847
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        368
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        531
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        906
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        312
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        583
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        804
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        614
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        874
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        788
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        297
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        574
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        367
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        394
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        494
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        141
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        139
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        857
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        212
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        591
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        343
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        626
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        911
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        696
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        925
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        128
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        941
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        583
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        713
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        241
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        933
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        552
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        565
#>     indicator2 indicator3
#> 1          648        785
#> 2          463        241
#> 3          743        895
#> 4          950        695
#> 5          155        760
#> 6          407        937
#> 7          796        226
#> 8          756        106
#> 9          570        234
#> 10         642        605
#> 11         576        105
#> 12         791        488
#> 13         557        623
#> 14         123        363
#> 15         867        494
#> 16         700        131
#> 17         621        499
#> 18         940        686
#> 19         822        965
#> 20         956        557
#> 21         278        238
#> 22         640        107
#> 23         148        821
#> 24         178        569
#> 25         802        473
#> 26         890        552
#> 27         968        178
#> 28         642        296
#> 29         594        767
#> 30         409        239
#> 31         139        572
#> 32         234        384
#> 33         790        786
#> 34         191        127
#> 35         203        820
#> 36         879        196
#> 37         870        972
#> 38         499        983
#> 39         683        355
#> 40         495        693
#> 41         859        859
#> 42         421        403
#> 43         682        481
#> 44         821        579
#> 45         637        250
#> 46         931        291
#> 47         479        494
#> 48         516        637
#> 49         216        490
#> 50         317        297
#> 51         997        248
#> 52         156        652
#> 53         142        665
#> 54         388        416
#> 55         627        801
#> 56         186        738
#> 57         242        559
#> 58         974        621
#> 59         131        611
#> 60         311        173
#> 61         318        415
#> 62         676        126
#> 63         671        901
#> 64         892        269
#> 65         736        682
#> 66         237        282
#> 67         654        919
#> 68         834        143
#> 69         983        752
#> 70         985        639
#> 71         466        723
#> 72         159        474
#> 73         162        829
#> 74         541        805
#> 75         930        812
#> 76         801        141
#> 77         645        105
#> 78         861        144
#> 79         141        157
#> 80         405        837
#> 81         520        549
#> 82         118        844
#> 83         695        900
#> 84         305        116
#> 85         197        932
#> 86         968        767
#> 87         745        836
#> 88         150        924
#> 89         212        853
#> 90         267        390
#> 91         833        115
#> 92         569        450
#> 93         753        140
#> 94         611        623
#> 95         166        496
#> 96         117        849
#> 97         498        456
#> 98         191        427
#> 99         223        969
#> 100        635        798
#> 101        778        160
#> 102        957        996
#> 103        408        503
#> 104        939        781
#> 105        893        518
#> 106        338        181
#> 107        264        650
#> 108        755        113
#> 109        662        845
#> 110        455        306
#> 111        896        389
#> 112        124        632
#> 113        336        105
#> 114        186        482
#> 115        918        781
#> 116        386        672
#> 117        765        554
#> 118        347        905
#> 119        486        582
#> 120        244        647
#> 121        674        454
#> 122        388        329
#> 123        588        135
#> 124        147        557
#> 125        333        403
#> 126        974        362
#> 127        568        302
#> 128        501        595
#> 129        589        560
#> 130        446        956
#> 131        251        492
#> 132        581        820
#> 133        311        926
#> 134        424        783
#> 135        481        977
#> 136        239        277
#> 137        783        854
#> 138        634        877
#> 139        592        736
#> 140        151        208
#> 141        759        788
#> 142        103        113
#> 143        438        240
#> 144        226        718
#> 145        568        237
#> 146        761        360
#> 147        632        771
#> 148        339        840
#> 149        182        494
#> 150        351        979
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
