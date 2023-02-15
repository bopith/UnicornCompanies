/* 
--------------------------------------------------------------------------------------------------------
Data Cleaning for Unicorn Companies Analytics Project
--------------------------------------------------------------------------------------------------------
*/


Select *
From UnicornCompanies.dbo.unicorn_info
Order by Company

Select *
From UnicornCompanies.dbo.unicorn_finance
Order by Company

--------------------------------------------------------------------------------------------------------

-- Check duplicate company name

Select Company, Count(Company)
From UnicornCompanies.dbo.unicorn_info
Group by Company
Having Count(Company) > 1

Select Company, Count(Company)
From UnicornCompanies.dbo.unicorn_finance
Group by Company
Having Count(Company) > 1

-- > Bolt and Fabric appear twice in both data sets. Anyway, they are in different cities / countries. 
-- > Therefore, we will keep those data.


--------------------------------------------------------------------------------------------------------

-- Rename columns in dbo.unicorn_finance
Select *
From UnicornCompanies.dbo.unicorn_finance


EXEC sp_rename 'dbo.unicorn_finance.[Date Joined]', 'DateJoined', 'COLUMN'
EXEC sp_rename 'dbo.unicorn_finance.[Year Founded]', 'YearFounded', 'COLUMN'
EXEC sp_rename 'dbo.unicorn_finance.[Select Investors]', 'SelectInvestors', 'COLUMN'


--------------------------------------------------------------------------------------------------------

-- Standardize date joined format

ALTER TABLE UnicornCompanies.dbo.unicorn_finance
Add DateJoinedConverted Date

Update UnicornCompanies.dbo.unicorn_finance
SET DateJoinedConverted = CONVERT(Date, DateJoined)

Select *
From UnicornCompanies.dbo.unicorn_finance



