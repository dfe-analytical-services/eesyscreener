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
#> 1      E92000001 Sheffield Central E14000919   Alpha   Alpha        272
#> 2      E92000001 Sheffield Central E14000919   Alpha   Alpha        506
#> 3      E92000001 Sheffield Central E14000919   Alpha   Alpha        559
#> 4      E92000001 Sheffield Central E14000919   Alpha   Alpha        162
#> 5      E92000001 Sheffield Central E14000919   Alpha   Alpha        584
#> 6      E92000001 Sheffield Central E14000919   Alpha   Alpha        969
#> 7      E92000001 Sheffield Central E14000919   Bravo   Alpha        978
#> 8      E92000001 Sheffield Central E14000919   Bravo   Alpha        658
#> 9      E92000001 Sheffield Central E14000919   Bravo   Alpha        551
#> 10     E92000001 Sheffield Central E14000919   Bravo   Alpha        300
#> 11     E92000001 Sheffield Central E14000919   Bravo   Alpha        296
#> 12     E92000001 Sheffield Central E14000919   Bravo   Alpha        616
#> 13     E92000001 Sheffield Central E14000919 Charlie   Alpha        866
#> 14     E92000001 Sheffield Central E14000919 Charlie   Alpha        635
#> 15     E92000001 Sheffield Central E14000919 Charlie   Alpha        946
#> 16     E92000001 Sheffield Central E14000919 Charlie   Alpha        176
#> 17     E92000001 Sheffield Central E14000919 Charlie   Alpha        997
#> 18     E92000001 Sheffield Central E14000919 Charlie   Alpha        545
#> 19     E92000001 Sheffield Central E14000919   Delta   Alpha        666
#> 20     E92000001 Sheffield Central E14000919   Delta   Alpha        526
#> 21     E92000001 Sheffield Central E14000919   Delta   Alpha        161
#> 22     E92000001 Sheffield Central E14000919   Delta   Alpha        654
#> 23     E92000001 Sheffield Central E14000919   Delta   Alpha        872
#> 24     E92000001 Sheffield Central E14000919   Delta   Alpha        568
#> 25     E92000001 Sheffield Central E14000919    Echo   Alpha        399
#> 26     E92000001 Sheffield Central E14000919    Echo   Alpha        645
#> 27     E92000001 Sheffield Central E14000919    Echo   Alpha        169
#> 28     E92000001 Sheffield Central E14000919    Echo   Alpha        546
#> 29     E92000001 Sheffield Central E14000919    Echo   Alpha        359
#> 30     E92000001 Sheffield Central E14000919    Echo   Alpha        851
#> 31     E92000001 Sheffield Central E14000919   Alpha   Bravo        773
#> 32     E92000001 Sheffield Central E14000919   Alpha   Bravo        774
#> 33     E92000001 Sheffield Central E14000919   Alpha   Bravo        316
#> 34     E92000001 Sheffield Central E14000919   Alpha   Bravo        825
#> 35     E92000001 Sheffield Central E14000919   Alpha   Bravo        654
#> 36     E92000001 Sheffield Central E14000919   Alpha   Bravo        643
#> 37     E92000001 Sheffield Central E14000919   Bravo   Bravo        169
#> 38     E92000001 Sheffield Central E14000919   Bravo   Bravo        364
#> 39     E92000001 Sheffield Central E14000919   Bravo   Bravo        249
#> 40     E92000001 Sheffield Central E14000919   Bravo   Bravo        365
#> 41     E92000001 Sheffield Central E14000919   Bravo   Bravo        515
#> 42     E92000001 Sheffield Central E14000919   Bravo   Bravo        216
#> 43     E92000001 Sheffield Central E14000919 Charlie   Bravo        628
#> 44     E92000001 Sheffield Central E14000919 Charlie   Bravo        279
#> 45     E92000001 Sheffield Central E14000919 Charlie   Bravo        283
#> 46     E92000001 Sheffield Central E14000919 Charlie   Bravo        121
#> 47     E92000001 Sheffield Central E14000919 Charlie   Bravo        706
#> 48     E92000001 Sheffield Central E14000919 Charlie   Bravo        996
#> 49     E92000001 Sheffield Central E14000919   Delta   Bravo        169
#> 50     E92000001 Sheffield Central E14000919   Delta   Bravo        773
#> 51     E92000001 Sheffield Central E14000919   Delta   Bravo        278
#> 52     E92000001 Sheffield Central E14000919   Delta   Bravo        785
#> 53     E92000001 Sheffield Central E14000919   Delta   Bravo        932
#> 54     E92000001 Sheffield Central E14000919   Delta   Bravo        636
#> 55     E92000001 Sheffield Central E14000919    Echo   Bravo        594
#> 56     E92000001 Sheffield Central E14000919    Echo   Bravo        597
#> 57     E92000001 Sheffield Central E14000919    Echo   Bravo        264
#> 58     E92000001 Sheffield Central E14000919    Echo   Bravo        363
#> 59     E92000001 Sheffield Central E14000919    Echo   Bravo        772
#> 60     E92000001 Sheffield Central E14000919    Echo   Bravo        835
#> 61     E92000001 Sheffield Central E14000919   Alpha Charlie        975
#> 62     E92000001 Sheffield Central E14000919   Alpha Charlie        950
#> 63     E92000001 Sheffield Central E14000919   Alpha Charlie        703
#> 64     E92000001 Sheffield Central E14000919   Alpha Charlie        895
#> 65     E92000001 Sheffield Central E14000919   Alpha Charlie        915
#> 66     E92000001 Sheffield Central E14000919   Alpha Charlie        942
#> 67     E92000001 Sheffield Central E14000919   Bravo Charlie        390
#> 68     E92000001 Sheffield Central E14000919   Bravo Charlie        229
#> 69     E92000001 Sheffield Central E14000919   Bravo Charlie        954
#> 70     E92000001 Sheffield Central E14000919   Bravo Charlie        973
#> 71     E92000001 Sheffield Central E14000919   Bravo Charlie        742
#> 72     E92000001 Sheffield Central E14000919   Bravo Charlie        905
#> 73     E92000001 Sheffield Central E14000919 Charlie Charlie        551
#> 74     E92000001 Sheffield Central E14000919 Charlie Charlie        845
#> 75     E92000001 Sheffield Central E14000919 Charlie Charlie        676
#> 76     E92000001 Sheffield Central E14000919 Charlie Charlie        842
#> 77     E92000001 Sheffield Central E14000919 Charlie Charlie        761
#> 78     E92000001 Sheffield Central E14000919 Charlie Charlie        758
#> 79     E92000001 Sheffield Central E14000919   Delta Charlie        869
#> 80     E92000001 Sheffield Central E14000919   Delta Charlie        931
#> 81     E92000001 Sheffield Central E14000919   Delta Charlie        651
#> 82     E92000001 Sheffield Central E14000919   Delta Charlie        292
#> 83     E92000001 Sheffield Central E14000919   Delta Charlie        255
#> 84     E92000001 Sheffield Central E14000919   Delta Charlie        554
#> 85     E92000001 Sheffield Central E14000919    Echo Charlie        111
#> 86     E92000001 Sheffield Central E14000919    Echo Charlie        537
#> 87     E92000001 Sheffield Central E14000919    Echo Charlie        908
#> 88     E92000001 Sheffield Central E14000919    Echo Charlie        141
#> 89     E92000001 Sheffield Central E14000919    Echo Charlie        677
#> 90     E92000001 Sheffield Central E14000919    Echo Charlie        201
#> 91     E92000001 Sheffield Central E14000919   Alpha   Delta        970
#> 92     E92000001 Sheffield Central E14000919   Alpha   Delta        893
#> 93     E92000001 Sheffield Central E14000919   Alpha   Delta        927
#> 94     E92000001 Sheffield Central E14000919   Alpha   Delta        601
#> 95     E92000001 Sheffield Central E14000919   Alpha   Delta        369
#> 96     E92000001 Sheffield Central E14000919   Alpha   Delta        872
#> 97     E92000001 Sheffield Central E14000919   Bravo   Delta        586
#> 98     E92000001 Sheffield Central E14000919   Bravo   Delta        470
#> 99     E92000001 Sheffield Central E14000919   Bravo   Delta        852
#> 100    E92000001 Sheffield Central E14000919   Bravo   Delta        968
#> 101    E92000001 Sheffield Central E14000919   Bravo   Delta        884
#> 102    E92000001 Sheffield Central E14000919   Bravo   Delta        112
#> 103    E92000001 Sheffield Central E14000919 Charlie   Delta        708
#> 104    E92000001 Sheffield Central E14000919 Charlie   Delta        516
#> 105    E92000001 Sheffield Central E14000919 Charlie   Delta        688
#> 106    E92000001 Sheffield Central E14000919 Charlie   Delta        387
#> 107    E92000001 Sheffield Central E14000919 Charlie   Delta        296
#> 108    E92000001 Sheffield Central E14000919 Charlie   Delta        922
#> 109    E92000001 Sheffield Central E14000919   Delta   Delta        622
#> 110    E92000001 Sheffield Central E14000919   Delta   Delta        903
#> 111    E92000001 Sheffield Central E14000919   Delta   Delta        362
#> 112    E92000001 Sheffield Central E14000919   Delta   Delta        762
#> 113    E92000001 Sheffield Central E14000919   Delta   Delta        571
#> 114    E92000001 Sheffield Central E14000919   Delta   Delta        645
#> 115    E92000001 Sheffield Central E14000919    Echo   Delta        555
#> 116    E92000001 Sheffield Central E14000919    Echo   Delta        940
#> 117    E92000001 Sheffield Central E14000919    Echo   Delta        406
#> 118    E92000001 Sheffield Central E14000919    Echo   Delta        460
#> 119    E92000001 Sheffield Central E14000919    Echo   Delta        777
#> 120    E92000001 Sheffield Central E14000919    Echo   Delta        976
#> 121    E92000001 Sheffield Central E14000919   Alpha    Echo        336
#> 122    E92000001 Sheffield Central E14000919   Alpha    Echo        636
#> 123    E92000001 Sheffield Central E14000919   Alpha    Echo        920
#> 124    E92000001 Sheffield Central E14000919   Alpha    Echo        262
#> 125    E92000001 Sheffield Central E14000919   Alpha    Echo        144
#> 126    E92000001 Sheffield Central E14000919   Alpha    Echo        309
#> 127    E92000001 Sheffield Central E14000919   Bravo    Echo        506
#> 128    E92000001 Sheffield Central E14000919   Bravo    Echo        270
#> 129    E92000001 Sheffield Central E14000919   Bravo    Echo        103
#> 130    E92000001 Sheffield Central E14000919   Bravo    Echo        517
#> 131    E92000001 Sheffield Central E14000919   Bravo    Echo        908
#> 132    E92000001 Sheffield Central E14000919   Bravo    Echo        181
#> 133    E92000001 Sheffield Central E14000919 Charlie    Echo        705
#> 134    E92000001 Sheffield Central E14000919 Charlie    Echo        303
#> 135    E92000001 Sheffield Central E14000919 Charlie    Echo        406
#> 136    E92000001 Sheffield Central E14000919 Charlie    Echo        483
#> 137    E92000001 Sheffield Central E14000919 Charlie    Echo        244
#> 138    E92000001 Sheffield Central E14000919 Charlie    Echo        813
#> 139    E92000001 Sheffield Central E14000919   Delta    Echo        847
#> 140    E92000001 Sheffield Central E14000919   Delta    Echo        368
#> 141    E92000001 Sheffield Central E14000919   Delta    Echo        531
#> 142    E92000001 Sheffield Central E14000919   Delta    Echo        906
#> 143    E92000001 Sheffield Central E14000919   Delta    Echo        312
#> 144    E92000001 Sheffield Central E14000919   Delta    Echo        583
#> 145    E92000001 Sheffield Central E14000919    Echo    Echo        804
#> 146    E92000001 Sheffield Central E14000919    Echo    Echo        614
#> 147    E92000001 Sheffield Central E14000919    Echo    Echo        874
#> 148    E92000001 Sheffield Central E14000919    Echo    Echo        788
#> 149    E92000001 Sheffield Central E14000919    Echo    Echo        297
#> 150    E92000001 Sheffield Central E14000919    Echo    Echo        574
#>     indicator2 indicator3
#> 1          367        589
#> 2          394        446
#> 3          494        251
#> 4          141        581
#> 5          139        311
#> 6          857        424
#> 7          212        481
#> 8          591        239
#> 9          343        783
#> 10         626        634
#> 11         565        592
#> 12         911        151
#> 13         696        759
#> 14         925        103
#> 15         128        438
#> 16         941        226
#> 17         583        568
#> 18         713        761
#> 19         241        632
#> 20         933        339
#> 21         552        182
#> 22         565        351
#> 23         648        785
#> 24         463        241
#> 25         743        895
#> 26         950        695
#> 27         155        760
#> 28         407        937
#> 29         796        226
#> 30         756        106
#> 31         570        234
#> 32         642        605
#> 33         576        105
#> 34         791        488
#> 35         557        623
#> 36         123        363
#> 37         867        494
#> 38         700        131
#> 39         621        499
#> 40         940        686
#> 41         822        965
#> 42         956        557
#> 43         278        238
#> 44         640        107
#> 45         148        821
#> 46         178        569
#> 47         802        473
#> 48         890        552
#> 49         968        178
#> 50         642        296
#> 51         594        767
#> 52         409        239
#> 53         139        572
#> 54         234        384
#> 55         790        786
#> 56         191        127
#> 57         203        820
#> 58         879        196
#> 59         870        972
#> 60         499        983
#> 61         683        355
#> 62         495        693
#> 63         859        859
#> 64         421        403
#> 65         682        481
#> 66         821        579
#> 67         637        250
#> 68         931        291
#> 69         479        494
#> 70         516        637
#> 71         216        490
#> 72         317        297
#> 73         997        248
#> 74         156        652
#> 75         142        665
#> 76         388        416
#> 77         627        801
#> 78         186        738
#> 79         242        559
#> 80         974        621
#> 81         131        611
#> 82         311        173
#> 83         318        415
#> 84         676        126
#> 85         671        901
#> 86         892        269
#> 87         736        682
#> 88         237        282
#> 89         654        919
#> 90         834        143
#> 91         983        752
#> 92         985        639
#> 93         466        723
#> 94         159        474
#> 95         162        829
#> 96         541        805
#> 97         930        812
#> 98         801        141
#> 99         645        105
#> 100        861        144
#> 101        141        157
#> 102        405        837
#> 103        520        549
#> 104        118        844
#> 105        695        900
#> 106        305        116
#> 107        197        932
#> 108        968        767
#> 109        745        836
#> 110        150        924
#> 111        212        853
#> 112        267        390
#> 113        833        115
#> 114        569        450
#> 115        753        140
#> 116        611        623
#> 117        166        496
#> 118        117        849
#> 119        498        456
#> 120        191        427
#> 121        223        969
#> 122        635        798
#> 123        778        160
#> 124        957        996
#> 125        408        503
#> 126        939        781
#> 127        893        518
#> 128        338        181
#> 129        264        650
#> 130        755        113
#> 131        662        845
#> 132        455        306
#> 133        896        389
#> 134        124        632
#> 135        336        105
#> 136        186        482
#> 137        918        781
#> 138        386        672
#> 139        765        554
#> 140        347        905
#> 141        486        582
#> 142        244        647
#> 143        674        454
#> 144        388        329
#> 145        588        135
#> 146        147        557
#> 147        333        403
#> 148        974        362
#> 149        568        302
#> 150        501        595
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
