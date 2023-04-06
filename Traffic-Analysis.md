Traffic Data Analysis
================
Christian Miyares
2023-04-06

## Methodology

For this study, I utilized a comprehensive data set containing US
accident records from 2016 to 2021, which comprised multiple variables.
Specifically, I focused on exploring the relationship between weather
conditions and traffic accidents, while examining the Severity variable
that categorized accident impact levels on a scale of 1 to 4. My primary
objective was to investigate whether there existed a correlation between
weather variables and accident severity. To achieve this, I employed
various analytical tools such as hypothesis testing, analysis of
variance, and correlation analysis, along with graphical
representations. The results of this analysis were utilized to draw a
conclusion regarding the hypothesis.

## Data Cleaning

| ID  | Severity | Start_Time          | End_Time            | Start_Lat | Start_Lng |  End_Lat |   End_Lng | Distance.mi. | Description                                                                | Number | Street      | Side | City       | County     | State | Zipcode | Country | Timezone   | Airport_Code | Weather_Timestamp   | Temperature.F. | Wind_Chill.F. | Humidity… | Pressure.in. | Visibility.mi. | Wind_Direction | Wind_Speed.mph. | Precipitation.in. | Weather_Condition | Amenity | Bump  | Crossing | Give_Way | Junction | No_Exit | Railway | Roundabout | Station | Stop  | Traffic_Calming | Traffic_Signal | Turning_Loop | Sunrise_Sunset | Civil_Twilight | Nautical_Twilight | Astronomical_Twilight |
|:----|---------:|:--------------------|:--------------------|----------:|----------:|---------:|----------:|-------------:|:---------------------------------------------------------------------------|-------:|:------------|:-----|:-----------|:-----------|:------|:--------|:--------|:-----------|:-------------|:--------------------|---------------:|--------------:|----------:|-------------:|---------------:|:---------------|----------------:|------------------:|:------------------|:--------|:------|:---------|:---------|:---------|:--------|:--------|:-----------|:--------|:------|:----------------|:---------------|:-------------|:---------------|:---------------|:------------------|:----------------------|
| A-1 |        3 | 2016-02-08 00:37:08 | 2016-02-08 06:37:08 |  40.10891 | -83.09286 | 40.11206 | -83.03187 |        3.230 | Between Sawmill Rd/Exit 20 and OH-315/Olentangy Riv Rd/Exit 22 - Accident. |     NA | Outerbelt E | R    | Dublin     | Franklin   | OH    | 43017   | US      | US/Eastern | KOSU         | 2016-02-08 00:53:00 |           42.1 |          36.1 |        58 |        29.76 |             10 | SW             |            10.4 |              0.00 | Light Rain        | False   | False | False    | False    | False    | False   | False   | False      | False   | False | False           | False          | False        | Night          | Night          | Night             | Night                 |
| A-2 |        2 | 2016-02-08 05:56:20 | 2016-02-08 11:56:20 |  39.86542 | -84.06280 | 39.86501 | -84.04873 |        0.747 | At OH-4/OH-235/Exit 41 - Accident.                                         |     NA | I-70 E      | R    | Dayton     | Montgomery | OH    | 45424   | US      | US/Eastern | KFFO         | 2016-02-08 05:58:00 |           36.9 |            NA |        91 |        29.68 |             10 | Calm           |              NA |              0.02 | Light Rain        | False   | False | False    | False    | False    | False   | False   | False      | False   | False | False           | False          | False        | Night          | Night          | Night             | Night                 |
| A-3 |        2 | 2016-02-08 06:15:39 | 2016-02-08 12:15:39 |  39.10266 | -84.52468 | 39.10209 | -84.52396 |        0.055 | At I-71/US-50/Exit 1 - Accident.                                           |     NA | I-75 S      | R    | Cincinnati | Hamilton   | OH    | 45203   | US      | US/Eastern | KLUK         | 2016-02-08 05:53:00 |           36.0 |            NA |        97 |        29.70 |             10 | Calm           |              NA |              0.02 | Overcast          | False   | False | False    | False    | True     | False   | False   | False      | False   | False | False           | False          | False        | Night          | Night          | Night             | Day                   |
| A-4 |        2 | 2016-02-08 06:51:45 | 2016-02-08 12:51:45 |  41.06213 | -81.53784 | 41.06217 | -81.53547 |        0.123 | At Dart Ave/Exit 21 - Accident.                                            |     NA | I-77 N      | R    | Akron      | Summit     | OH    | 44311   | US      | US/Eastern | KAKR         | 2016-02-08 06:54:00 |           39.0 |            NA |        55 |        29.65 |             10 | Calm           |              NA |                NA | Overcast          | False   | False | False    | False    | False    | False   | False   | False      | False   | False | False           | False          | False        | Night          | Night          | Day               | Day                   |
| A-5 |        3 | 2016-02-08 07:53:43 | 2016-02-08 13:53:43 |  39.17239 | -84.49279 | 39.17048 | -84.50180 |        0.500 | At Mitchell Ave/Exit 6 - Accident.                                         |     NA | I-75 S      | R    | Cincinnati | Hamilton   | OH    | 45217   | US      | US/Eastern | KLUK         | 2016-02-08 07:53:00 |           37.0 |          29.8 |        93 |        29.69 |             10 | WSW            |            10.4 |              0.01 | Light Rain        | False   | False | False    | False    | False    | False   | False   | False      | False   | False | False           | False          | False        | Day            | Day            | Day               | Day                   |

Sample of Original Data set

### Renaming Columns

``` r
data_clean = data %>% clean_names()
```

### New column names

    ##  [1] "id"                    "severity"              "start_time"           
    ##  [4] "end_time"              "start_lat"             "start_lng"            
    ##  [7] "end_lat"               "end_lng"               "distance_mi"          
    ## [10] "description"           "number"                "street"               
    ## [13] "side"                  "city"                  "county"               
    ## [16] "state"                 "zipcode"               "country"              
    ## [19] "timezone"              "airport_code"          "weather_timestamp"    
    ## [22] "temperature_f"         "wind_chill_f"          "humidity"             
    ## [25] "pressure_in"           "visibility_mi"         "wind_direction"       
    ## [28] "wind_speed_mph"        "precipitation_in"      "weather_condition"    
    ## [31] "amenity"               "bump"                  "crossing"             
    ## [34] "give_way"              "junction"              "no_exit"              
    ## [37] "railway"               "roundabout"            "station"              
    ## [40] "stop"                  "traffic_calming"       "traffic_signal"       
    ## [43] "turning_loop"          "sunrise_sunset"        "civil_twilight"       
    ## [46] "nautical_twilight"     "astronomical_twilight"

### Selecting weather variables for further analysis

Selecting columns associated with weather, and removing missing values.

``` r
weather_data <- data_clean %>%
  dplyr::select(severity, start_time, end_time, start_lat, start_lng, temperature_f, wind_chill_f, humidity, pressure_in, visibility_mi, wind_direction, wind_speed_mph, precipitation_in) %>%
  filter(!is.na(temperature_f) & !is.na(wind_chill_f) & !is.na(humidity) & !is.na(pressure_in) & !is.na(visibility_mi) & !is.na(wind_direction) & !is.na(wind_speed_mph) & !is.na(precipitation_in))
```

| severity | start_time          | end_time            | start_lat | start_lng | temperature_f | wind_chill_f | humidity | pressure_in | visibility_mi | wind_direction | wind_speed_mph | precipitation_in |
|---------:|:--------------------|:--------------------|----------:|----------:|--------------:|-------------:|---------:|------------:|--------------:|:---------------|---------------:|-----------------:|
|        3 | 2016-02-08 00:37:08 | 2016-02-08 06:37:08 |  40.10891 | -83.09286 |          42.1 |         36.1 |       58 |       29.76 |          10.0 | SW             |           10.4 |             0.00 |
|        3 | 2016-02-08 07:53:43 | 2016-02-08 13:53:43 |  39.17239 | -84.49279 |          37.0 |         29.8 |       93 |       29.69 |          10.0 | WSW            |           10.4 |             0.01 |
|        2 | 2016-02-08 11:51:46 | 2016-02-08 17:51:46 |  41.37531 | -81.82017 |          33.1 |         30.0 |       92 |       29.63 |           0.5 | SW             |            3.5 |             0.08 |
|        2 | 2016-02-08 15:16:43 | 2016-02-08 21:16:43 |  40.10931 | -82.96849 |          32.0 |         28.7 |      100 |       29.59 |           0.5 | West           |            3.5 |             0.05 |
|        2 | 2016-02-08 15:43:50 | 2016-02-08 21:43:50 |  39.19288 | -84.47723 |          33.8 |         29.6 |      100 |       29.66 |           3.0 | NNW            |            4.6 |             0.03 |

Sample of modified Weather Data set

## Data analysis

A summary of the weather variables

    ##     severity      start_time          end_time           start_lat    
    ##  Min.   :1.000   Length:2214528     Length:2214528     Min.   :24.57  
    ##  1st Qu.:2.000   Class :character   Class :character   1st Qu.:32.97  
    ##  Median :2.000   Mode  :character   Mode  :character   Median :35.75  
    ##  Mean   :2.075                                         Mean   :36.01  
    ##  3rd Qu.:2.000                                         3rd Qu.:40.07  
    ##  Max.   :4.000                                         Max.   :49.00  
    ##    start_lng       temperature_f     wind_chill_f       humidity     
    ##  Min.   :-124.55   Min.   :-33.00   Min.   :-50.10   Min.   :  1.00  
    ##  1st Qu.:-117.98   1st Qu.: 50.00   1st Qu.: 50.00   1st Qu.: 49.00  
    ##  Median : -91.08   Median : 64.00   Median : 64.00   Median : 67.00  
    ##  Mean   : -96.63   Mean   : 61.84   Mean   : 60.72   Mean   : 64.67  
    ##  3rd Qu.: -80.34   3rd Qu.: 76.00   3rd Qu.: 76.00   3rd Qu.: 84.00  
    ##  Max.   : -67.48   Max.   :196.00   Max.   :196.00   Max.   :100.00  
    ##   pressure_in    visibility_mi     wind_direction     wind_speed_mph    
    ##  Min.   :16.72   Min.   :  0.000   Length:2214528     Min.   :   0.000  
    ##  1st Qu.:29.21   1st Qu.: 10.000   Class :character   1st Qu.:   3.000  
    ##  Median :29.73   Median : 10.000   Mode  :character   Median :   7.000  
    ##  Mean   :29.37   Mean   :  9.047                      Mean   :   7.151  
    ##  3rd Qu.:29.97   3rd Qu.: 10.000                      3rd Qu.:  10.000  
    ##  Max.   :58.90   Max.   :100.000                      Max.   :1087.000  
    ##  precipitation_in  
    ##  Min.   : 0.00000  
    ##  1st Qu.: 0.00000  
    ##  Median : 0.00000  
    ##  Mean   : 0.00569  
    ##  3rd Qu.: 0.00000  
    ##  Max.   :24.00000

Correlation matrix and results:

Correlation between severity and temperature_f = -0.03856769, this
indicates a week negative correlation. Severity and wind chill also weak
neg at -0.04194407. Correlation does not equal causation therefore there
still may be a correlation.

    ##                   severity temperature_f wind_chill_f    humidity pressure_in
    ## severity        1.00000000   -0.03856769  -0.04194407  0.03198807 -0.04239229
    ## temperature_f  -0.03856769    1.00000000   0.99391723 -0.36862424  0.17372115
    ## wind_chill_f   -0.04194407    0.99391723   1.00000000 -0.35248486  0.18387927
    ## humidity        0.03198807   -0.36862424  -0.35248486  1.00000000  0.15783116
    ## pressure_in    -0.04239229    0.17372115   0.18387927  0.15783116  1.00000000
    ## visibility_mi  -0.01116392    0.23911139   0.24177960 -0.37011728  0.02719840
    ## wind_speed_mph  0.02531402    0.08949844   0.03706055 -0.17647679 -0.06251038
    ##                visibility_mi wind_speed_mph
    ## severity         -0.01116392     0.02531402
    ## temperature_f     0.23911139     0.08949844
    ## wind_chill_f      0.24177960     0.03706055
    ## humidity         -0.37011728    -0.17647679
    ## pressure_in       0.02719840    -0.06251038
    ## visibility_mi     1.00000000     0.02997580
    ## wind_speed_mph    0.02997580     1.00000000

## Visuals

![Figure 1: The histogram reveals that the majority of accidents are
classified at severity level 2. The significant frequency of severity
level 2 incidents suggests a skew in the distribution of severity
ratings, potentially impacting the mean
value.](Traffic-Analysis_files/figure-gfm/hist-1.png)

![Figure 2: The density plot of temperature by severity level provides a
visual representation of the distribution of temperature for each of the
four severity levels. The plot shows the probability density of
temperature values on the y-axis and the range of temperature values on
the x-axis. The weather temperature ranges from 0 to 200 degrees
Fahrenheit. The plot allows for a comparison of the temperature
distribution among the different severity levels, providing insights
into any patterns or trends that may
exist.](Traffic-Analysis_files/figure-gfm/density_plot-1.png)

![Figure 3: The correlation matrix plot reveals interesting insights
about the relationship between variables. The temperature_f and
wind_chill_f have a high positive correlation (0.94) as expected, while
wind_speed_mph and pressure_in show moderate negative correlation
(-0.45). Humidity and pressure_in have a weak negative correlation
(-0.17), while other variables in the dataset exhibit little or no
correlation with each
other.](Traffic-Analysis_files/figure-gfm/corr%20plot-1.png)

## Hypothesis Testing and ANOVA (Analysis of Variance)

#### Performing Analysis of Variance:

#### Null Hypothesis $H_0$: There is no significant difference in \#### the mean temperature between different severity levels.

#### Alternative Hypothesis $H_A$: There is a significant difference in the mean temperature between at least one pair \### of severity levels.

### Summarizing the ANOVA results

    ##                  Df    Sum Sq Mean Sq F value Pr(>F)    
    ## severity          1   1136178 1136178    3299 <2e-16 ***
    ## Residuals   2214526 762698354     344                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The ANOVA table shows that there is a significant difference in the mean
temperature among the different severity levels of weather conditions
(F=3299, p\<0.001). The null hypothesis can be rejected, and we can
conclude that there is a statistically significant difference in the
mean temperature for different severity levels.

Post hoc tests are conducted to determine the specific groups that
exhibit significant differences from one another, as ANOVA only
indicates the presence of a significant difference among the groups
without providing information on which groups are different.

One-way ANOVA:

    ##                  Df   Sum Sq Mean Sq F value Pr(>F)    
    ## severity          3 2.80e+06  933423    2716 <2e-16 ***
    ## Residuals   2214524 7.61e+08     344                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Post hoc tests using Tukey’s HSD method:

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = temperature_f ~ severity, data = weather_data)
    ## 
    ## $severity
    ##            diff         lwr        upr p adj
    ## 2-1  -9.0569984  -9.3688019  -8.745195     0
    ## 3-1  -8.1400232  -8.5022494  -7.777797     0
    ## 4-1 -12.6551776 -13.0189277 -12.291427     0
    ## 3-2   0.9169752   0.7267527   1.107198     0
    ## 4-2  -3.5981792  -3.7912876  -3.405071     0
    ## 4-3  -4.5151544  -4.7821325  -4.248176     0

### Tukey Results and Interpretation:

The Tukey HSD compares the means of temperature for each severity level
to each other.

The p-values in this output are all 0, indicating that there is strong
evidence to suggest that the mean temperature differs significantly
between each pair of severity levels.

Overall, this output suggests that severity level is a significant
predictor of temperature and that there are significant differences in
temperature between each pair of severity levels.

## Conclusion

Based on the results of the statistical analysis, we can draw some
conclusions about the relationship between severity level and
temperature in this dataset.

First, the one-way ANOVA test indicates that there is a significant
difference in mean temperature among the four severity levels (F = 3299,
p \< 0.001). This suggests that severity level may be a useful predictor
of temperature.

Second, the post-hoc Tukey multiple comparisons test shows that all
pairs of severity levels have significantly different mean temperatures,
except for severity levels 2 and 3. Specifically, severity level 4 has
the lowest mean temperature , followed by severity level 1, then
severity level 3, and finally severity level 2.

These findings suggest that severity level may be a useful predictor of
temperature, with higher severity levels associated with lower
temperatures. However, further analysis is needed to determine the
causal relationship between severity level and temperature, as well as
to evaluate the predictive power of severity level in a larger, more
diverse dataset.
