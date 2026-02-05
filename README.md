# World Life Expectancy SQL Project

## 📌 Project Overview
This project focuses on cleaning, transforming, and analyzing the **World Life Expectancy** dataset using MySQL.  
The goal is to fix inconsistencies, remove duplicates, fill missing values, and perform exploratory data analysis to uncover global health patterns.

## 🗂️ Project Structure
- **01_data_cleaning.sql**  
  Removes duplicates, fixes missing Status values, imputes missing Life Expectancy values, and standardizes the dataset.

- **02_exploratory_analysis.sql**  
  Performs EDA including:
  - Life expectancy trends
  - GDP correlation
  - Status-based comparisons (Developed vs Developing)
  - BMI analysis
  - Rolling totals using window functions

## 🧹 Data Cleaning Tasks Performed
- Identified and removed duplicate records  
- Filled missing `Status` values using self-joins  
- Imputed missing `Life expectancy` using previous and next year averages  
- Validated country-level consistency  
- Ensured no empty or zero values in key metrics

## 📊 Key Insights from EDA
- Countries with higher GDP generally show higher life expectancy  
- Developing countries have lower average life expectancy  
- BMI shows a noticeable relationship with life expectancy  
- Rolling mortality totals reveal long-term health trends

## 🛠️ Tech Stack
- MySQL
- Window functions
- Aggregations, joins, CTE-style logic
- Data cleaning and transformation techniques

## 🚀 How to Use
1. Run worldlifeexpectancy.sqlto reproduce the insights
2. Modify queries as needed for deeper analysis

## 👤 About Me
I’m a data and business analytics professional focusing on SQL-driven insights, data cleaning, and real-world analytical problem solving.
