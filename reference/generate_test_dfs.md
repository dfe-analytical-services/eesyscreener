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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        359
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        851
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        773
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        774
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        316
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        825
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        643
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        364
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        249
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        365
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        515
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        216
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        628
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        279
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        283
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        121
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        706
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        996
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        773
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        278
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        785
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        932
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        636
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        594
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        597
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        264
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        363
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        772
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        835
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        975
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        950
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        703
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        895
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        915
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        942
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        390
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        229
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        954
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        973
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        742
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        905
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        551
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        845
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        676
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        842
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        761
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        758
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        869
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        931
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        651
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        292
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        255
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        554
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        111
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        537
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        908
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        141
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        677
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        201
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        970
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        893
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        927
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        601
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        369
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        872
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        586
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        470
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        852
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        968
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        884
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        112
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        708
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        516
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        688
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        387
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        296
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        922
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        622
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        903
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        362
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        762
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        571
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        645
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        555
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        940
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        406
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        460
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        777
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        976
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        336
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        636
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        920
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        262
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        144
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        309
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        506
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        270
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        103
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        517
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        908
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        181
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        705
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        303
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        483
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        244
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        813
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        847
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        368
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        531
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        906
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        312
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        583
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        804
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        614
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        874
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        788
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        297
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        574
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        367
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        394
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        494
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        141
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        139
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        857
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        212
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        591
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        343
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        626
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        911
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        696
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        925
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        128
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        941
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        583
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        713
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        241
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        933
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        552
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        648
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        463
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        743
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        950
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        155
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        407
#>     indicator2 indicator3
#> 1          796        226
#> 2          756        106
#> 3          570        234
#> 4          642        605
#> 5          576        105
#> 6          791        488
#> 7          557        623
#> 8          123        363
#> 9          867        494
#> 10         700        131
#> 11         621        499
#> 12         940        686
#> 13         822        965
#> 14         956        557
#> 15         278        238
#> 16         640        107
#> 17         148        821
#> 18         178        569
#> 19         802        473
#> 20         890        552
#> 21         968        178
#> 22         642        296
#> 23         594        767
#> 24         409        239
#> 25         139        572
#> 26         234        384
#> 27         790        786
#> 28         191        127
#> 29         203        820
#> 30         879        196
#> 31         870        972
#> 32         499        983
#> 33         683        355
#> 34         495        693
#> 35         859        859
#> 36         421        403
#> 37         682        481
#> 38         821        579
#> 39         637        250
#> 40         931        291
#> 41         479        494
#> 42         516        637
#> 43         216        490
#> 44         317        297
#> 45         997        248
#> 46         156        652
#> 47         142        665
#> 48         388        416
#> 49         627        801
#> 50         186        738
#> 51         242        559
#> 52         974        621
#> 53         131        611
#> 54         311        173
#> 55         318        415
#> 56         676        126
#> 57         671        901
#> 58         892        269
#> 59         736        682
#> 60         237        282
#> 61         654        919
#> 62         834        143
#> 63         983        752
#> 64         985        639
#> 65         466        723
#> 66         159        474
#> 67         162        829
#> 68         541        805
#> 69         930        812
#> 70         801        141
#> 71         645        105
#> 72         861        144
#> 73         141        157
#> 74         405        837
#> 75         520        549
#> 76         118        844
#> 77         695        900
#> 78         305        116
#> 79         197        932
#> 80         968        767
#> 81         745        836
#> 82         150        924
#> 83         212        853
#> 84         267        390
#> 85         833        115
#> 86         569        450
#> 87         753        140
#> 88         611        623
#> 89         166        496
#> 90         117        849
#> 91         498        456
#> 92         191        427
#> 93         223        969
#> 94         635        798
#> 95         778        160
#> 96         957        996
#> 97         408        503
#> 98         939        781
#> 99         893        518
#> 100        338        181
#> 101        264        650
#> 102        755        113
#> 103        662        845
#> 104        455        306
#> 105        896        389
#> 106        124        632
#> 107        336        105
#> 108        186        482
#> 109        918        781
#> 110        386        672
#> 111        765        554
#> 112        347        905
#> 113        486        582
#> 114        244        647
#> 115        674        454
#> 116        388        329
#> 117        588        135
#> 118        147        557
#> 119        333        403
#> 120        974        362
#> 121        568        302
#> 122        501        595
#> 123        589        560
#> 124        446        956
#> 125        251        492
#> 126        581        820
#> 127        311        926
#> 128        424        783
#> 129        481        977
#> 130        239        277
#> 131        783        854
#> 132        634        877
#> 133        592        736
#> 134        151        208
#> 135        759        788
#> 136        103        113
#> 137        438        240
#> 138        226        718
#> 139        568        237
#> 140        761        360
#> 141        632        771
#> 142        339        840
#> 143        182        494
#> 144        351        979
#> 145        785        170
#> 146        241        666
#> 147        895        667
#> 148        695        915
#> 149        760        414
#> 150        937        937
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
