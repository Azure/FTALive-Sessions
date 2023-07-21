SELECT TOP 1 * FROM 
	OPENROWSET(BULK 'https://***.blob.core.windows.net/*/*/*.parquet', 
	FORMAT='PARQUET') AS R
