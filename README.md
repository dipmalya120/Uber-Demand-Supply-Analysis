# Uber-Demand-Supply-Analysis

## 📌 Project Overview

This project analyzes ride request data from Uber with the goal of identifying operational bottlenecks and improving service performance. The dataset captures user trip requests over a short time window, including timestamps, pickup points, and final trip statuses (Completed, Cancelled, or No Cars Available).

---

## 🎯 Problem Statement & Business Objective

Despite strong demand, Uber often fails to meet customer expectations due to trip cancellations and unavailability of drivers—especially during peak hours and at specific pickup points.

**Business Objective**:
- Identify **demand-supply gaps** across hours and pickup locations.
- Improve **driver allocation** and **customer satisfaction**.
- Reduce the frequency of **cancellations** and **missed ride opportunities**.

---

## 🧰 Tools & Technologies Used

| Tool | Purpose |
|------|---------|
| **Python (Pandas, Matplotlib, Seaborn)** | Data wrangling, cleaning, EDA, and visualization |
| **Excel** | Initial inspection, formatting, and exploratory filtering |
| **SQL** | For querying structured summaries during pre-analysis |
| **Jupyter Notebook** | Step-by-step analysis and visualization |

---

## 🧪 Exploratory Data Analysis (EDA)

- Checked for **null values**, duplicates, and inconsistent timestamp formats
- Converted string dates to `datetime` format and extracted **hourly bins**
- Created **segmented visualizations** to understand hourly trends and pickup-specific performance

---

## 📊 Key Visualizations

1. **Pie Chart**: Distribution of overall trip statuses  
2. **Bar Chart**: Trip counts by Pickup Location (City vs Airport)  
3. **Stacked Bar Charts**: Percentage of trip statuses across locations  
4. **Line Charts**: Hourly trip request trends from City and Airport  
5. **Box Plot & Pie Chart**: Summary of driver performance  
6. **Missing Value Heatmaps**: Understand data quality issues  

> 📌 **All visualizations include proper annotations, styling, and business-readable formatting.**

---

## 🔍 Key Insights

- **City dominates ride requests**, especially between **5 AM to 9 AM**, while **Airport demand spikes from 5 PM to 9 PM**.
- The **Airport consistently faces service issues**, mainly "No Cars Available".
- A significant portion of trips are either **cancelled or not fulfilled**, especially during high-demand windows.
- **Driver performance is varied**, indicating a potential for personalized incentives or performance monitoring.

---

## 💼 Business Impact

- The analysis can help Uber **realign driver distribution**, especially for underserved Airport zones.
- Enables **data-driven scheduling** and **dynamic pricing** based on demand patterns.
- Reduces customer churn by identifying and mitigating **service failures** in specific time blocks.

---
