/* 
--------------------------------------------------------------------------------------------------------
Data Cleaning for Unicorn Companies Analytics Project
--------------------------------------------------------------------------------------------------------
*/


Select *
From UnicornCompanies.dbo.unicorn_info
Order by ID

Select *
From UnicornCompanies.dbo.unicorn_finance
Order by ID

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

Exec sp_rename 'dbo.unicorn_finance.[Date Joined]', 'DateJoined', 'COLUMN'
Exec sp_rename 'dbo.unicorn_finance.[Year Founded]', 'YearFounded', 'COLUMN'
Exec sp_rename 'dbo.unicorn_finance.[Select Investors]', 'SelectInvestors', 'COLUMN'


--------------------------------------------------------------------------------------------------------

-- Standardize date joined format & break out date joined into individual columns (Year, Month, Day)

Alter Table UnicornCompanies.dbo.unicorn_finance
Add DateJoinedConverted Date
Update UnicornCompanies.dbo.unicorn_finance
Set DateJoinedConverted = Convert(Date, DateJoined)

Alter Table UnicornCompanies.dbo.unicorn_finance
Add Year int
Update UnicornCompanies.dbo.unicorn_finance
Set Year = datepart(year, DateJoinedConverted)

Alter Table UnicornCompanies.dbo.unicorn_finance
Add Month int
Update UnicornCompanies.dbo.unicorn_finance
Set Month = datepart(month, DateJoinedConverted)

Alter Table UnicornCompanies.dbo.unicorn_finance
Add Day int
Update UnicornCompanies.dbo.unicorn_finance
Set Day = datepart(day, DateJoinedConverted)

Select *
From UnicornCompanies.dbo.unicorn_finance


--------------------------------------------------------------------------------------------------------

-- Reformat currency value

-- "Valuation" and "Funding" columns

Update UnicornCompanies.dbo.unicorn_finance
Set Valuation = RIGHT(Valuation, LEN(Valuation) - 1)

Update UnicornCompanies.dbo.unicorn_finance
Set Valuation = Replace(Replace(Valuation, 'B','000000000'), 'M', '000000')

Update UnicornCompanies.dbo.unicorn_finance
Set Funding = Replace(Replace(Funding, 'B','000000000'), 'M', '000000')

Select *
From UnicornCompanies.dbo.unicorn_finance


--------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Alter Table UnicornCompanies.dbo.unicorn_finance
Drop Column DateJoined

Exec sp_rename 'dbo.unicorn_finance.DateJoinedConverted', 'DateJoined', 'COLUMN'

Select *
From UnicornCompanies.dbo.unicorn_finance
