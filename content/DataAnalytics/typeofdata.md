# Type of Data

[prev](./introduction.md) | [home](./introduction.md)  | [next](./splitofdata.md)

There are three primary types of data that a data engineer will work with. Structured,Semi-structured & Unstructured

## Structured data

Structured data is data that adheres to a fixed schema, so all of the data has the same fields or properties. Most commonly, the schema for structured data entities is tabular - in other words, the data is represented in one or more tables that consist of rows to represent each instance of a data entity, and columns to represent attributes of the entity. Structured data is often stored in a database in which multiple tables can reference one another by using key values in a relational model. Structured data primarily comes from table-based source systems such as a relational database or from a flat file such as a comma separated (CSV) file. The primary element of a structured file is that the rows and columns are aligned consistently throughout the file.

## Semi-structured data

Semi-structured data is information that has some structure, but which allows for some variation between entity instances. One common format for semi-structured data is JavaScript Object Notation (JSON)</br>
-XML </br>
-TSV </br>
-XML </br>
-JSON </br>
Semi-structured data is data such as JavaScript object notation (JSON) files, which may require flattening prior to loading into your source system. When flattened, this data doesn't have to fit neatly into a table structure.

### Optimized file formats

While human-readable formats for structured and semi-structured data can be useful, they're typically not optimized for storage space or processing. Over time, some specialized file formats that enable compression, indexing, and efficient storage and processing have been developed.Some common optimized file formats you might see include Avro, ORC, and Parquet:

*Avro*  is a row-based format. It was created by Apache. Each record contains a header that describes the structure of the data in the record. This header is stored as JSON. The data is stored as binary information. An application uses the information in the header to parse the binary data and extract the fields it contains. Avro is a good format for compressing data and minimizing storage and network bandwidth requirements.

*ORC* (Optimized Row Columnar format) organizes data into columns rather than rows. It was developed by HortonWorks for optimizing read and write operations in Apache Hive (Hive is a data warehouse system that supports fast data summarization and querying over large datasets). An ORC file contains stripes of data. Each stripe holds the data for a column or set of columns. A stripe contains an index into the rows in the stripe, the data for each row, and a footer that holds statistical information (count, sum, max, min, and so on) for each column.

*Parquet*  is another columnar data format. It was created by Cloudera and Twitter. A Parquet file contains row groups. Data for each column is stored together in the same row group. Each row group contains one or more chunks of data. A Parquet file includes metadata that describes the set of rows found in each chunk. An application can use this metadata to quickly locate the correct chunk for a given set of rows, and retrieve the data in the specified columns for these rows. Parquet specializes in storing and processing nested data types efficiently. It supports very efficient compression and encoding schemes.

## Unstructured data

Not all data is structured or even semi-structured. For example, documents, images, audio and video data, and binary files might not have a specific structure. This kind of data is referred to as unstructured data.Unstructured data includes data stored as key-value pairs that don't adhere to standard relational models and Other types of unstructured data that are commonly used include portable data format (PDF), word processor documents, and images.

## Data Storage Options

There are two broad categories of **data store** in common use:

1. **File Stores**
2. **Databases**

You will find these decision trees helpful when deciding on the store

- **[Understanding Data Store models](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-overview)**
- **[Selecting a Data Store](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-decision-tree)**
- **[Choosing a Big Data Store](https://learn.microsoft.com/azure/architecture/data-guide/technology-choices/data-storage)**

> Note:
At this stage its important to understand your options but not jump to decision on finalizing the store. Reason being that selection on the store is based on various other parameters
>
>1. Type of Data
>1. Split of Transactional v/s Analytical v/s Historical Data
>1. Operations to be performed on Data
>1. Service requirement : Reliability, Scalability, Availability, Concurrency, Costing

An exhaustive list for Microsoft Azure Architectural Criteria can also be found [here](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-considerations)

In the next section we shall see how whether or not to split from the above options for data store based on current usage and futuristic requirement. Followed by a deeper understanding on the operations to be performed on Data for the end-to-end DataAnalytics pipeline

## Additional Information

- [Identify Data Formats](https://learn.microsoft.com/training/modules/explore-core-data-concepts/2-data-formats)
- [What is Data Engineering](https://learn.microsoft.com/training/modules/introduction-to-data-engineering-azure/2-what-data-engineering)
- [Explore relational data in Azure](https://learn.microsoft.com/training/paths/azure-data-fundamentals-explore-relational-data/)
- [Explore non-relational data in Azure](https://learn.microsoft.com/training/paths/azure-data-fundamentals-explore-non-relational-data/)
