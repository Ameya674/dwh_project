-- ===============================================================
-- THIS SCRIPT CREATES THE DATAWAREHOUSE AND THE SCHEMAS INSIDE IT
-- ===============================================================

-- ====================================================================
-- What does the script do?
-- This script first checks if a database named 'DataWarehouse' exists.
-- It then disconnects all users and switches to single-user mode.
-- It then drops the database and creates a new database with the name 
-- 'DataWarehouse'.
-- Then it creates the bronze, silver and gold schemas.
-- ====================================================================

-- use the master database
USE master;

-- drop if the database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

-- create the database called DataWarehouse
CREATE DATABASE DataWarehouse;
GO

-- use this newly created database
USE DataWarehouse;
GO

-- create the bronze, silver and gold schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
