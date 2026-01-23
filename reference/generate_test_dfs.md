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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        773
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        774
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        316
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        825
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        643
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        364
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        249
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        365
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        515
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        216
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        628
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        279
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        283
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        121
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        706
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        996
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        773
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        278
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        785
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        932
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        636
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        594
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        597
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        264
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        363
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        772
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        835
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        975
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        950
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        703
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        895
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        915
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        942
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        390
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        229
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        954
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        973
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        742
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        905
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        551
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        845
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        676
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        842
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        761
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        758
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        869
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        931
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        651
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        292
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        255
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        554
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        111
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        537
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        908
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        141
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        677
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        201
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        970
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        893
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        927
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        601
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        369
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        872
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        586
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        470
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        852
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        968
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        884
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        112
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        708
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        516
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        688
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        387
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        296
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        922
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        622
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        903
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        362
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        762
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        571
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        645
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        555
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        940
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        406
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        460
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        777
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        976
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        336
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        636
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        920
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        262
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        144
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        309
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        506
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        270
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        103
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        517
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        908
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        181
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        705
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        303
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        483
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        244
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        813
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        847
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        368
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        531
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        906
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        312
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        583
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        804
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        614
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        874
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        788
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        297
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        574
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        367
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        394
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        494
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        141
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        139
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        857
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        212
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        591
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        343
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        626
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        565
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        911
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        696
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        925
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        128
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        941
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        583
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        713
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        241
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        933
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        552
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        648
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        463
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        743
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        950
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        155
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        407
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        796
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        756
#>     indicator2 indicator3
#> 1          570        234
#> 2          642        605
#> 3          576        105
#> 4          791        488
#> 5          557        623
#> 6          123        363
#> 7          867        494
#> 8          700        131
#> 9          621        499
#> 10         940        686
#> 11         822        965
#> 12         956        557
#> 13         278        238
#> 14         640        107
#> 15         148        821
#> 16         178        569
#> 17         802        473
#> 18         890        552
#> 19         968        178
#> 20         642        296
#> 21         594        767
#> 22         409        239
#> 23         139        572
#> 24         234        384
#> 25         790        786
#> 26         191        127
#> 27         203        820
#> 28         879        196
#> 29         870        972
#> 30         499        983
#> 31         683        355
#> 32         495        693
#> 33         859        859
#> 34         421        403
#> 35         682        481
#> 36         821        579
#> 37         637        250
#> 38         931        291
#> 39         479        494
#> 40         516        637
#> 41         216        490
#> 42         317        297
#> 43         997        248
#> 44         156        652
#> 45         142        665
#> 46         388        416
#> 47         627        801
#> 48         186        738
#> 49         242        559
#> 50         974        621
#> 51         131        611
#> 52         311        173
#> 53         318        415
#> 54         676        126
#> 55         671        901
#> 56         892        269
#> 57         736        682
#> 58         237        282
#> 59         654        919
#> 60         834        143
#> 61         983        752
#> 62         985        639
#> 63         466        723
#> 64         159        474
#> 65         162        829
#> 66         541        805
#> 67         930        812
#> 68         801        141
#> 69         645        105
#> 70         861        144
#> 71         141        157
#> 72         405        837
#> 73         520        549
#> 74         118        844
#> 75         695        900
#> 76         305        116
#> 77         197        932
#> 78         968        767
#> 79         745        836
#> 80         150        924
#> 81         212        853
#> 82         267        390
#> 83         833        115
#> 84         569        450
#> 85         753        140
#> 86         611        623
#> 87         166        496
#> 88         117        849
#> 89         498        456
#> 90         191        427
#> 91         223        969
#> 92         635        798
#> 93         778        160
#> 94         957        996
#> 95         408        503
#> 96         939        781
#> 97         893        518
#> 98         338        181
#> 99         264        650
#> 100        755        113
#> 101        662        845
#> 102        455        306
#> 103        896        389
#> 104        124        632
#> 105        336        105
#> 106        186        482
#> 107        918        781
#> 108        386        672
#> 109        765        554
#> 110        347        905
#> 111        486        582
#> 112        244        647
#> 113        674        454
#> 114        388        329
#> 115        588        135
#> 116        147        557
#> 117        333        403
#> 118        974        362
#> 119        568        302
#> 120        501        595
#> 121        589        560
#> 122        446        956
#> 123        251        492
#> 124        581        820
#> 125        311        926
#> 126        424        783
#> 127        481        977
#> 128        239        277
#> 129        783        854
#> 130        634        877
#> 131        592        736
#> 132        151        208
#> 133        759        788
#> 134        103        113
#> 135        438        240
#> 136        226        718
#> 137        568        237
#> 138        761        360
#> 139        632        771
#> 140        339        840
#> 141        182        494
#> 142        351        979
#> 143        785        170
#> 144        241        666
#> 145        895        667
#> 146        695        915
#> 147        760        414
#> 148        937        937
#> 149        226        981
#> 150        106        143
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
