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
Select Company, COUNT(Company)
FROM UnicornCompanies.dbo.unicorn_info
GROUP BY Company
HAVING COUNT(Company) > 1

Select Company, COUNT(Company)
FROM UnicornCompanies.dbo.unicorn_finance
GROUP BY Company
HAVING COUNT(Company) > 1

-- > Bolt and Fabric appear twice in both data sets. Anyway, they are in different cities / countries.


