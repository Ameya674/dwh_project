-- ===============================================================
-- LOAD DATA INTO THE TABLES IN SILVER SCHEMA
-- ===============================================================

-- ===============================================================
-- Run 'EXEC silver.load_silver' to load data in the bronze schema
-- ===============================================================


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

  BEGIN TRY

    SET @batch_start_time = GETDATE();
    PRINT '======================================';
		PRINT 'Loading Silver Layer';
		PRINT '======================================';

		PRINT '--------------------------------------';
		PRINT 'Load CRM Tables';
		PRINT '--------------------------------------';

    
  END TRY
  BEGIN CATCH
  END CATCH
END
