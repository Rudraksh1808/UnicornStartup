/*Unicorns that have a valuation of more than $1B and less than $10B*/
SELECT 
    Company,
    Valuation,
    CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END AS NumericValuation
FROM dbo.unicorn_info;

/*Find the Top 5 Unicorns Valuation*/
SELECT 
    Company,
    CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END AS NumericValuation
FROM dbo.unicorn_info
ORDER BY NumericValuation DESC
LIMIT 5;

/*Calculate the Average Valuation*/
SELECT 
    AVG(CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END) AS AverageValuation
FROM dbo.unicorn_info;


/*Count the Number of Unicorns in Each Industry with Valuation Above $1 Billion*/
SELECT 
    Industry, 
    COUNT(*) AS NumberOfUnicorns
FROM dbo.unicorn_info
WHERE 
    CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END > 1000000000
GROUP BY Industry;


/*List Unicorns by Country with Their Average Valuation*/
SELECT 
    Country,
    COUNT(*) AS NumberOfUnicorns,
    AVG(CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END) AS AverageValuation
FROM dbo.unicorn_info
WHERE Valuation IS NOT NULL
GROUP BY Country
ORDER BY AverageValuation DESC;

/*Identify the Top 3 Industries with the Highest Total Valuation*/
SELECT 
    Industry,
    SUM(CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END) AS TotalValuation
FROM dbo.unicorn_info
WHERE Valuation IS NOT NULL
GROUP BY Industry
ORDER BY TotalValuation DESC
LIMIT 3;


/*Find the Average Valuation by Continent*/
SELECT 
    Continent,
    AVG(CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END) AS AverageValuation
FROM dbo.unicorn_info
WHERE Valuation IS NOT NULL
GROUP BY Continent;


/*List the Most Recent Unicorns by Valuation*/
SELECT 
    Company,
    DateJoined,
    CASE 
        WHEN Valuation LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Valuation LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Valuation, 2), ',', '') AS DECIMAL(20, 2))
    END AS NumericValuation
FROM dbo.unicorn_info
WHERE Valuation IS NOT NULL
LIMIT 10;

/*Find the Unicorns with the Largest Funding Amounts*/
SELECT 
    Company,
    Funding,
    CASE 
        WHEN Funding LIKE '%B' THEN CAST(REPLACE(SUBSTRING(Funding, 2), ',', '') AS DECIMAL(20, 2)) * 1000000000
        WHEN Funding LIKE '%M' THEN CAST(REPLACE(SUBSTRING(Funding, 2), ',', '') AS DECIMAL(20, 2)) * 1000000
        ELSE CAST(REPLACE(SUBSTRING(Funding, 2), ',', '') AS DECIMAL(20, 2))
    END AS NumericFunding
FROM dbo.unicorn_info
WHERE Funding IS NOT NULL
ORDER BY NumericFunding DESC
LIMIT 10;

/*Count Unicorns Founded in Each Year*/
SELECT 
    YearFounded,
    COUNT(*) AS NumberOfUnicorns
FROM dbo.unicorn_info
WHERE YearFounded IS NOT NULL
GROUP BY YearFounded
ORDER BY YearFounded DESC;

/*Identify the Top 5 Investors in Unicorn Startups by Number of Investment*/
SELECT 
    SelectInvestors,
    COUNT(*) AS NumberOfInvestments
FROM dbo.unicorn_info
WHERE SelectInvestors IS NOT NULL
GROUP BY SelectInvestors
ORDER BY NumberOfInvestments DESC
LIMIT 5;


/*Comapnies took to become an Unicorn startup*/
SELECT 
    Company,
    YearFounded,
    YEAR(CURDATE()) - YearFounded AS YearsToUnicorn
FROM dbo.unicorn_info
WHERE Valuation LIKE '%B' AND Valuation IS NOT NULL
ORDER BY YearsToUnicorn;
