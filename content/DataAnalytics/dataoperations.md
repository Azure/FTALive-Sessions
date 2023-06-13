# Operations performed on Data

[prev](./splitofdata3.md.md) | [home](./introduction.md)  | [next](./serviceselection.md)

There are 2 major categories of Data Operations you need to think about when planning a Data Analytics pipeline. ETL (Extract,Transform,Load) v/s ETL (Extract, Load, Transform).

## Data Extraction

![DataExtraction](/images/ExtractionIcon.png)</br>
Extracting dataset from similar/different sources and bringing them to a common platform which you can operate on it collectively.

## Data Loading

![DataConsolidation](/images/ConsolidationIcon.png)</br>
Joining different datasets & moving them into a designated service / storage layer.

## Data Transformation

![DataTransformation](/images/TransformationIcon.png)</br>
 Most of the pipelines you configure will have one or more categories of the transformations below

1. Filtering : Reducing the size of the dataset (rows, columns, content, etc)
1. Join/Merge : Combining datasets from 2 different &/or similar forms/tables/services
1. Modification : Modifying values,schema of existing dataset
1. Aggregation : Grouping values on specific conditions
1. Looping: Running some action over a dataset in a repeated fashion

### Unit of Transformation

When it comes to data transformation there is one more consideration you should keep in mind. How are you going to transform or process data.  There are two general ways to process data:

1. **Batch processing**, in which multiple data records are collected and stored before being processed together in a single operation.This technique involves grouping together transactions or data records and handling them as one rather than individually.

![BatchProcessing](/images/BatchProcessing.png)

Preferred when latency is acceptable but compute needs to be saved for large-scale operations to be performed efficiently.

2 **Stream processing**, in which a source of data is constantly monitored and processed in real time as new data events occur.This is also called as Real-Time processing where data will be acted on almost immediately, within milliseconds.

![StreamProcessing](/images/StreamProcessing.gif)

Preferred when latency is hardly acceptable and computation can be performed constantly to accommodate newer data

With ETL you can remove/redacting sensitive information before storing
With ELT are preferred where data in its raw form (Structured,Un-structured,Semi-structured) maybe required to be referenced later.

>Note
>
>We have covered type of data, type of database scenarios and types of operations. Now its easier to list the services required for various layers of your DataAnalytics Pipeline 
>
> -storage layer(integration),
> -compute layer(operation) & 
> -presentation layer(consolidation and governance)

## Additional Information
