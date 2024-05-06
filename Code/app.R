library(tidyr)
library(tidytext)
library(ggplot2)
library(dplyr)
library(lubridate)
library(knitr)
library(leaflet)
library("shiny")

#Read the pivot tables and graphs created in NewUberAssignemnt.R

trips_by_hour_month <- readRDS("Trips by Hour and Month.rds")
trips_by_every_hour <- readRDS("Trips by every Hour.rds")
trips_by_weekday_and_month <- readRDS("Trips by Weekday and Month.rds")
daily_trips <- readRDS("Daily Trips.rds")
trips_by_bases_month <- readRDS("Trips by Bases and Month.rds")

heatmapz_of_trips_by_hour_day <- readRDS("Heatmap of Trips by Hour and Day.rds")
heatmap_by_month_day <- readRDS("Heatmap of Trips by Month and Day.rds")
heatmap_by_month_week <- readRDS("Heatmap of Trips by Month and Week.rds")
heatmap_by_bases_day <- readRDS("Heatmap of Trips by Bases and Day.rds")

# Shiny UI function with tabs for different plots
ui <- fluidPage(
  titlePanel("Uber Rides Data Analysis"),
  tabsetPanel(
    tabPanel("Trips by Hour and Month",
             plotOutput("plot1"),
             p("Trips by Hour and Month: This plot shows the variation in Uber trips throughout
               the day across different months, highlighting potential patterns or trends in usage
               based on time and month. From this graph we can see that the month of September has 
               the most trips per hour and month.")),
    tabPanel("Trips Every Hour",
             plotOutput("plot2"),
             p("Trips Every Hour: It displays the total number of trips taken for each hour, 
               providing insights into peak hours of activity and overall hourly distribution 
               of trips.From the graph we can say that the most trips taken are at 17 or 5pm.")),
    tabPanel("Trips Taken Every Day of the Month",
             plotOutput("plot3"),
             p("Trips Taken Every Day of the Month: This graph illustrates daily variations in 
               trip numbers, potentially revealing patterns like weekends being busier or certain 
               days of the month seeing higher usage.From the graph we can analyse that between the
               25th and 30th day we see a rise followed by a huge dip. ")),
    tabPanel("Trips by Day of the Week and Month",
             plotOutput("plot4"),
             p("Trips by Day of the Week and Month: It visualizes how trips are distributed across 
               weekdays and months, indicating whether there are particular days or months with significantly
               higher or lower trip volumes.From the graph we can analyse that September had the most number of 
               trips with the following days, respectively, having the most trips: Tuesday,Saturday, and Friday. ")),
    tabPanel("Trips by Bases and Month",
             plotOutput("plot5"),
             p("Trips by Bases and Month: This plot compares trip counts across different Uber bases over months, 
               helping identify trends or differences in usage patterns for each base.From the graph we can see that 
               in Septmeber, Base B202617 has the most number of trips while in July, Base B02764 had the least.")),
    tabPanel("Heatmap of Trips by Hour and Day",
             plotOutput("plot6"),
             p("Heatmap of Trips by Hour and Day: It presents a heatmap view of trips by hour and day, offering a 
               comprehensive overview of when trips occur most frequently across different days of the week. From
               the graph, we can analyse that most trips were taken between the hours 15 - 20 (5-8pm) on Wednesday,
               Tuesday, and Thursday.")),
    tabPanel("Heatmap of Trips by Month and Day",
             plotOutput("plot7"),
             p("Heatmap of Trips by Month and Day: Similar to the previous heatmap, this one focuses on trip distribution
               by month and day, highlighting any seasonal or monthly variations in trip patterns. From the graph we can 
               analyse that in September from days 1-10 & 10-20 are the highest numbers of trips while
               fro days 0-10 in July and 20-30 in May are the lowest number of trips.")),
    tabPanel("Heatmap of Trips by Month and Week",
             plotOutput("plot8"),
             p("Heatmap of Trips by Month and Week: It visualizes trip volumes by month and week, potentially uncovering 
               trends or changes in usage over longer time intervals.From the grapg we can analyse that between weeks 35 - 40
               from mid August to September there are high numbers of trips.")),
    tabPanel("Heatmap of Trips by Bases and Day of the Week",
             plotOutput("plot9"),
             p("Heatmap of Trips by Bases and Day of the Week: This heatmap displays trip counts by Uber bases and days of the 
               week, aiding in understanding how each base's activity varies throughout the week. From the graph we can analyse
               that Base B02617 on Thirsday and Friday have higher number of trips while Base B02512 and B02764 have low numbers
               of trips throughout the week."))
  )
)

# Shiny server function
server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(trips_by_hour_month, aes(x = Hour, y = Trips, color = Month)) +
      geom_line() +
      labs(title = "Trips by Hour and Month",
           x = "Hour of the Day",
           y = "Number of Trips",
           color = "Month") +
      theme_minimal()
  })
  
  output$plot2 <- renderPlot({
    ggplot(combined_data, aes(x = Hour)) +
      geom_bar(stat = "count", fill = "pink") +  
      labs(title = "Trips Every Hour",
           x = "Hour of the Day",
           y = "Number of Trips") +
      theme_minimal()
  })
  
  output$plot3 <- renderPlot({
    ggplot(daily_trips, aes(x = Day, y = Trips, color = Day)) +
      geom_line() +
      labs(title = "Trips Taken Every Day of the Month",
           x = "Day of the Month",
           y = "Number of Trips",
           color = "Day of the Month") +
      theme_minimal()
  })
  
  output$plot4 <- renderPlot({
    ggplot(trips_by_weekday_and_month, aes(x = Month, y = Trips, fill = Weekday)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Trips by Day of the Week and Month",
           x = "Month",
           y = "Number of Trips",
           fill = "Day of the Week") +
      theme_minimal()
  })
  
  output$plot5 <- renderPlot({
    ggplot(trips_by_bases_month, aes(x = Base, y = Trips, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Trips by Bases and Month",
           x = "Base",
           y = "Number of Trips",
           fill = "Month") +
      theme_minimal()
  })
  
  output$plot6 <- renderPlot({
    ggplot(trips_by_hour_day, aes(x = Hour, y = Weekday, fill = Trips)) +
      geom_tile() +
      labs(title = "Trips by Hour and Day",
           x = "Hour of the Day",
           y = "Day of the Week",
           fill = "Number of Trips") +
      scale_fill_viridis_c() +
      theme_minimal()
  })
  
  output$plot7 <- renderPlot({
    ggplot(heatmap_by_month_day, aes(x = Month, y = Day, fill = Trips)) +
      geom_tile() +
      labs(title = "Trips by Month and Day",
           x = "Month",
           y = "Day of the Month",
           fill = "Number of Trips") +
      scale_fill_viridis_c() +  
      theme_minimal()
  })
  
  output$plot8 <- renderPlot({
    ggplot(heatmap_by_month_week, aes(x = Month, y = Week, fill = Trips)) +
      geom_tile() +
      labs(title = "Trips by Month and Week",
           x = "Month",
           y = "Week of the Year",
           fill = "Number of Trips") +
      scale_fill_viridis_c() +  
      theme_minimal()
  })
  
  output$plot9 <- renderPlot({
    ggplot(heatmap_by_bases_day, aes(x = Base, y = Weekday, fill = Trips)) +
      geom_tile() +
      labs(title = "Trips by Bases and Day of the Week",
           x = "Base",
           y = "Day of the Week",
           fill = "Number of Trips") +
      scale_fill_viridis_c() +  
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
