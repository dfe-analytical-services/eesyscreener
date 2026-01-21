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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        546
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        359
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        851
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        773
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        774
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        316
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        825
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        654
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        643
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        364
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        249
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        365
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        515
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        216
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        628
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        279
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        283
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        121
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        706
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        996
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        169
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        773
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        278
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        785
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        932
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        636
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        594
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        597
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        264
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        363
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        772
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        835
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        975
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        950
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        703
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        895
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        915
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        942
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        390
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        229
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        954
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        973
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        742
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        905
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        551
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        845
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        676
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        842
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        761
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        758
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        869
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        931
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        651
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        292
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        255
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        554
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        111
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        537
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        908
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        141
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        677
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        201
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        970
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        893
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        927
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        601
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        369
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        872
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        586
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        470
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        852
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        968
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        884
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        112
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        708
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        516
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        688
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        387
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        296
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        922
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        622
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        903
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        362
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        762
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        571
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        645
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        555
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        940
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        406
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        460
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        777
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        976
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        336
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        636
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        920
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        262
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        144
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        309
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        506
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        270
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        103
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        517
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        908
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        181
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        705
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        303
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        406
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        483
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        244
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        813
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        847
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        368
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        531
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        906
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        312
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        583
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        804
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        614
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        874
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        788
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        297
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        574
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        367
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        394
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        494
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        141
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        139
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        857
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        212
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        591
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        343
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        626
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        565
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        911
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        696
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        925
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        128
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        941
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        583
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        713
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        241
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        933
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        552
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        565
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        648
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        463
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        743
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        950
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        155
#>     indicator2 indicator3
#> 1          407        937
#> 2          796        226
#> 3          756        106
#> 4          570        234
#> 5          642        605
#> 6          576        105
#> 7          791        488
#> 8          557        623
#> 9          123        363
#> 10         867        494
#> 11         700        131
#> 12         621        499
#> 13         940        686
#> 14         822        965
#> 15         956        557
#> 16         278        238
#> 17         640        107
#> 18         148        821
#> 19         178        569
#> 20         802        473
#> 21         890        552
#> 22         968        178
#> 23         642        296
#> 24         594        767
#> 25         409        239
#> 26         139        572
#> 27         234        384
#> 28         790        786
#> 29         191        127
#> 30         203        820
#> 31         879        196
#> 32         870        972
#> 33         499        983
#> 34         683        355
#> 35         495        693
#> 36         859        859
#> 37         421        403
#> 38         682        481
#> 39         821        579
#> 40         637        250
#> 41         931        291
#> 42         479        494
#> 43         516        637
#> 44         216        490
#> 45         317        297
#> 46         997        248
#> 47         156        652
#> 48         142        665
#> 49         388        416
#> 50         627        801
#> 51         186        738
#> 52         242        559
#> 53         974        621
#> 54         131        611
#> 55         311        173
#> 56         318        415
#> 57         676        126
#> 58         671        901
#> 59         892        269
#> 60         736        682
#> 61         237        282
#> 62         654        919
#> 63         834        143
#> 64         983        752
#> 65         985        639
#> 66         466        723
#> 67         159        474
#> 68         162        829
#> 69         541        805
#> 70         930        812
#> 71         801        141
#> 72         645        105
#> 73         861        144
#> 74         141        157
#> 75         405        837
#> 76         520        549
#> 77         118        844
#> 78         695        900
#> 79         305        116
#> 80         197        932
#> 81         968        767
#> 82         745        836
#> 83         150        924
#> 84         212        853
#> 85         267        390
#> 86         833        115
#> 87         569        450
#> 88         753        140
#> 89         611        623
#> 90         166        496
#> 91         117        849
#> 92         498        456
#> 93         191        427
#> 94         223        969
#> 95         635        798
#> 96         778        160
#> 97         957        996
#> 98         408        503
#> 99         939        781
#> 100        893        518
#> 101        338        181
#> 102        264        650
#> 103        755        113
#> 104        662        845
#> 105        455        306
#> 106        896        389
#> 107        124        632
#> 108        336        105
#> 109        186        482
#> 110        918        781
#> 111        386        672
#> 112        765        554
#> 113        347        905
#> 114        486        582
#> 115        244        647
#> 116        674        454
#> 117        388        329
#> 118        588        135
#> 119        147        557
#> 120        333        403
#> 121        974        362
#> 122        568        302
#> 123        501        595
#> 124        589        560
#> 125        446        956
#> 126        251        492
#> 127        581        820
#> 128        311        926
#> 129        424        783
#> 130        481        977
#> 131        239        277
#> 132        783        854
#> 133        634        877
#> 134        592        736
#> 135        151        208
#> 136        759        788
#> 137        103        113
#> 138        438        240
#> 139        226        718
#> 140        568        237
#> 141        761        360
#> 142        632        771
#> 143        339        840
#> 144        182        494
#> 145        351        979
#> 146        785        170
#> 147        241        666
#> 148        895        667
#> 149        695        915
#> 150        760        414
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
