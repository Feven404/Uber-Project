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
4. Base: the starting points or bases from which Uber trips originate
---
## Data Cleaning
Changed the csv files to RDS
<img src="Images/csv to rds.png", height = 500, width = 450>

Combined all the data and made the following changes regarding the Date/Time column:
1. Changed the data format under the Date/Time column to mm-dd-yyyy hh:mm:ss
2. Created a new column extracting only the hour from the Date/Time column
3. Created a new column extracting only the month from the Date/Time column and changing it from numeric to words like 09 would be displayed as September.
4. Created a new column extracting only the weekdays from the Date/Time column and displaying it as words like Monday, Tuesday, etc.
5. Created a new column extracting only the day in numeric value from the Date/Time column

<img src="Images/changing the datetime column.png", height = 500, width = 450>

Now the final table, combined_data, will look like this (this is only a small snippet of the table since there are millions of observations)

INSERT TABLE

---
## Data Analysis
### Pivot tables 
1. A pivot table showing the number of trips during every hour from April to September:
  INSERT IMAGE
2. A table showing the number of trips taken during each day of the month:
  INSERT IMAGE
3. A pivot table showing the number of trips taken by weekdy and month:
  INSERT IMAGE
4.A pivot table displaying the number of trips taken by bases and momth:
  INSERT IMAGE

---
## Heatmaps
1.A heatmap showing the number of trips by hour and day:
<img src = "Images/heatmap by hour and day.png" width = 450>
2. A heatmap showing the number of trips by month and day:
<img src = "Images/heatmap of trips by month and day.png" width = 450>
3. A heatmap displaying the number fo trips by month and week:
<img src = "Images/heatmap of trips by month and week.png" width = 450>
4. A heatmap dispalying the number of trips by bases and day of the week:
<img src = "Images/heatmap of trips by bases and weekday.png" width = 450>
## Saving Plots to RDS files
For all the plots constructed, includinh heatmaps, I saved it into a RDS file so it can be read in the ShinyApp project. Below are examples of the RDS files saved of charts:
<div align = "center">
<img src = "Images/rds file of daily trips graph.png" width = 450>
<img src = "Images/rds file of hourly trips graph.png" width = 450>
<img src = "Images/rds file of trips by bases and month graph.png" width = 450>
<img src = "Images/rds file of trips by hour and month graph.png" width = 450>
<img src = "Images/rds file of trips by weekday and month graph.png" width = 450>
<img src = "Images/rds file of heatmap bases and weekday.png" width = 450>
<img src = "Images/rds file of heatmap by hour nd day.png" width = 450>
<img src = "Images/rds file of heatmap by month and day.png" width = 450>
<img src = "Images/rds file of heatmap by month and week.png" width = 450>
</div>
---
## ShinyApp
<p>
  Created a ShinyApp which is accessible using the following link:
  [https://fevenf.shinyapps.io/UberAssignment/]
</p>



