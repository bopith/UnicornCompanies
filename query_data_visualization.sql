/* 
--------------------------------------------------------------------------------------------------------
Queries for Data Visualization
--------------------------------------------------------------------------------------------------------
*/


USE UnicornCompanies


-- Table 1
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


-- Table 2 

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT Company, Country
FROM UnicornCom
WHERE (Year - YearFounded) >= 0



-- Table 3

SELECT Company, (CONVERT(BIGINT, Valuation)-CONVERT(BIGINT, Funding))/CONVERT(BIGINT, Funding) AS Roi
FROM UnicornCompanies.dbo.unicorn_finance
ORDER BY Roi DESC


-- Table 4

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT Company, (Year - YearFounded) AS UnicornYear
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
-- GROUP BY (Year - YearFounded)
-- ORDER BY COUNT(1) DESC


WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin 
		ON inf.ID = fin.ID)
SELECT (Year - YearFounded) AS UnicornYear, COUNT(1) AS Frequency
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY (Year - YearFounded)
ORDER BY COUNT(1) DESC



-- Table 5

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


-- Table 6

WITH UnicornCom (ID, Company, Industry, City, Country, Continent, Valuation, Funding, YearFounded, Year, SelectInvestors) AS
	(SELECT inf.ID, inf.Company, inf.Industry, inf.City, inf.Country, inf.Continent, fin.Valuation, fin.Funding, inf.YearFounded, 
			fin.Year, fin.SelectInvestors
	FROM UnicornCompanies.dbo.unicorn_info AS inf
	INNER JOIN UnicornCompanies.dbo.unicorn_finance AS fin
		ON inf.ID = fin.ID
)
SELECT Country, COUNT(1) AS Frequency, CAST(COUNT(1) * 100.0 / (SELECT COUNT(*) FROM UnicornCom) AS INT) AS 'Percentage'
FROM UnicornCom
WHERE (Year - YearFounded) >= 0
GROUP BY Country
ORDER BY Count(1) DESC


-- Table 7

SELECT value AS Investors, COUNT(*) AS UnicornsInvested 
FROM UnicornCompanies.dbo.unicorn_finance
    CROSS APPLY STRING_SPLIT(SelectInvestors, ',')  
GROUP BY value  
ORDER BY COUNT(*) DESC 