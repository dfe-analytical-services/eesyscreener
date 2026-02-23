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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        316
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        825
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        643
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        364
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        249
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        365
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        515
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        216
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        628
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        279
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        283
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        121
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        706
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        996
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        773
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        278
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        785
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        932
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        636
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        594
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        597
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        264
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        363
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        772
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        835
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        975
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        950
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        703
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        895
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        915
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        942
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        390
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        229
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        954
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        973
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        742
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        905
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        551
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        845
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        676
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        842
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        761
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        758
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        869
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        931
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        651
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        292
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        255
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        554
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        111
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        537
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        908
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        141
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        677
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        201
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        970
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        893
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        927
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        601
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        369
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        872
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        586
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        470
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        852
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        968
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        884
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        112
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        708
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        516
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        688
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        387
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        296
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        922
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        622
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        903
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        362
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        762
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        571
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        645
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        555
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        940
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        406
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        460
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        777
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        976
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        336
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        636
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        920
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        262
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        144
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        309
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        506
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        270
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        103
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        517
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        908
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        181
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        705
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        303
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        483
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        244
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        813
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        847
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        368
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        531
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        906
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        312
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        583
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        804
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        614
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        874
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        788
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        297
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        574
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        367
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        394
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        494
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        141
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        139
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        857
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        212
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        591
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        343
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        626
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        565
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        911
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        696
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        925
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        128
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        941
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        583
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        713
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        241
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        933
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        552
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        648
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        463
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        743
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        950
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        155
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        407
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        796
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        756
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        570
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        642
#>     indicator2 indicator3
#> 1          576        105
#> 2          791        488
#> 3          557        623
#> 4          123        363
#> 5          867        494
#> 6          700        131
#> 7          621        499
#> 8          940        686
#> 9          822        965
#> 10         956        557
#> 11         278        238
#> 12         640        107
#> 13         148        821
#> 14         178        569
#> 15         802        473
#> 16         890        552
#> 17         968        178
#> 18         642        296
#> 19         594        767
#> 20         409        239
#> 21         139        572
#> 22         234        384
#> 23         790        786
#> 24         191        127
#> 25         203        820
#> 26         879        196
#> 27         870        972
#> 28         499        983
#> 29         683        355
#> 30         495        693
#> 31         859        859
#> 32         421        403
#> 33         682        481
#> 34         821        579
#> 35         637        250
#> 36         931        291
#> 37         479        494
#> 38         516        637
#> 39         216        490
#> 40         317        297
#> 41         997        248
#> 42         156        652
#> 43         142        665
#> 44         388        416
#> 45         627        801
#> 46         186        738
#> 47         242        559
#> 48         974        621
#> 49         131        611
#> 50         311        173
#> 51         318        415
#> 52         676        126
#> 53         671        901
#> 54         892        269
#> 55         736        682
#> 56         237        282
#> 57         654        919
#> 58         834        143
#> 59         983        752
#> 60         985        639
#> 61         466        723
#> 62         159        474
#> 63         162        829
#> 64         541        805
#> 65         930        812
#> 66         801        141
#> 67         645        105
#> 68         861        144
#> 69         141        157
#> 70         405        837
#> 71         520        549
#> 72         118        844
#> 73         695        900
#> 74         305        116
#> 75         197        932
#> 76         968        767
#> 77         745        836
#> 78         150        924
#> 79         212        853
#> 80         267        390
#> 81         833        115
#> 82         569        450
#> 83         753        140
#> 84         611        623
#> 85         166        496
#> 86         117        849
#> 87         498        456
#> 88         191        427
#> 89         223        969
#> 90         635        798
#> 91         778        160
#> 92         957        996
#> 93         408        503
#> 94         939        781
#> 95         893        518
#> 96         338        181
#> 97         264        650
#> 98         755        113
#> 99         662        845
#> 100        455        306
#> 101        896        389
#> 102        124        632
#> 103        336        105
#> 104        186        482
#> 105        918        781
#> 106        386        672
#> 107        765        554
#> 108        347        905
#> 109        486        582
#> 110        244        647
#> 111        674        454
#> 112        388        329
#> 113        588        135
#> 114        147        557
#> 115        333        403
#> 116        974        362
#> 117        568        302
#> 118        501        595
#> 119        589        560
#> 120        446        956
#> 121        251        492
#> 122        581        820
#> 123        311        926
#> 124        424        783
#> 125        481        977
#> 126        239        277
#> 127        783        854
#> 128        634        877
#> 129        592        736
#> 130        151        208
#> 131        759        788
#> 132        103        113
#> 133        438        240
#> 134        226        718
#> 135        568        237
#> 136        761        360
#> 137        632        771
#> 138        339        840
#> 139        182        494
#> 140        351        979
#> 141        785        170
#> 142        241        666
#> 143        895        667
#> 144        695        915
#> 145        760        414
#> 146        937        937
#> 147        226        981
#> 148        106        143
#> 149        234        306
#> 150        605        895
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
