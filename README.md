# Uber Project
## Feven Ferede
---
## Introduction
This project involved the analysis of Uber rides and included was ShinyApp for visualisation.
<div align = "center">
<img src = "Images/uber photo.webp" width = "450")>
</div>
---
##Data Dictionary
<p>
  1. Date/Time:
  2. Lat:
  3. Lon:
  4. Base
</p>
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
<p>
Created pivot tables for the following:
1. A pivot table showing the number of trips during every hour from April to September:
  INSERT IMAGE
2. A table showing the number of trips taken during each day of the month:
  INSERT IMAGE
3. A pivot table showing the number of trips taken by weekdy and month:
  INSERT IMAGE
4.A pivot table displaying the number of trips taken by bases and momth:
  INSERT IMAGE

</p>

---

### Heatmaps
<p>
Created heatmaps for the following:
1.A heatmap showing the number of trips by hour and day:
  INSERT IMAGE
2. A heatmap showing the number of trips by month and day:
  INSERT IMAGE
3. A heatmap displaying the number fo trips by month and week:
  INSERT IMAGE
4. A heatmap dispalying the number of trips by bases and day of the week:
  INSERT IMAGE
</p>

### Saving Plots to RDS files
<p>
  For all the plots constructed, I saved it into a RDS file so it can be read in the ShinyApp project. Below are examples of the RDS files saved of charts:
  INSERT IMAGE
  INSERT IMAGE
  INSERT IMAGE
</p>

---
## ShinyApp
<p>
  Created a ShinyApp which is accessible using the following link:
  [https://fevenf.shinyapps.io/UberAssignment/]
</p>



