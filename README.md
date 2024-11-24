## **World Life Expectancy Exploratory Analysis**

### **Overview**
This project focuses on analyzing and cleaning a dataset related to global life expectancy trends using MySQL. The aim was to explore insights such as the impact of GDP and BMI on life expectancy, changes in life expectancy over 15 years, and differences across countries and development statuses.

---

### **Objectives**
1. Clean the dataset to remove inconsistencies, blanks, and duplicates.
2. Perform exploratory data analysis (EDA) to derive meaningful insights.
3. Utilize SQL queries for data transformation, aggregation, and visualization.

---

### **Steps and Methods**
#### **1. Data Cleaning**
- **Identify and Remove Duplicates**  
  Used `ROW_NUMBER()` and `DELETE` queries to identify and delete duplicate records.
  
- **Handle Missing Values**  
  - Replaced blanks in the `Status` column with "Developing" by joining related rows.
  - Estimated missing `Life expectancy` values using the average of the previous and next years for the same country.

- **Validation Checks**  
  - Checked for blanks and `NULL` values across critical columns like `Status` and `Life expectancy`.

#### **2. Data Analysis**
- **Life Expectancy Trends**  
  - Analyzed life expectancy changes over 15 years for each country.  
  - Calculated the average life expectancy by year and country.

- **Impact of GDP**  
  - Compared life expectancy in countries with high GDP (≥ 1500) versus low GDP.  
  - Derived average GDP and life expectancy for each country.

- **Impact of BMI**  
  - Assessed the correlation between BMI and life expectancy.

- **Rolling Totals**  
  - Computed cumulative adult mortality by country using window functions.



=

### **How to Use**
1. Clone the repository:  
   ```bash
   git clone <repo-link>
   ```
=

---

### **Tools Used**
- **MySQL** for database management and queries.


---
