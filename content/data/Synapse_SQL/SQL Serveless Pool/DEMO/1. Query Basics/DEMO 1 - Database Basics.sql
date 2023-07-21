---- CREATE A DATABASE
USE [master];
GO
DROP DATABASE IF EXISTS [Demo1];
GO
CREATE DATABASE Demo1;
GO
---- USE DB

USE [Demo1];
GO

---- CREATE A SCHEMA

CREATE SCHEMA [meta];
GO

---- CREATE A VIEW

CREATE VIEW meta.GetVersion
AS
SELECT @@Version as TheCurrentVersion;
GO
---- EXECUTE THE VIEW

SELECT * FROM meta.GetVersion;
GO

--- TAKE A LOOK AT THE DATA TAB
--- Infers Schema 


--- CREATE A Stored Procedure

CREATE PROCEDURE meta.GetColumnsFromID @colid INT
AS
BEGIN
SELECT [name],[max_length]
into #TempTable
FROM sys.columns
where column_id = @colid

--- YEP TEMPDB
SELECT * FROM #TempTable
END;
GO

--- Execute the Stored Procedure

EXEC meta.GetColumnsFromID 1;
GO

--- TAKE A LOOK AT THE DATA TAB
--- Where are the SP'S???

select * from sys.sql_modules;
GO
--- OR

--- OPEN UP SSMS

--- CREATE A FUNCTION

--- SCALAR FUNCTIONS CURRENTLY NOT SUPPORTED

CREATE FUNCTION meta.ModulesByType(@objectType CHAR(2) = '%%')
RETURNS TABLE
AS
RETURN
(
	SELECT 
		sm.object_id AS 'Object Id',
		o.create_date AS 'Date Created',
		OBJECT_NAME(sm.object_id) AS 'Name',
		o.type AS 'Type',
		o.type_desc AS 'Type Description', 
		sm.definition AS 'Module Description'
	FROM sys.sql_modules AS sm  
	JOIN sys.objects AS o ON sm.object_id = o.object_id
	WHERE o.type like '%' + @objectType + '%'
);
GO


--- Execute Function
select * from meta.ModulesByType('V');
GO

--- Functions are also not present in the database tab
--- Check sys.
select * from sys.sql_modules;
GO

--- OR
--- USE SSMS


--- CROSS DB Queries

---- CREATE A DATABASE
USE [master];
GO
DROP DATABASE IF EXISTS [Demo1CrossDB];
GO
CREATE DATABASE Demo1CrossDB;
GO
USE Demo1CrossDB;
GO
CREATE SCHEMA [meta];
GO

--- EXECUTE CROSS DB Query

select DB1.[name], DB2.[name] from Demo1CrossDB.sys.columns DB1
CROSS APPLY Demo1.meta.ModulesByType('V') DB2;
GO



--- CREATE LOGIN for Jovan
/*
USE [master]
CREATE LOGIN [jovanpop@microsoft.com] FROM EXTERNAL PROVIDER;
GO
*/
--- CREATE USER FOR KEVIN AND GRANT READ RIGHTS

USE [Demo1];
GO
CREATE USER [Jovan] FROM LOGIN [jovanpop@microsoft.com];
GO
alter role db_datareader ADD MEMBER [Jovan]


--- RUN AS Jovan
EXECUTE AS USER = 'Jovan';

SELECT * FROM meta.GetVersion

REVERT;




