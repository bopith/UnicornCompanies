/* 
--------------------------------------------------------------------------------------------------------
Data Exploration for Unicorn Companies Analytics Project
--------------------------------------------------------------------------------------------------------
*/


Select *
From UnicornCompanies.dbo.unicorn_info
Order by 1

Select *
From UnicornCompanies.dbo.unicorn_finance
Order by 1

--------------------------------------------------------------------------------------------------------

-- Combine dbo.unicorn_info and dbo.unicorn_finance using Join based on company id

Select COALESCE (info.ID, finance.ID) as ID, COALESCE (info.Company, finance.Company) as Company, 
		Industry, City, Country, Continent, Valuation, DateJoined, YearFounded, Funding, SelectInvestors
From UnicornCompanies.dbo.unicorn_info as info
Join UnicornCompanies.dbo.unicorn_finance as finance
		on info.ID = finance.ID
Order by 1

