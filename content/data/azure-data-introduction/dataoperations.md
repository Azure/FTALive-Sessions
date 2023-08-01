# Operations Performed on Data

[prev](./typeofdata.md) | [home](./introduction.md)  | [next](./splitofdata1.md)

## Methodologies

There are 2 major categories of data transformation processes (methodologies) you need to consider when planning a Data Analytics platform:

### **E T L** (Extract, Transform, Load)

When using **E T L**, transformations happen inflight between the source and destination. This has several advantages, including the ability to remove/redact sensitive data before storing. Additionally, it's efficient from a storage perspective as you only store the required information.

### **E L T** (Extract, Load, Transform)

When using **E L T**, you load data into your Data Lake as it is in the source system. You may use this when you have a need to reference the data in its raw form (Structured, Un-structured,Semi-structured) at a later point in time, or where the system does not provide a change feed for you to consume. An advantage of ELT is that by storing the data *before* transforming it, you can apply parallel compute engines (e.g. Spark) to transform large volumes of data concurrently.

## *Extract*

![DataExtraction](/images/ExtractionIcon.png)</br>
In the Extraction phase, you gather and extract dataset(s) from similar or different sources and bring that data to a common platform, where you can (in future) manipulate and aggregate these datasets without affecting the original data.

## *Load*

![DataConsolidation](/images/ConsolidationIcon.png)</br>
In the Loading phase, the extracted data is loaded into the data warehouse or the target destination. This phase focuses on efficiently transferring and organizing the data for further processing.

## *Transform*

![DataTransformation](/images/TransformationIcon.png)</br>
In the Transformation phase, data is processed and transformed to align with the desired structure (schema) and requirements for analysis and reporting. This phase is where most data preparation, cleansing, and enrichment tasks occur. Actions taken in the Transform phase include:

1. Cleansing: Identify and rectify any errors, inconsistencies, or missing data values in the dataset.
1. Filtering: Reducing the size of the dataset (rows, columns, content, etc).
1. Join/Merge: Combining datasets from 2 different &/or similar forms/tables/services.
1. Modification: Modifying values,schema of existing dataset.
1. Aggregation: Grouping values on specific conditions.
1. Validation: Validate the transformed data to ensure its accuracy and integrity.
1. Looping: Running some action over a dataset in a repeated fashion.
</br>
</br>

# Unit of Transformation
Data transformations are generally performed in two distinct methods:
1. Batch Processing
1. Stream Processing

## Batch Processing

Batch processing involves processing a large volume of data in predefined, fixed-size batches. Data is collected over a period, and then the entire batch is processed at once. This approach is well-suited for scenarios where data can be collected, stored, and processed in intervals, rather than requiring real-time analysis. Key characteristics of batch processing include:

* **Latency**: Batch processing introduces higher latency, as data is processed in chunks at specified intervals (e.g., hourly, daily, or weekly).
* **Scalability**: Batch processing can be highly scalable since data can be processed in parallel across multiple nodes or systems.
* **Complexity**: Batch processing is often easier to implement and manage compared to stream processing, as it doesn't require dealing with real-time data and potential out-of-order processing challenges.

![BatchProcessing](/images/BatchProcessing.png)

Batch processing is commonly used for processes which do not require real-time insights or analytics. It is preferred when some latency for data processing is acceptable, but large amounts of compute are needed to complete the transformations.

## Stream Processing

Stream processing involves handling data in real-time as it arrives, because the source of data is constantly monitored and processed as new events occur. Data is processed as individual records or small chunks (micro-batch) rather than being accumulated into fixed-size batches. Stream processing is ideal for use cases that require real-time analysis and quick responses to data events. Key characteristics of stream processing include:

* **Low Latency**: Stream processing provides low latency as data is processed immediately upon arrival, allowing for real-time or near-real-time analysis.
* **Scalability**: Stream processing systems need to handle and process data in real-time, which often requires high scalability to keep up with the data volume and velocity.
* **Complexity**: Stream processing can be more complex than batch processing, as it requires handling real-time data streams, dealing with out-of-order events, data islands and managing data windowing for time-based analysis.

![StreamProcessing](/images/StreamProcessing.gif)

Stream processing is used in applications like real-time monitoring, fraud detection, recommendation systems, IoT data processing, and reacting to time-sensitive events. It is preferred when near-zero latency is required for data processing. Often, stream processing can be more expensive than batch processing.

## Hybrid Approaches

In some cases, a hybrid approach combining both batch and stream processing are used. For example, some systems first process data in real-time streams to get immediate insights and then consolidate or summarize the processed data into batches for historical analysis. This is called the [Lambda Architecture](https://learn.microsoft.com/en-us/azure/architecture/data-guide/big-data/#lambda-architecture).

## Choice

Choosing between batch and stream processing depends on the specific use case, data velocity, and requirements for real-time analysis. Both approaches have their strengths and weaknesses, and understanding the nature of the data and the needs of the application is crucial in making the right decision.

## Additional Information

- [Understand batch and stream processing](https://learn.microsoft.com/training/modules/explore-fundamentals-stream-processing/2-batch-stream)
