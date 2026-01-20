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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        399
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        645
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        169
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        546
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        359
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        851
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        774
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        316
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        825
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        643
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        364
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        249
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        365
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        515
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        216
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        628
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        279
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        283
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        121
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        706
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        996
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        169
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        773
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        278
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        785
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        932
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        636
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        594
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        597
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        264
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        363
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        772
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        835
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        975
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        950
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        703
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        895
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        915
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        942
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        390
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        229
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        954
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        973
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        742
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        905
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        551
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        845
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        676
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        842
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        761
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        758
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        869
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        931
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        651
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        292
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        255
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        554
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        111
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        537
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        908
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        141
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        677
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        201
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        970
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        893
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        927
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        601
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        369
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        872
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        586
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        470
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        852
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        968
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        884
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        112
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        708
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        516
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        688
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        387
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        296
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        922
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        622
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        903
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        362
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        762
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        571
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        645
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        555
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        940
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        406
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        460
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        777
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        976
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        336
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        636
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        920
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        262
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        144
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        309
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        506
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        270
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        103
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        517
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        908
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        181
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        705
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        303
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        406
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        483
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        244
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        813
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        847
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        368
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        531
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        906
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        312
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        583
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        804
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        614
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        874
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        788
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        297
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        574
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        367
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        394
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        494
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        141
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        139
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        857
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        212
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        591
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        343
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        626
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        911
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        696
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        925
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        128
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        941
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        583
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        713
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        241
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        933
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        552
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        648
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        463
#>     indicator2 indicator3
#> 1          743        895
#> 2          950        695
#> 3          155        760
#> 4          407        937
#> 5          796        226
#> 6          756        106
#> 7          570        234
#> 8          642        605
#> 9          576        105
#> 10         791        488
#> 11         557        623
#> 12         123        363
#> 13         867        494
#> 14         700        131
#> 15         621        499
#> 16         940        686
#> 17         822        965
#> 18         956        557
#> 19         278        238
#> 20         640        107
#> 21         148        821
#> 22         178        569
#> 23         802        473
#> 24         890        552
#> 25         968        178
#> 26         642        296
#> 27         594        767
#> 28         409        239
#> 29         139        572
#> 30         234        384
#> 31         790        786
#> 32         191        127
#> 33         203        820
#> 34         879        196
#> 35         870        972
#> 36         499        983
#> 37         683        355
#> 38         495        693
#> 39         859        859
#> 40         421        403
#> 41         682        481
#> 42         821        579
#> 43         637        250
#> 44         931        291
#> 45         479        494
#> 46         516        637
#> 47         216        490
#> 48         317        297
#> 49         997        248
#> 50         156        652
#> 51         142        665
#> 52         388        416
#> 53         627        801
#> 54         186        738
#> 55         242        559
#> 56         974        621
#> 57         131        611
#> 58         311        173
#> 59         318        415
#> 60         676        126
#> 61         671        901
#> 62         892        269
#> 63         736        682
#> 64         237        282
#> 65         654        919
#> 66         834        143
#> 67         983        752
#> 68         985        639
#> 69         466        723
#> 70         159        474
#> 71         162        829
#> 72         541        805
#> 73         930        812
#> 74         801        141
#> 75         645        105
#> 76         861        144
#> 77         141        157
#> 78         405        837
#> 79         520        549
#> 80         118        844
#> 81         695        900
#> 82         305        116
#> 83         197        932
#> 84         968        767
#> 85         745        836
#> 86         150        924
#> 87         212        853
#> 88         267        390
#> 89         833        115
#> 90         569        450
#> 91         753        140
#> 92         611        623
#> 93         166        496
#> 94         117        849
#> 95         498        456
#> 96         191        427
#> 97         223        969
#> 98         635        798
#> 99         778        160
#> 100        957        996
#> 101        408        503
#> 102        939        781
#> 103        893        518
#> 104        338        181
#> 105        264        650
#> 106        755        113
#> 107        662        845
#> 108        455        306
#> 109        896        389
#> 110        124        632
#> 111        336        105
#> 112        186        482
#> 113        918        781
#> 114        386        672
#> 115        765        554
#> 116        347        905
#> 117        486        582
#> 118        244        647
#> 119        674        454
#> 120        388        329
#> 121        588        135
#> 122        147        557
#> 123        333        403
#> 124        974        362
#> 125        568        302
#> 126        501        595
#> 127        589        560
#> 128        446        956
#> 129        251        492
#> 130        581        820
#> 131        311        926
#> 132        424        783
#> 133        481        977
#> 134        239        277
#> 135        783        854
#> 136        634        877
#> 137        592        736
#> 138        151        208
#> 139        759        788
#> 140        103        113
#> 141        438        240
#> 142        226        718
#> 143        568        237
#> 144        761        360
#> 145        632        771
#> 146        339        840
#> 147        182        494
#> 148        351        979
#> 149        785        170
#> 150        241        666
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
