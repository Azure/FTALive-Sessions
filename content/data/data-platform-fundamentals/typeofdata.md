# Type of Data

[prev](./introduction.md) | [home](./introduction.md)  | [next](./dataoperations.md)

There are three primary types of data that a Data Engineer will work with. Structured, Semi-structured & Unstructured.

## Structured data

Structured data is data that adheres to a fixed schema, so all of the data has the same fields or properties. Most commonly, the schema for structured data entities is tabular - in other words, the data is represented in one or more tables that consist of rows to represent each instance of a data entity, and columns to represent attributes of the entity. Structured data is often stored in a database in which multiple tables can reference one another by using key values in a relational model. Structured data primarily comes from table-based source systems such as a relational database or from a flat file such as a comma separated value (CSV) file. The primary element of a structured file is that the rows and columns are aligned (or formatted) consistently throughout the file.

## Semi-structured data

Semi-structured data is data that has some structure, but which allows for some variation between entity instances. This data may require flattening prior to loading into your systems. When flattened, this data doesn't have to fit neatly into a table structure. Below are some common semi-structured data formats:

- JSON (JavaScript Object Notation)
- XML (Extensible Markup Language)
- CSV & TSV (Comma and Tab separated values)
- YAML (Yet Another Markup Language or YAML Ain't Markup Language)

### Optimized file formats

While human-readable formats for structured and semi-structured data can be useful, they're typically not optimized for storage space or processing. Over time, some specialized file formats that enable compression, indexing, and efficient storage and processing have been developed. Some common optimized file formats you might see include:

- **Parquet** is a columnar data format. A Parquet file contains row groups. Data for each column is stored together in the same row group. Each row group contains one or more chunks of data. A Parquet file includes metadata that describes the set of rows found in each chunk. An application can use this metadata to quickly locate the correct chunk for a given set of rows, and retrieve the data in the specified columns for these rows. Parquet specializes in storing and processing nested data types efficiently. It supports very efficient compression and encoding schemes.

- **Avro** is a row-based format. Each record contains a header that describes the structure of the data in the record. This header is stored as JSON. The data is stored as a compact binary format. An application uses the information in the header to parse the binary data and extract the fields it contains. Avro is a good format for compressing data and minimizing storage and network bandwidth requirements.

- **ORC** (Optimized Row Columnar format) organizes data into columns rather than rows. It was developed for optimizing read and write operations in Apache Hive (Hive is a data warehouse system that supports fast data summarization and querying over large datasets). An ORC file contains stripes of data. Each stripe holds the data for a column or set of columns. A stripe contains an index into the rows in the stripe, the data for each row, and a footer that holds statistical information (count, sum, max, min, and so on) for each column.

## Unstructured data

Not all data is structured or even semi-structured. This kind of data is referred to as unstructured data, because it does not have a predefined data model or organized structure. Unlike structured data, which fits neatly into tables and follows a specific schema, unstructured data lacks a consistent format or fixed schema. It is typically not easily organized or queried using traditional databases. Some examples of files which might not have a specific structure are documents, PDF's, images, audio and video data, and binary files.

## Data Storage Options

There are two broad categories of **data stores** in common use:

1. **File Storage**
1. **Databases**

You will find these decision trees helpful when deciding on the store

- **[Understanding Data Store models](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-overview)**
- **[Selecting a Data Store](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-decision-tree)**
- **[Choosing a Big Data Store](https://learn.microsoft.com/azure/architecture/data-guide/technology-choices/data-storage)**

> **Note:**
>
> At this stage its important to understand your options but not jump to a decision on finalizing the store, as selection is based on various other additional parameters.
>
>1. Type of Data
>1. Operations to be performed on data
>1. Split of Transactional v/s Historical v/s Analytical data
>1. Service requirement: Reliability, Scalability, Availability, Concurrency, Cost

An exhaustive list for Microsoft Azure Architectural Criteria can also be found [here](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-considerations).

## Additional Information

- [Identify Data Formats](https://learn.microsoft.com/training/modules/explore-core-data-concepts/2-data-formats)
- [What is Data Engineering](https://learn.microsoft.com/training/modules/introduction-to-data-engineering-azure/2-what-data-engineering)
- [Explore relational data in Azure](https://learn.microsoft.com/training/paths/azure-data-fundamentals-explore-relational-data/)
- [Explore non-relational data in Azure](https://learn.microsoft.com/training/paths/azure-data-fundamentals-explore-non-relational-data/)
