Assignment 1
===================
Detailed description        

```{r echo =TRUE }
library(tidyr)
library(dplyr)
library(ggplot2)
```
##Part 1
```{r echo=TRUE}
a<-read.csv("activity.csv", header = TRUE, sep = ",")

#date wise steps
b<-aggregate(a$steps,by = list(a$date), FUN = sum)

hist(b$x, breaks = 60, xlab = "Total number of steps", ylab = "Frequency", main = "Steps distribution over 2 months period")

mean(b$x, na.rm = TRUE)

median(b$x, na.rm = TRUE)
```
##Part 2
```{r echo=TRUE}
#plot
c<-aggregate(a$steps,by = list(a$interval), FUN = mean, na.rm = TRUE)

plot(c$Group.1, c$x, type = "l", xlim = c(0,2355), xlab = "Time interval", ylab = "Steps count", main = "Number of steps averaged over all days for a given time interval")

#max steps:Calculating interval having max number of averaged steps

maxvalue = max(c$x)

maxvalue

c[grepl(maxvalue, c$x),1]
```
##Part 3
```{r echo=TRUE}
#count of rows with NA

d<-group_by(a, steps)

d<-select(d, steps, interval)

d<-summarise(d, count = n())

d[is.na(d$steps),2]

#replacing NAs : Filling missing values with average number of steps across 2 months period.

a[is.na(a)]<-mean(a$steps,na.rm = TRUE)

#creating new data set with filled in missing values

f<-aggregate(a$steps,by = list(a$date), FUN = sum)

#plotting new histogram

hist(f$x, breaks = 60, xlab = "steps", main = "steps distribution over 2 months after filling in missing data")

mean(f$x, na.rm = TRUE)

median(f$x, na.rm = TRUE)

```
Yes, the frequency in histogram changes which is an expected behavior as many missing values which were earlier neglected while creating first histogram will be counted now after the missing values are replaced with average values. However, there is no significant difference in median.

##Part 4
```{r echo=TRUE}
a$date<-as.Date(a$date)

a<-mutate(a, day = weekdays(date, abbreviate = TRUE), day_type = ifelse((day == "Sun" | day == "Sat"), "Weekend", "Weekday"))

g<-aggregate(a$steps,by = list(a$interval,a$day_type), FUN = mean, na.rm = TRUE)

qplot(Group.1, x, data = g, type = "l", facets = Group.2~., method = "lm", geom = c("point", "smooth"), xlab = "time interval", ylab = "Number of steps", main = "distribution of steps over weekends and weekdays")
```






















