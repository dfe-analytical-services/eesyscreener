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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        161
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        654
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        872
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        568
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        399
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        645
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        169
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        546
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        359
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        851
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        773
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        774
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        316
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        825
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        654
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        643
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        169
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        364
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        249
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        365
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        515
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        216
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        628
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        279
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        283
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        121
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        706
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        996
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        169
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        773
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        278
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        785
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        932
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        636
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        594
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        597
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        264
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        363
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        772
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        835
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        975
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        950
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        703
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        895
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        915
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        942
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        390
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        229
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        954
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        973
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        742
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        905
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        551
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        845
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        676
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        842
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        761
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        758
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        869
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        931
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        651
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        292
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        255
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        554
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        111
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        537
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        908
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        141
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        677
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        201
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        970
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        893
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        927
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        601
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        369
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        872
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        586
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        470
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        852
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        968
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        884
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        112
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        708
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        516
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        688
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        387
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        296
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        922
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        622
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        903
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        362
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        762
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        571
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        645
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        555
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        940
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        406
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        460
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        777
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        976
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        336
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        636
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        920
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        262
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        144
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        309
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        506
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        270
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        103
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        517
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        908
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        181
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        705
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        303
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        406
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        483
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        244
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        813
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        847
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        368
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        531
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        906
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        312
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        583
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        804
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        614
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        874
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        788
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        297
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        574
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        367
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        394
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        494
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        141
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        139
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        857
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        212
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        591
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        343
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        626
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        565
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        911
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        696
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        925
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        128
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        941
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        583
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        713
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        241
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        933
#>     indicator2 indicator3
#> 1          552        182
#> 2          565        351
#> 3          648        785
#> 4          463        241
#> 5          743        895
#> 6          950        695
#> 7          155        760
#> 8          407        937
#> 9          796        226
#> 10         756        106
#> 11         570        234
#> 12         642        605
#> 13         576        105
#> 14         791        488
#> 15         557        623
#> 16         123        363
#> 17         867        494
#> 18         700        131
#> 19         621        499
#> 20         940        686
#> 21         822        965
#> 22         956        557
#> 23         278        238
#> 24         640        107
#> 25         148        821
#> 26         178        569
#> 27         802        473
#> 28         890        552
#> 29         968        178
#> 30         642        296
#> 31         594        767
#> 32         409        239
#> 33         139        572
#> 34         234        384
#> 35         790        786
#> 36         191        127
#> 37         203        820
#> 38         879        196
#> 39         870        972
#> 40         499        983
#> 41         683        355
#> 42         495        693
#> 43         859        859
#> 44         421        403
#> 45         682        481
#> 46         821        579
#> 47         637        250
#> 48         931        291
#> 49         479        494
#> 50         516        637
#> 51         216        490
#> 52         317        297
#> 53         997        248
#> 54         156        652
#> 55         142        665
#> 56         388        416
#> 57         627        801
#> 58         186        738
#> 59         242        559
#> 60         974        621
#> 61         131        611
#> 62         311        173
#> 63         318        415
#> 64         676        126
#> 65         671        901
#> 66         892        269
#> 67         736        682
#> 68         237        282
#> 69         654        919
#> 70         834        143
#> 71         983        752
#> 72         985        639
#> 73         466        723
#> 74         159        474
#> 75         162        829
#> 76         541        805
#> 77         930        812
#> 78         801        141
#> 79         645        105
#> 80         861        144
#> 81         141        157
#> 82         405        837
#> 83         520        549
#> 84         118        844
#> 85         695        900
#> 86         305        116
#> 87         197        932
#> 88         968        767
#> 89         745        836
#> 90         150        924
#> 91         212        853
#> 92         267        390
#> 93         833        115
#> 94         569        450
#> 95         753        140
#> 96         611        623
#> 97         166        496
#> 98         117        849
#> 99         498        456
#> 100        191        427
#> 101        223        969
#> 102        635        798
#> 103        778        160
#> 104        957        996
#> 105        408        503
#> 106        939        781
#> 107        893        518
#> 108        338        181
#> 109        264        650
#> 110        755        113
#> 111        662        845
#> 112        455        306
#> 113        896        389
#> 114        124        632
#> 115        336        105
#> 116        186        482
#> 117        918        781
#> 118        386        672
#> 119        765        554
#> 120        347        905
#> 121        486        582
#> 122        244        647
#> 123        674        454
#> 124        388        329
#> 125        588        135
#> 126        147        557
#> 127        333        403
#> 128        974        362
#> 129        568        302
#> 130        501        595
#> 131        589        560
#> 132        446        956
#> 133        251        492
#> 134        581        820
#> 135        311        926
#> 136        424        783
#> 137        481        977
#> 138        239        277
#> 139        783        854
#> 140        634        877
#> 141        592        736
#> 142        151        208
#> 143        759        788
#> 144        103        113
#> 145        438        240
#> 146        226        718
#> 147        568        237
#> 148        761        360
#> 149        632        771
#> 150        339        840
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
