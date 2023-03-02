/* 
--------------------------------------------------------------------------------------------------------
Data Exploration for Unicorn Companies Analytics Project
--------------------------------------------------------------------------------------------------------


Reesearch Questions
=======================================================================================================
- Which unicorn companies have had the biggest return on investment?
- How long does it usually take for a company to become a unicorn?
- Which industries have the most unicorns? 
- Which countries have the most unicorns? 
- Which investors have funded the most unicorns?
=======================================================================================================
*/


USE UnicornCompanies

SELECT *
FROM UnicornCompanies.dbo.unicorn_info
ORDER BY 1 ASC

SELECT *
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY 1 ASC

-- Total Unicorn Companies
WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT COUNT(1) AS Unicorn
FROM UnicornCom
WHERE (Year - YearFounded) >= 0


-- Total Countries
WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT COUNT(DISTINCT Country) AS Country
FROM UnicornCom
WHERE (Year - YearFounded) >= 0


--------------------------------------------------------------------------------------------------------

/*
- Which unicorn companies have had the biggest return on investment?
*/


SELECT TOP 10 Company, (CONVERT(BIGINT, Valuation)-CONVERT(BIGINT, Funding))/CONVERT(BIGINT, Funding) AS Roi
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY Roi DESC
-- > 1.Zapier 2.Dunamu 3.Workhuman 4.CFGI 5.Manner 6.DJI Innovations 7.GalaxySpace 8.Canva 9.II Makiage 10.Revolution Precrafted


--------------------------------------------------------------------------------------------------------

/*
- How long does it usually take for a company to become a unicorn?
*/


-- Find average years to become a unicorn

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT CAST(AVG(Year - YearFounded) AS INT) AS AverageYear
FROM UnicornCom

-- > On average it takes 6 years to become a unicorn company


-- Details on how long it takes for the companies to become a unicorn

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT TOP 10 (Year - YearFounded) AS UnicornYear, COUNT(1) AS Frequency
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY (Year - YearFounded)
ORDER BY COUNT(1) DESC

-- Mostly take from 4 to 7 years to become a unicorn


--------------------------------------------------------------------------------------------------------

/*
- Which industries have the most unicorns? 
*/


-- Number of unicorn companies within each industry

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin
		ON inf.ID = fin.ID)
SELECT Industry, COUNT(1) as Frequency
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY Industry
ORDER BY COUNT(1) DESC

-- > Fintech followed by Internet software and services and e-commerce.


-- Number of unicorn companies within each industry and their shares

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin
		ON inf.ID = fin.ID
)
SELECT Industry, Count(1) AS Frequency, CAST(COUNT(1) * 100.0 / (SELECT COUNT(*) FROM UnicornCom) AS INT) AS 'Percentage'
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY Industry
ORDER BY Count(1) DESC


--------------------------------------------------------------------------------------------------------

/*
- Which countries have the most unicorns? 
*/


-- Number of unicorn companies within each country

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin
		ON inf.ID = fin.ID
)
SELECT Country, COUNT(1) AS Frequency
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY Country
ORDER BY Count(1) DESC

-- United States followed by China and India.


-- Number of unicorn companies within each country and their shares

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin
		ON inf.ID = fin.ID
)
SELECT TOP 10 Country, COUNT(1) AS Frequency, CAST(COUNT(1) * 100.0 / (SELECT COUNT(*) FROM UnicornCom) AS INT) AS 'Percentage'
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY Country
ORDER BY Count(1) DESC


--------------------------------------------------------------------------------------------------------

/*
- Which investors have funded the most unicorns?
*/


SELECT *
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY 1 ASC


-- Replace ', ' with ',' before doing the split

UPDATE UnicornCompanies.dbo.unicorn_finance
SET SelectInvestors = REPLACE(SelectInvestors, ', ', ',')


-- Get investor name list with their count

SELECT TOP 10 value AS Investors, COUNT(*) AS UnicornsInvested 
FROM UnicornCompanies.dbo.unicorn_finance
    CROSS APPLY STRING_SPLIT(SelectInvestors, ',')  
GROUP BY value  
ORDER BY COUNT(*) DESC 

-- > Accel followed  by Tiger Glabal Management and Andreessen Horowitz
