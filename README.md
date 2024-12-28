 
---

# **Data Cleaning Project: Staff Layoff Dataset**  

## **Overview**  
This project focuses on cleaning and preparing a dataset on staff layoffs for analysis. The raw data contained duplicates, null values, inconsistent formatting, and other issues that were systematically addressed. The cleaned dataset is now optimized for accurate analysis and reporting.  

---

## **Steps and Process**  

### **1. Review Raw Data**  
The original dataset was reviewed to understand its structure and identify potential issues, including:  
- Missing values  
- Duplicates  
- Formatting inconsistencies  

### **2. Create a Staging Table**  
A staging table was created to ensure the raw dataset remained unchanged. All cleaning and transformation steps were performed on this table.

### **3. Add and Populate Serial Numbers**  
A serial number column (`SN`) was added to track individual rows. This helped in identifying and managing duplicates and other transformations effectively.

### **4. Identify and Remove Duplicates**  
Duplicates were identified by grouping data based on the following columns:  
- `company`  
- `date`  
- `country`  
- `percentage_laid_off`  
Only the most recent or relevant entries were retained.

### **5. Standardize Data**  
Data standardization steps included:  
1. **Trimming extra spaces**: Ensured uniformity in the `company` column.  
2. **Normalizing industry names**: Converted variations like "crypto" and "cryptocurrency" to a consistent term (`Crypto`).  
3. **Fixing country names**: Removed punctuation and ensured consistency (e.g., `United States` instead of `United States.`).  
4. **Adjusting the date column**: Converted the `date` column to a proper date data type for easier analysis.

### **6. Handle Null or Blank Values**  
Null or blank values were addressed, particularly in the `industry` column, by referencing existing records in the dataset. This ensured data completeness while maintaining accuracy.

### **7. Remove Unnecessary Data**  
Unnecessary rows and columns were removed, such as:  
- Rows with null values in critical fields (e.g., `total_laid_off`, `percentage_laid_off`).  
- Temporary columns like `SN` that were used during data cleaning.  

---

## **Final Output**  
The cleaned dataset now meets the following criteria:  
- **No duplicates**: All duplicate rows were removed.  
- **Consistent formatting**: Columns follow a uniform standard.  
- **Addressed null values**: Missing data is handled appropriately.  
- **Streamlined structure**: Removed unnecessary columns and rows for better analysis.  

The dataset is ready for analysis and reporting.  

---

## **Tools and Technologies**  
- **Database**: SQL Server  
- **Techniques**:  
  - Data cleaning  
  - Deduplication  
  - Data standardization  

---

## **How to Use This Project**  

1. **Clone this repository** to your local machine.  
2. **Run the SQL scripts** step by step in SQL Server to reproduce the data cleaning process.  
3. **Review the cleaned dataset** in the `layoffs_staging` table for analysis.  

---

### **Example Outputs**  
You can expect:  
- A clean, standardized dataset ready for insights.  
- Consistent formatting in all columns.  
- Easy-to-read and fully prepped data for dashboards or further analysis.  

Feel free to raise any questions or suggestions in the Issues tab of this repository!  

 

 
 
