/* 
--------------------------------------------------------------------------------------------------------
Data Cleaning for Unicorn Companies Analytics Project
--------------------------------------------------------------------------------------------------------
*/


USE UnicornCompanies

SELECT *
FROM UnicornCompanies.dbo.unicorn_info
ORDER BY 1 ASC

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY 1 ASC


--------------------------------------------------------------------------------------------------------

-- Check duplicate company name

SELECT Company, COUNT(Company)
FROM UnicornCompanies.dbo.unicorn_info
GROUP BY Company
HAVING COUNT(Company) > 1

SELECT Company, COUNT(Company)
FROM UnicornCompanies.dbo.unicorn_finance
GROUP BY Company
HAVING COUNT(Company) > 1
-- > Bolt and Fabric appear twice in both data sets. Anyway, they are in different cities / countries. 
-- > Therefore, we will keep those data.


--------------------------------------------------------------------------------------------------------

-- Rename columns
EXEC sp_rename 'dbo.unicorn_info.[Year Founded]', 'YearFounded', 'COLUMN';
EXEC sp_rename 'dbo.unicorn_finance.[Date Joined]', 'DateJoined', 'COLUMN';
EXEC sp_rename 'dbo.unicorn_finance.[Select Investors]', 'SelectInvestors', 'COLUMN';

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance


--------------------------------------------------------------------------------------------------------

-- Standardize date joined format & break out date joined into individual columns (Year, Month, Day)

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
ADD DateJoinedConverted DATE
UPDATE UnicornCompanies.dbo.unicorn_finance
SET DateJoinedConverted = CONVERT(DATE, DateJoined)

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
ADD Year INT
UPDATE UnicornCompanies.dbo.unicorn_finance
SET Year = DATEPART(YEAR, DateJoinedConverted)

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
ADD Month INT
UPDATE UnicornCompanies.dbo.unicorn_finance
SET Month = DATEPART(MONTH, DateJoinedConverted)

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
ADD Day INT
UPDATE UnicornCompanies.dbo.unicorn_finance
SET Day = DATEPART(DAY, DateJoinedConverted)

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance


--------------------------------------------------------------------------------------------------------

-- Drop rows where Funding column contain 0 or Unknown

DELETE FROM UnicornCompanies.dbo.unicorn_finance 
WHERE Funding IN ('$0M', 'Unknown')

SELECT DISTINCT Funding
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY Funding DESC


--------------------------------------------------------------------------------------------------------

-- Reformat currency value

-- "Valuation" and "Funding" columns

UPDATE UnicornCompanies.dbo.unicorn_finance
SET Valuation = RIGHT(Valuation, LEN(Valuation) - 1)

UPDATE UnicornCompanies.dbo.unicorn_finance
SET Valuation = REPLACE(REPLACE(Valuation, 'B','000000000'), 'M', '000000')

UPDATE UnicornCompanies.dbo.unicorn_finance
SET Funding = RIGHT(Funding, LEN(Funding) - 1)

UPDATE UnicornCompanies.dbo.unicorn_finance
SET Funding = REPLACE(REPLACE(Funding, 'B','000000000'), 'M', '000000')

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance


--------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
DROP COLUMN DateJoined

EXEC sp_rename 'dbo.unicorn_finance.DateJoinedConverted', 'DateJoined', 'COLUMN'

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance
