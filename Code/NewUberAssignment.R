library(tidyr)
library(tidytext)
library(ggplot2)
library(dplyr)
library(lubridate)
library(knitr)
library(leaflet)
library(data.table)
library(leaflet)
library(leaflet.extras)

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

#Pivot table to display trips by the hour
hourly_trips <- combined_data %>%
  group_by(Hour) %>%
  summarise(Trips = n()) %>%
  arrange(Hour)

#Chart that shows Trip by Hour and Month
trips_by_hour_month <- combined_data %>%
  group_by(Hour, Month) %>%
  summarise(Trips = n()) %>%
  arrange(Hour)

ggplot(trips_by_hour_month, aes(x = Hour, y = Trips, color = Month)) +
  geom_line() +
  labs(title = "Trips by Hour and Month",
       x = "Hour of the Day",
       y = "Number of Trips",
       color = "Month") +
  theme_minimal()

saveRDS(trips_by_hour_month, file = "Trips by Hour and Month.rds")

#Chart that displays Trips every Hour
trips_by_every_hour <- combined_data %>%
  group_by(Hour) %>%
  summarise(Trips = n()) %>%
  arrange(Hour)

ggplot(combined_data, aes(x = Hour)) +
  geom_bar(stat = "count", fill = "pink") +  
  labs(title = "Trips Every Hour",
       x = "Hour of the Day",
       y = "Number of Trips") +
  theme_minimal()

saveRDS(trips_by_every_hour, file = "Trips by every Hour.rds")

#Plot data by trips taken during every day of the month.
daily_trips <- combined_data %>%
  group_by(Day) %>%
  summarise(Trips = n()) %>%
  arrange(Day)

# Display a table of total trips taken each day
daily_trips_table <- daily_trips %>%
  kable(col.names = c("Day", "Total Trips"), align = c("c", "c"))

# Plot data by trips taken during every day of the month
ggplot(daily_trips, aes(x = Day, y = Trips, color = Day)) +
  geom_line() +
  labs(title = "Trips Taken Every Day of the Month",
       x = "Day of the Month",
       y = "Number of Trips",
       color = "Day of the Month") +
  theme_minimal()

saveRDS(daily_trips, file = "Daily Trips.rds")

# Create a pivot table to display trips by day of the week and month
trips_by_weekday_and_month <- combined_data %>%
  group_by(Weekday, Month) %>%
  summarise(Trips = n()) %>%
  arrange(match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")), 
          match(Month, month.name))

# Plot data by trips taken by day of the week and month
ggplot(trips_by_weekday_and_month, aes(x = Month, y = Trips, fill = Weekday)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Trips by Day of the Week and Month",
       x = "Month",
       y = "Number of Trips",
       fill = "Day of the Week") +
  theme_minimal()

saveRDS(trips_by_weekday_and_month, file = "Trips by Weekday and Month.rds")

# Create a pivot table to display trips by bases and month
trips_by_bases_month <- combined_data %>%
  group_by(Base, Month) %>%
  summarise(Trips = n()) %>%
  arrange(Base, match(Month, month.name))

# Plot data by trips taken by bases and month
ggplot(trips_by_bases_month, aes(x = Base, y = Trips, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Trips by Bases and Month",
       x = "Base",
       y = "Number of Trips",
       fill = "Month") +
  theme_minimal()

saveRDS(trips_by_bases_month, file = "Trips by Bases and Month.rds")

#Heatmap by hour and day
heatmap_of_trips_by_hour_day <- combined_data %>%
  group_by(Hour, Weekday) %>%
  summarise(Trips = n()) %>%
  arrange(Hour, match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))

# Plot data using a heatmap (geom_tile) by trips taken by hour and day
ggplot(heatmap_of_trips_by_hour_day, aes(x = Hour, y = Weekday, fill = Trips)) +
  geom_tile() +
  labs(title = "Trips by Hour and Day",
       x = "Hour of the Day",
       y = "Day of the Week",
       fill = "Number of Trips") +
  scale_fill_viridis_c() +  
  theme_minimal()

saveRDS(heatmap_of_trips_by_hour_day, file = "Heatmap of Trips by Hour and Day.rds")

#Heatmap of trips by month and day
heatmap_by_month_day <- combined_data %>%
  group_by(Month, Day) %>%
  summarise(Trips = n()) %>%
  arrange(match(Month, month.name), Day)

# Plot data using a heatmap by trips taken by month and day
ggplot(heatmap_by_month_day, aes(x = Month, y = Day, fill = Trips)) +
  geom_tile() +
  labs(title = "Trips by Month and Day",
       x = "Month",
       y = "Day of the Month",
       fill = "Number of Trips") +
  scale_fill_viridis_c() +  
  theme_minimal()

saveRDS(heatmap_by_month_day, file = "Heatmap of Trips by Month and Day.rds")

#Heatmap of trips by month and week
heatmap_by_month_week <- combined_data %>%
  mutate(
    Week = week(`Date/Time`),
    Month = factor(month.abb[month(`Date/Time`)], levels = month.abb)
  ) %>%
  group_by(Month, Week) %>%
  summarise(Trips = n()) %>%
  arrange(Week, Month)

# Plot data using a heatmap by trips taken by month and week
ggplot(heatmap_by_month_week, aes(x = Week, y = Month, fill = Trips)) +
  geom_tile() +
  labs(title = "Trips by Month and Week",
       x = "Week",
       y = "Month of the Year",
       fill = "Number of Trips") +
  scale_fill_viridis_c() +  
  theme_minimal()

saveRDS(heatmap_by_month_week, file = "Heatmap of Trips by Month and Week.rds")

#Heat map of trips by bases and day of the week
heatmap_by_bases_day <- combined_data %>%
  group_by(Base, Weekday) %>%
  summarise(Trips = n()) %>%
  arrange(Base, match(Weekday, c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))

# Plot data using a heatmap by trips taken by bases and day of the week
ggplot(heatmap_by_bases_day, aes(x = Base, y = Weekday, fill = Trips)) +
  geom_tile() +
  labs(title = "Trips by Bases and Day of the Week",
       x = "Base",
       y = "Day of the Week",
       fill = "Number of Trips") +
  scale_fill_viridis_c() +  
  theme_minimal()

saveRDS(heatmap_by_bases_day, file = "Heatmap of Trips by Bases and Day.rds")

#Geospatial Map
data.location = combined_data
# Create leaflet
leaflet(data.location) %>%
  addProviderTiles(providers$OpenStreetMap) %>%
  addMarkers(Lon = ~long,
             Lat = ~lat,
             popup = paste(paste('<b>Office:</b>',
                                 data.location$place),
                           paste('<b>Address:</b>',
                                 data.location$address),
                           paste('<b>Lat:</b>',
                                 data.location$lat),
                           paste('<b>Long:</b>',
                                 data.location$long),
                           paste('<b>Supervisor:</b>',
                                 data.location$supervisor),
                           data.location$student1,
                           data.location$student2,
                           data.location$student3,
                           sep = '<br/>'),
             label = ~place,
             group = 'data.location') %>%
  addResetMapButton() %>%
  addSearchFeatures(
    targetGroups = 'data.location',
    options = searchFeaturesOptions(zoom = 15,
                                    openPopup = TRUE,
                                    firstTipSubmit = TRUE,
                                    autoCollapse = TRUE,
                                    hideMarkerOnCollapse = TRUE))
