--View the data. table name is layoffs
SELECT * 
FROM layoffs 
 
--to avoid changing the raw dataset lets create a new table layoffs_staging
SELECT * INTO layoffs_staging 
FROM layoffs

--add a column serial number
ALTER TABLE layoffs_staging
ADD SN int;

--poulate serial number column from 1
DECLARE @n1 int
SET @n1 = 0
UPDATE layoffs_staging
SET SN = @n1,
	@n1 = @n1 + 1

--TO group the data by multiple columns to see which one has duplicates
SELECT  total_laid_off, company, layoffs_staging.date, country, percentage_laid_off,   count(*)
FROM layoffs_staging
GROUP BY total_laid_off, company, layoffs_staging.date, country,  percentage_laid_off
HAVING COUNT(*) > 1


--removing duplicates
DELETE FROM layoffs_staging
WHERE SN IN(
SELECT max(SN)
FROM layoffs_staging
GROUP BY total_laid_off, company, layoffs_staging.date, country,  percentage_laid_off
HAVING COUNT(*) > 1
	)
	
--standardize data

--1 trim company column
SELECT *
FROM layoffs_staging

UPDATE layoffs_staging
SET company = trim(company)  

--2 update all crypto related industry data to read crypto instead of some crypto and some cryptocurrency from industry column

UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%'  

--3 there is United states with a fulstop at the end in country column so we have to se all to just united states

UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States%'  

--4 change date column data type to date

UPDATE layoffs_staging
SET date = convert(nvarchar(50), date, 101)

ALTER TABLE layoffs_staging
ALTER COLUMN date date

-- we needed to delete this row below because it had null date value and because of that date data type couldnt be effected
DELETE FROM layoffs_staging
WHERE company='blackbaud'
 

--null or blank values(populate or not)
--we start with INDUSTRY column

SELECT *
FROM layoffs_staging
WHERE industry IS NULL
OR industry = ''

 
 -- to populate the missing values in industry column

SELECT t1.industry, t2.industry
FROM layoffs t1
JOIN layoffs t2
ON t1.company =t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL

UPDATE layoffs t1
JOIN layoffs t2
ON t1.company =t2.company
SET t1.industry = t2.industry 
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL


--remove unnecessary columns or rows

SELECT *
FROM layoffs_staging
WHERE total_laid_off = 'null'
AND percentage_laid_off  = 'null'

DELETE
FROM layoffs_staging
WHERE total_laid_off = 'null'
AND percentage_laid_off  = 'null'

SELECT *
FROM layoffs_staging

ALTER TABLE layoffs_staging
DROP COLUMN SN
