-- Clean and Prepare Company Data

-- 1. Handling Missing Values
-- Update missing values with NULL or appropriate values
UPDATE sp500_companies_db
SET Sector = NULL
WHERE Sector = '';

-- 2. Removing Duplicates
-- Identify duplicates and keep only one row per Symbol
WITH DuplicateRows AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Symbol ORDER BY Symbol) AS RowNumber
    FROM sp500_companies_db
)
DELETE FROM DuplicateRows
WHERE RowNumber > 1;

-- 3. Correcting Data Types
ALTER TABLE sp500_companies_db
ALTER COLUMN Marketcap DECIMAL(20, 0);

ALTER TABLE sp500_companies_db
ALTER COLUMN Ebitda DECIMAL(20, 0);

ALTER TABLE sp500_companies_db
ALTER COLUMN Revenuegrowth DECIMAL(5, 3);

ALTER TABLE sp500_companies_db
ALTER COLUMN Weight DECIMAL(10, 8);

ALTER TABLE sp500_companies_db
ALTER COLUMN Fulltimeemployees INT;

-- 4. Correcting Formatting Issues
UPDATE sp500_companies_db
SET Exchange = TRIM(Exchange),
    Symbol = TRIM(Symbol),
    Shortname = TRIM(Shortname),
    Longname = TRIM(Longname),
    Sector = TRIM(Sector),
    Industry = TRIM(Industry),
    City = TRIM(City),
    State = TRIM(State),
    Country = TRIM(Country);

SELECT  * FROM sp500_companies_db;



