## Synapse SQL dedicate pool 

#### Security Data

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Serveless%20SQL%20Pool.md)


#### Dynamic data masking 

Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to designate how much of the sensitive data to reveal with minimal impact on the application layer. It's a policy-based security feature that hides the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed.

![image](https://user-images.githubusercontent.com/62876278/208091921-ec6b4389-f273-4c8a-8161-3ccf6f0239ce.png)


##### Dynamic data masking policy

- **SQL users excluded from masking** - A set of SQL users or Azure AD identities that get unmasked data in the SQL query results. Users with administrator privileges are always excluded from masking, and see the original data without any mask.
- **Masking rules** - A set of rules that define the designated fields to be masked and the masking function that is used. The designated fields can be defined using a database schema name, table name, and column name.
- **Masking functions** - A set of methods that control the exposure of data for different scenarios.

| Masking function  | Masking logic                                                |
| :---------------- | :----------------------------------------------------------- |
| **Default**       | **Full masking according to the data types of the designated fields**  • Use XXXX or fewer Xs if the size of the field is less than 4 characters for string data types (nchar, ntext, nvarchar). • Use a zero value for numeric data types (bigint, bit, decimal, int, money, numeric, smallint, smallmoney, tinyint, float, real). • Use 01-01-1900 for date/time data types (date, datetime2, datetime, datetimeoffset, smalldatetime, time). • For SQL variant, the default value of the current type is used. • For XML the document <masked/> is used. • Use an empty value for special data types (timestamp table, hierarchyid, GUID, binary, image, varbinary spatial types). |
| **Credit card**   | **Masking method, which exposes the last four digits of the designated fields** and adds a constant string as a prefix in the form of a credit card.  XXXX-XXXX-XXXX-1234 |
| **Email**         | **Masking method, which exposes the first letter and replaces the domain with XXX.com** using a constant string prefix in the form of an email address.  aXX@XXXX.com |
| **Random number** | **Masking method, which generates a random number** according to the selected boundaries and actual data types. If the designated boundaries are equal, then the masking function is a constant number.  ![Screenshot that shows the masking method for generating a random number.](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/dynamic-data-masking-overview/1_ddm_random_number.png?view=azuresql) |
| **Custom text**   | **Masking method, which exposes the first and last characters** and adds a custom padding string in the middle. If the original string is shorter than the exposed prefix and suffix, only the padding string is used. prefix[padding]suffix  ![Navigation pane](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/dynamic-data-masking-overview/2_ddm_custom_text.png?view=azuresql) |

##### Creating a Dynamic Data Mask

The following example creates a table with three different types of dynamic data masks. The example populates the table, and selects to show the result.

SQLCopy

```sql
-- schema to contain user tables
CREATE SCHEMA Data;
GO

-- table with masked columns
CREATE TABLE Data.Membership(
    MemberID        int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
    FirstName        varchar(100) MASKED WITH (FUNCTION = 'partial(1, "xxxxx", 1)') NULL,
    LastName        varchar(100) NOT NULL,
    Phone            varchar(12) MASKED WITH (FUNCTION = 'default()') NULL,
    Email            varchar(100) MASKED WITH (FUNCTION = 'email()') NOT NULL,
    DiscountCode    smallint MASKED WITH (FUNCTION = 'random(1, 100)') NULL
    );

-- inserting sample data
INSERT INTO Data.Membership (FirstName, LastName, Phone, Email, DiscountCode)
VALUES   
('Roberto', 'Tamburello', '555.123.4567', 'RTamburello@contoso.com', 10),  
('Janice', 'Galvin', '555.123.4568', 'JGalvin@contoso.com.co', 5),  
('Shakti', 'Menon', '555.123.4570', 'SMenon@contoso.net', 50),  
('Zheng', 'Mu', '555.123.4569', 'ZMu@contoso.net', 40);  
```

A new user is created and granted the **SELECT** permission on the schema where the table resides. Queries executed as the `MaskingTestUser` view masked data.

SQLCopy

```sql
CREATE USER MaskingTestUser WITHOUT LOGIN;  

GRANT SELECT ON SCHEMA::Data TO MaskingTestUser;  
  
  -- impersonate for testing:
EXECUTE AS USER = 'MaskingTestUser';  

SELECT * FROM Data.Membership;  

REVERT;  
```

The result demonstrates the masks by changing the data from

```
1 Roberto Tamburello 555.123.4567 RTamburello@contoso.com 10
```

into

```
1 Rxxxxxo Tamburello xxxx RXXX@XXXX.com 91
```

where the number in DiscountCode is random for every query result.

##### Adding or editing a mask on an existing column

Use the **ALTER TABLE** statement to add a mask to an existing column in the table, or to edit the mask on that column.
The following example adds a masking function to the `LastName` column:

SQLCopy

```sql
ALTER TABLE Data.Membership  
ALTER COLUMN LastName ADD MASKED WITH (FUNCTION = 'partial(2,"xxxx",0)');  
```

The following example changes a masking function on the `LastName` column:

SQLCopy

```sql
ALTER TABLE Data.Membership  
ALTER COLUMN LastName varchar(100) MASKED WITH (FUNCTION = 'default()');  
```

#### Granting permissions to view unmasked data

Granting the **UNMASK** permission allows `MaskingTestUser` to see the data unmasked.

SQLCopy

```sql
GRANT UNMASK TO MaskingTestUser;  

EXECUTE AS USER = 'MaskingTestUser';  

SELECT * FROM Data.Membership;  

REVERT;    
  
-- Removing the UNMASK permission  
REVOKE UNMASK TO MaskingTestUser;  
```

#### Row-level security
[Row-level security](https://learn.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=azure-sqldw-latest&preserve-view=true) allows security administrators to establish and control fine grained access to specific table rows based on the profile of a user (or a process) running a query. Profile or user characteristics may refer to group membership or execution context. Row-level security helps prevent unauthorized access when users query data from the same tables but must see different subsets of data.

This example creates three users and creates and populates a table with six rows. It then creates an inline table-valued function and a security policy for the table. The example then shows how select statements are filtered for the various users.

Create three user accounts that will demonstrate different access capabilities.

SQLCopy

```sql
CREATE USER Manager WITHOUT LOGIN;
CREATE USER SalesRep1 WITHOUT LOGIN;
CREATE USER SalesRep2 WITHOUT LOGIN;
GO
```

Create a table to hold data.

SQLCopy

```sql
CREATE SCHEMA Sales
GO
CREATE TABLE Sales.Orders
    (
    OrderID int,
    SalesRep nvarchar(50),
    Product nvarchar(50),
    Quantity smallint
    );
```

Populate the table with six rows of data, showing three orders for each sales representative.

SQLCopy

```sql
INSERT INTO Sales.Orders  VALUES (1, 'SalesRep1', 'Valve', 5);
INSERT INTO Sales.Orders  VALUES (2, 'SalesRep1', 'Wheel', 2);
INSERT INTO Sales.Orders  VALUES (3, 'SalesRep1', 'Valve', 4);
INSERT INTO Sales.Orders  VALUES (4, 'SalesRep2', 'Bracket', 2);
INSERT INTO Sales.Orders  VALUES (5, 'SalesRep2', 'Wheel', 5);
INSERT INTO Sales.Orders  VALUES (6, 'SalesRep2', 'Seat', 5);
-- View the 6 rows in the table
SELECT * FROM Sales.Orders;
```

Grant read access on the table to each of the users.

SQLCopy

```sql
GRANT SELECT ON Sales.Orders TO Manager;
GRANT SELECT ON Sales.Orders TO SalesRep1;
GRANT SELECT ON Sales.Orders TO SalesRep2;
GO
```

Create a new schema, and an inline table-valued function. The function returns `1` when a row in the `SalesRep` column is the same as the user executing the query (`@SalesRep = USER_NAME()`) or if the user executing the query is the Manager user (`USER_NAME() = 'Manager'`). This example of a user-defined, table-valued function is useful to serve as a filter for the security policy created in the next step.

SQLCopy

```sql
CREATE SCHEMA Security;
GO
  
CREATE FUNCTION Security.tvf_securitypredicate(@SalesRep AS nvarchar(50))
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS tvf_securitypredicate_result
WHERE @SalesRep = USER_NAME() OR USER_NAME() = 'Manager';
GO
```

Create a security policy adding the function as a filter predicate. The state must be set to `ON` to enable the policy.

SQLCopy

```sql
CREATE SECURITY POLICY SalesFilter
ADD FILTER PREDICATE Security.tvf_securitypredicate(SalesRep)
ON Sales.Orders
WITH (STATE = ON);
GO
```

Allow SELECT permissions to the `tvf_securitypredicate` function:

SQLCopy

```sql
GRANT SELECT ON Security.tvf_securitypredicate TO Manager;
GRANT SELECT ON Security.tvf_securitypredicate TO SalesRep1;
GRANT SELECT ON Security.tvf_securitypredicate TO SalesRep2;
```

Now test the filtering predicate, by selected from the `Sales.Orders` table as each user.

SQLCopy

```sql
EXECUTE AS USER = 'SalesRep1';
SELECT * FROM Sales.Orders;
REVERT;
  
EXECUTE AS USER = 'SalesRep2';
SELECT * FROM Sales.Orders;
REVERT;
  
EXECUTE AS USER = 'Manager';
SELECT * FROM Sales.Orders;
REVERT;
```

The manager should see all six rows. The Sales1 and Sales2 users should only see their own sales.

Alter the security policy to disable the policy.

SQLCopy

```sql
ALTER SECURITY POLICY SalesFilter
WITH (STATE = OFF);
```



#### Column-level security
[Column-level security](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/column-level-security) allows security administrators to set permissions that limit who can access sensitive columns in tables. It's set at the database level and can be implemented without the need to change the design of the data model or application tier.

The following example shows how to restrict `TestUser` from accessing the `SSN` column of the `Membership` table:

Create `Membership` table with SSN column used to store social security numbers:

SQLCopy

```sql
CREATE TABLE Membership
  (MemberID int IDENTITY,
   FirstName varchar(100) NULL,
   SSN char(9) NOT NULL,
   LastName varchar(100) NOT NULL,
   Phone varchar(12) NULL,
   Email varchar(100) NULL);
```

Allow `TestUser` to access all columns except for the SSN column, which has the sensitive data:

SQLCopy

```sql
GRANT SELECT ON Membership(MemberID, FirstName, LastName, Phone, Email) TO TestUser;
```

Queries executed as `TestUser` will fail if they include the SSN column:

SQLCopy

```sql
SELECT * FROM Membership;

-- Msg 230, Level 14, State 1, Line 12
-- The SELECT permission was denied on the column 'SSN' of the object 'Membership', database 'CLS_TestDW', schema 'dbo'.
```



#### References



[Dynamic Data Masking - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-ver16)

[Dynamic data masking - Azure SQL Database | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/dynamic-data-masking-overview?view=azuresql)

[Azure Synapse Analytics security white paper: Access control - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/guidance/security-white-paper-access-control)

[Column-level security for dedicated SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/column-level-security)

[Row-Level Security - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=azure-sqldw-latest&preserve-view=true)

