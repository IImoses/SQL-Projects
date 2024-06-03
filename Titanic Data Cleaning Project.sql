select * 
from layoffs_staging
 
 

--to avoid changing the raw dataset lets create a new table layoffs_staging
SELECT * INTO layoffs_staging 
from layoffs

WITH CTE_duplicates AS(
select *
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off 'date'
order by(select null))
from layoffs_staging)

--add a column serial number
ALTER TABLE layoffs_staging
ADD SN int;

--poulate serial number column from 1
declare @n1 int
set @n1 = 0
update layoffs_staging
set SN = @n1
,@n1 = @n1 + 1

--TO group the data by multiple columns to see which one has duplicates
select  total_laid_off, company, layoffs_staging.date, country, percentage_laid_off,   count(*)
from layoffs_staging
group by total_laid_off, company, layoffs_staging.date, country,  percentage_laid_off
having count(*) > 1


--removing duplicates
delete from layoffs_staging
	where SN in(
	select max(SN)
	from layoffs_staging
	group by total_laid_off, company, layoffs_staging.date, country,  percentage_laid_off
	having count(*) > 1
	)
--standardize data

--1 trim company column
select *
	from layoffs_staging

update layoffs_staging
	set company = trim(company)  

--2 update all crypto related industry data to read crypto instead of some crypto and some cryptocurrency from industry column

update layoffs_staging
set industry = 'Crypto'
where industry like 'crypto%'  

--3 there is United states with a fulstop at the end in country column so we have to se all to just united states

update layoffs_staging
set country = 'United States'
where country like 'United States%'  

--4 change date column data type to date

update layoffs_staging
set date = convert(nvarchar(50), date, 101)

alter table layoffs_staging
alter column date date

-- we needed to delete this row below because it had null date value and because of that date data type couldnt be effected
delete from layoffs_staging
where company='blackbaud'
 

--null or blank values(populate or not)
--we start with INDUSTRY column

select *
from layoffs_staging
where industry IS NULL
OR industry = ''

select *
from layoffs_staging
where company LIKE 'Airb%'

UPDATE layoffs_staging
SET industry = 'Travel'
where company LIKE 'Airb%'

select *
from layoffs_staging
where company LIKE 'Juul'

UPDATE layoffs_staging
SET industry = 'Consumer'
where company LIKE 'Juul'

select *
from layoffs_staging
where company LIKE 'Carvana'

UPDATE layoffs_staging
SET industry = 'Transportation'
where company LIKE 'Carvana'

 --another way to populate the missing values in industry column

select t1.industry, t2.industry
from layoffs t1
join layoffs t2
	on t1.company =t2.company
where t1.industry is null
and t2.industry is not null

Update layoffs t1
join layoffs t2
	on t1.company =t2.company
set t1.industry = t2.industry 
where t1.industry is null
and t2.industry is not null


--remove unnecessary columns or rows

select *
from layoffs_staging
where total_laid_off = 'null'
and percentage_laid_off  = 'null'

delete
from layoffs_staging
where total_laid_off = 'null'
and percentage_laid_off  = 'null'

select *
from layoffs_staging

alter table layoffs_staging
drop column SN