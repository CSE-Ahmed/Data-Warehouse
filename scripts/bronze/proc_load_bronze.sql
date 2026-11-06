CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY 
		SET @batch_start_time = GETDATE();
		PRINT '==========================================='
		PRINT '            Loading Bronze Layer           '
		PRINT '==========================================='

		print '------------------------------------------'
		print '            Loading CRM Tables            '
		print '------------------------------------------'
		--inert Data into bronze.crm_cust_info
		SET @start_time = GETDATE();
		print '>> Truncate Table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info
		print '>> inserting Date Into : bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 
		PRINT '-----------------------------------------'
		--insert Data into bronze.crm_prd_info
		SET @start_time = GETDATE();
		print '>> Truncate Table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info
		print '>> inserting Date Into : bronze.crm_prd_info' 
		BULK INSERT bronze.crm_prd_info
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 
		PRINT '------------------------------------------'
		SET @start_time = GETDATE();
		--insert Data into bronze.crm_sales_details
		print '>> Truncate Table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details
		print '>> inserting Date Into : bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 

		print '------------------------------------------'
		print '            Loading ERP Tables            '
		print '------------------------------------------'

		--insert Data into bronze.erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> Truncate Table : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12
		print '>> inserting Date Into : bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 
		PRINT '------------------------------------------------'
		--insert Data into bronze.erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncate Table : bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101
		print '>> inserting Date Into : bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 
		PRINT '------------------------------------------------'
		--insert Data into bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncate Table : bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		print '>> inserting Date Into : bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'G:\Random\Study\Courses\Technical skills\Data Analysis\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'TIME DIFF : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) 
		SET @batch_end_time = GETDATE();
		print '=========================================='
		print 'Loading Bronze Layer is completed'
		print '     Total Time Diff is : ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)
		print '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE()
		PRINT '========================================='
	END CATCH
	
END
