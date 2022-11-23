# Dynamic data masking - Dedicated SQL Pool

- 

Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to designate how much of the sensitive data to reveal with minimal impact on the application layer. It's a policy-based security feature that hides the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed.



## Dynamic data masking basics

You set up a dynamic data masking policy in the Azure portal by selecting the **Dynamic Data Masking** blade under **Security** in your SQL Database configuration pane. This feature cannot be set using portal for SQL Managed Instance. For more information, see [Dynamic Data Masking](https://learn.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking).

### Dynamic data masking policy

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

### Creating a Dynamic Data Mask

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

### Adding or editing a mask on an existing column

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

### Granting permissions to view unmasked data

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

### Custom Options - Serveless SQL Pool

Row Level Security

Dynamic Data masking Script

encrypt on Spark level.