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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        645
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        546
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        359
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        851
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        773
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        774
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        316
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        825
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        643
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        364
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        249
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        365
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        515
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        216
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        628
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        279
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        283
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        121
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        706
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        996
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        773
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        278
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        785
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        932
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        636
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        594
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        597
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        264
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        363
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        772
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        835
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        975
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        950
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        703
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        895
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        915
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        942
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        390
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        229
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        954
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        973
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        742
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        905
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        551
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        845
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        676
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        842
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        761
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        758
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        869
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        931
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        651
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        292
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        255
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        554
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        111
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        537
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        908
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        141
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        677
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        201
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        970
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        893
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        927
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        601
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        369
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        872
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        586
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        470
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        852
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        968
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        884
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        112
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        708
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        516
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        688
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        387
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        296
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        922
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        622
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        903
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        362
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        762
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        571
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        645
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        555
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        940
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        460
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        777
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        976
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        336
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        636
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        920
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        262
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        144
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        309
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        506
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        270
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        103
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        517
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        908
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        181
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        705
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        303
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        406
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        483
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        244
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        813
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        847
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        368
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        531
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        906
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        312
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        583
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        804
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        614
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        874
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        788
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        297
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        574
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        367
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        394
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        494
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        141
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        139
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        857
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        212
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        591
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        343
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        626
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        911
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        696
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        925
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        128
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        941
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        583
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        713
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        241
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        933
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        552
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        648
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        463
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        743
#>     indicator2 indicator3
#> 1          950        695
#> 2          155        760
#> 3          407        937
#> 4          796        226
#> 5          756        106
#> 6          570        234
#> 7          642        605
#> 8          576        105
#> 9          791        488
#> 10         557        623
#> 11         123        363
#> 12         867        494
#> 13         700        131
#> 14         621        499
#> 15         940        686
#> 16         822        965
#> 17         956        557
#> 18         278        238
#> 19         640        107
#> 20         148        821
#> 21         178        569
#> 22         802        473
#> 23         890        552
#> 24         968        178
#> 25         642        296
#> 26         594        767
#> 27         409        239
#> 28         139        572
#> 29         234        384
#> 30         790        786
#> 31         191        127
#> 32         203        820
#> 33         879        196
#> 34         870        972
#> 35         499        983
#> 36         683        355
#> 37         495        693
#> 38         859        859
#> 39         421        403
#> 40         682        481
#> 41         821        579
#> 42         637        250
#> 43         931        291
#> 44         479        494
#> 45         516        637
#> 46         216        490
#> 47         317        297
#> 48         997        248
#> 49         156        652
#> 50         142        665
#> 51         388        416
#> 52         627        801
#> 53         186        738
#> 54         242        559
#> 55         974        621
#> 56         131        611
#> 57         311        173
#> 58         318        415
#> 59         676        126
#> 60         671        901
#> 61         892        269
#> 62         736        682
#> 63         237        282
#> 64         654        919
#> 65         834        143
#> 66         983        752
#> 67         985        639
#> 68         466        723
#> 69         159        474
#> 70         162        829
#> 71         541        805
#> 72         930        812
#> 73         801        141
#> 74         645        105
#> 75         861        144
#> 76         141        157
#> 77         405        837
#> 78         520        549
#> 79         118        844
#> 80         695        900
#> 81         305        116
#> 82         197        932
#> 83         968        767
#> 84         745        836
#> 85         150        924
#> 86         212        853
#> 87         267        390
#> 88         833        115
#> 89         569        450
#> 90         753        140
#> 91         611        623
#> 92         166        496
#> 93         117        849
#> 94         498        456
#> 95         191        427
#> 96         223        969
#> 97         635        798
#> 98         778        160
#> 99         957        996
#> 100        408        503
#> 101        939        781
#> 102        893        518
#> 103        338        181
#> 104        264        650
#> 105        755        113
#> 106        662        845
#> 107        455        306
#> 108        896        389
#> 109        124        632
#> 110        336        105
#> 111        186        482
#> 112        918        781
#> 113        386        672
#> 114        765        554
#> 115        347        905
#> 116        486        582
#> 117        244        647
#> 118        674        454
#> 119        388        329
#> 120        588        135
#> 121        147        557
#> 122        333        403
#> 123        974        362
#> 124        568        302
#> 125        501        595
#> 126        589        560
#> 127        446        956
#> 128        251        492
#> 129        581        820
#> 130        311        926
#> 131        424        783
#> 132        481        977
#> 133        239        277
#> 134        783        854
#> 135        634        877
#> 136        592        736
#> 137        151        208
#> 138        759        788
#> 139        103        113
#> 140        438        240
#> 141        226        718
#> 142        568        237
#> 143        761        360
#> 144        632        771
#> 145        339        840
#> 146        182        494
#> 147        351        979
#> 148        785        170
#> 149        241        666
#> 150        895        667
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
