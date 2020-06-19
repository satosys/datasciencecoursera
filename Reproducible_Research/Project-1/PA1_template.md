---
title: "Reproducible Research Project 1"
output:
  html_document:
    keep_md: yes
---
## Loading and preprocessing the data

1. Load the data:

```r
data <- read.csv("data/activity.csv", header=TRUE)
```
2. Show the original data:

```r
head(data)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

## What is mean total number of steps taken per day?

For this part of the assignment, you can ignore the missing values in the dataset.

1. Subset the original data to calculate the total number of steps

```r
stepsByDay <- aggregate(steps~date, data, sum)
head(stepsByDay)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

2. Make a histogram of the total number of steps taken each day

```r
hist(stepsByDay$steps, col = "chocolate"
     , xlab = "Steps", main = "Total Number of Steps Per Day")
```

![](PA1_template_files/figure-html/histogram1-1.png)<!-- -->

3. Calculate and report the mean and median total number of steps taken per day

```r
mean1 <- mean(stepsByDay$steps)
mean1
```

```
## [1] 10766.19
```

```r
median1 <- median(stepsByDay$steps)
median1
```

```
## [1] 10765
```
## What is the average daily activity pattern?
1. Subset the original data to calculate the average number of steps taken of the 5-minute interval

```r
averageSteps <- aggregate(steps~interval, data, mean)
head(averageSteps)
```

```
##   interval     steps
## 1        0 1.7169811
## 2        5 0.3396226
## 3       10 0.1320755
## 4       15 0.1509434
## 5       20 0.0754717
## 6       25 2.0943396
```

2. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
with(averageSteps, plot(interval, steps
                , type="l", main="Average number of steps taken in 5-min interval"
                , col = "blue")) 
```

![](PA1_template_files/figure-html/plot1-1.png)<!-- -->

3. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

Max data is:

```r
max <- max(averageSteps$steps)
max
```

```
## [1] 206.1698
```

The interval contains max data is:

```r
subsetData <- subset(averageSteps, steps == max)
subsetData$interval
```

```
## [1] 835
```

## Imputing missing values
Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
colSums(is.na(data))
```

```
##    steps     date interval 
##     2304        0        0
```

2.Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

```r
data$newSteps <- averageSteps$steps
head(data)
```

```
##   steps       date interval  newSteps
## 1    NA 2012-10-01        0 1.7169811
## 2    NA 2012-10-01        5 0.3396226
## 3    NA 2012-10-01       10 0.1320755
## 4    NA 2012-10-01       15 0.1509434
## 5    NA 2012-10-01       20 0.0754717
## 6    NA 2012-10-01       25 2.0943396
```

```r
data$steps[is.na(data$steps)] <- data$newSteps
```

```
## Warning in data$steps[is.na(data$steps)] <- data$newSteps: number of items to
## replace is not a multiple of replacement length
```

```r
head(data)
```

```
##       steps       date interval  newSteps
## 1 1.7169811 2012-10-01        0 1.7169811
## 2 0.3396226 2012-10-01        5 0.3396226
## 3 0.1320755 2012-10-01       10 0.1320755
## 4 0.1509434 2012-10-01       15 0.1509434
## 5 0.0754717 2012-10-01       20 0.0754717
## 6 2.0943396 2012-10-01       25 2.0943396
```
3. Create a new dataset that is equal to the original dataset but with the missing data filled in

```r
data$newSteps <- NULL
newdata <- data
head(newdata)
```

```
##       steps       date interval
## 1 1.7169811 2012-10-01        0
## 2 0.3396226 2012-10-01        5
## 3 0.1320755 2012-10-01       10
## 4 0.1509434 2012-10-01       15
## 5 0.0754717 2012-10-01       20
## 6 2.0943396 2012-10-01       25
```

4.Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

```r
sumdata <- aggregate(steps~date, newdata, sum)
head(sumdata)
```

```
##         date    steps
## 1 2012-10-01 10766.19
## 2 2012-10-02   126.00
## 3 2012-10-03 11352.00
## 4 2012-10-04 12116.00
## 5 2012-10-05 13294.00
## 6 2012-10-06 15420.00
```

```r
hist(sumdata$steps, col = "blue"
     , xlab = "Steps"
     , main = "Total Number of Steps Per Day (with the missing data filled in)")
```

![](PA1_template_files/figure-html/histogram2-1.png)<!-- -->

```r
mean2 <- mean(sumdata$steps)
mean2
```

```
## [1] 10766.19
```

```r
median2 <- median(sumdata$steps)
median2
```

```
## [1] 10766.19
```

```r
mean2 - mean1
```

```
## [1] 0
```

```r
median2 - median1
```

```
## [1] 1.188679
```
## Are there differences in activity patterns between weekdays and weekends?
For this part, I do not use the weekdays() function, instead I use the isWeekday() function from the timeDate package.

1. Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.

Please install the package first:

install.packages("timeDate")

```r
library(timeDate)
```

```r
newdata$Weekday <- isWeekday(newdata$date)
head(newdata)
```

```
##       steps       date interval Weekday
## 1 1.7169811 2012-10-01        0    TRUE
## 2 0.3396226 2012-10-01        5    TRUE
## 3 0.1320755 2012-10-01       10    TRUE
## 4 0.1509434 2012-10-01       15    TRUE
## 5 0.0754717 2012-10-01       20    TRUE
## 6 2.0943396 2012-10-01       25    TRUE
```

```r
weekday <- subset(newdata, newdata$Weekday == "TRUE")
weekdayMean <- aggregate(steps ~ interval, data = weekday, mean)
head(weekdayMean)
```

```
##   interval      steps
## 1        0 2.25115304
## 2        5 0.44528302
## 3       10 0.17316562
## 4       15 0.19790356
## 5       20 0.09895178
## 6       25 1.59035639
```
Weekend

```r
weekend <- subset(newdata, newdata$Weekday == "FALSE")
weekendMean <- aggregate(steps ~ interval, data = weekend, mean)
head(weekendMean)
```

```
##   interval       steps
## 1        0 0.214622642
## 2        5 0.042452830
## 3       10 0.016509434
## 4       15 0.018867925
## 5       20 0.009433962
## 6       25 3.511792453
```

2. Make a panel plot containing a time series plot (i.e. \color{red}{\verb|type = "l"|}type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

```r
layout(matrix(c(1,1,2,2), 2, 2, byrow = TRUE))
plot(weekdayMean$interval, weekdayMean$steps
     , xlab = "interval", ylab = "Number of steps"
     , main ="Weekday", col ="blue", type="l") 
plot(weekendMean$interval, weekendMean$steps
     , xlab = "interval", ylab = "Number of steps"
     , main ="Weekend", col ="red", type="l")
```

![](PA1_template_files/figure-html/panel-1.png)<!-- -->
