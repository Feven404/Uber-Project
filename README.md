# Uber Project
## Feven Ferede
---
## Introduction
This project involved the analysis of Uber rides and included was ShinyApp for visualisation.
<div align = "center">
<img src = "Images/uber photo.webp" width = "450")>
</div>

---

## Data Dictionary
1. Date/Time: date and time of the rides taken 
2. Lat: the latitude of the ride
3. Lon: the longetidue of the ride
4. Base: the starting points from which Uber trips originate
   
---

## Data Cleaning
Changed the csv files to RDS
```
#Converting csv to rds files
aprl14_data <- fread("uber-raw-data-apr14.csv")
saveRDS(aprl14_data, file = "uber-raw-data-apr14.rds")

may14_data <- fread("uber-raw-data-may14.csv")
saveRDS(may14_data, file = "uber-raw-data-may14.rds")

jun14_data <- fread("uber-raw-data-jun14.csv")
saveRDS(jun14_data, file = "uber-raw-data-jun14.rds")

jul14_data <- fread("uber-raw-data-jul14.csv")
saveRDS(jul14_data, file = "uber-raw-data-jul14.rds")

aug14_data <- fread("uber-raw-data-aug14.csv")
saveRDS(aug14_data, file = "uber-raw-data-aug14.rds")

sep14_data <- fread("uber-raw-data-sep14.csv")
saveRDS(sep14_data, file = "uber-raw-data-sep14.rds")
```
Combined all the data and made the following changes regarding the Date/Time column:
1. Changed the data format under the Date/Time column to mm-dd-yyyy hh:mm:ss
2. Created a new column extracting only the hour from the Date/Time column
3. Created a new column extracting only the month from the Date/Time column and changing it from numeric to words like 09 would be displayed as September.
4. Created a new column extracting only the weekdays from the Date/Time column and displaying it as words like Monday, Tuesday, etc.
5. Created a new column extracting only the day in numeric value from the Date/Time column

```
#Bind data together
combined_data <- bind_rows(aprl14_data, may14_data, jun14_data, jul14_data, aug14_data, sep14_data)

#Add hour, month, weekday columns and convert Date/Time column into datetime format
combined_data <- combined_data %>%
  mutate(
    `Date/Time` = mdy_hms(`Date/Time`), 
    Hour = hour(`Date/Time`),             
    Month = month.abb[month(`Date/Time`)],
    Weekday = weekdays(`Date/Time`),
    Day = day(`Date/Time`) 
  )
```

Now the final table, combined_data, will look like this (this is only a small snippet of the table since there are millions of observations)

<img src="Images/combined data sample image.png" height = "400" width = "750">

---
## Data Analysis
### Pivot tables 
1. A pivot table showing the number of trips during every hour from April to September:
```
hourly_trips <- combined_data %>%
  group_by(Hour) %>%
  summarise(Trips = n()) %>%
  arrange(Hour)
```
2. A table showing the number of trips taken during each day of the month:
```
daily_trips <- combined_data %>%
  group_by(Day) %>%
  summarise(Trips = n()) %>%
  arrange(Day)
  ```
3. A pivot table showing the number of trips taken by weekday and month:
```
trips_by_weekday_and_month <- combined_data %>%
  group_by(Weekday, Month) %>%
  summarise(Trips = n()) %>%
  arrange(match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")), 
          match(Month, month.name))
  ```      
4. A pivot table displaying the number of trips taken by bases and month:
 ``` 
trips_by_bases_month <- combined_data %>%
  group_by(Base, Month) %>%
  summarise(Trips = n()) %>%
  arrange(Base, match(Month, month.name))
 ``` 
---

## Heatmaps
1. A heatmap showing the number of trips by hour and day:
 ```
heatmap_of_trips_by_hour_day <- combined_data %>%
  group_by(Hour, Weekday) %>%
  summarise(Trips = n()) %>%
  arrange(Hour, match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))
 ```
2. A heatmap showing the number of trips by month and day:
```
heatmap_by_month_day <- combined_data %>%
  group_by(Month, Day) %>%
  summarise(Trips = n()) %>%
  arrange(match(Month, month.name), Day)
```
3. A heatmap displaying the number for trips by month and week:
```
heatmap_by_month_week <- combined_data %>%
  mutate(
    Week = week(`Date/Time`),
    Month = factor(month.abb[month(`Date/Time`)], levels = month.abb)
  ) %>%
  group_by(Month, Week) %>%
  summarise(Trips = n()) %>%
  arrange(Week, Month)
```
4. A heatmap dispalying the number of trips by bases and day of the week:
```
heatmap_by_bases_day <- combined_data %>%
  group_by(Base, Weekday) %>%
  summarise(Trips = n()) %>%
  arrange(Base, match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))
```
---

## Saving Plots to RDS files
For all the plots constructed, includinh heatmaps, I saved it into a RDS file so it can be read in the ShinyApp project. Below are examples of the RDS files saved of charts (there are more plots saved as rds files, this is a snippet):
```
saveRDS(trips_by_hour_month, file = "Trips by Hour and Month.rds")
saveRDS(trips_by_every_hour, file = "Trips by every Hour.rds")
saveRDS(daily_trips, file = "Daily Trips.rds")
saveRDS(trips_by_weekday_and_month, file = "Trips by Weekday and Month.rds")
saveRDS(trips_by_bases_month, file = "Trips by Bases and Month.rds")
saveRDS(heatmap_of_trips_by_hour_day, file = "Heatmap of Trips by Hour and Day.rds")
saveRDS(heatmap_by_month_day, file = "Heatmap of Trips by Month and Day.rds")
saveRDS(heatmap_by_month_week, file = "Heatmap of Trips by Month and Week.rds")
saveRDS(heatmap_by_bases_day, file = "Heatmap of Trips by Bases and Day.rds")
```
---

## ShinyApp
<p>
  Created a ShinyApp which is accessible using the following link:
  [https://fevenf.shinyapps.io/UberProjecrRideAnalysis/]
</p>



