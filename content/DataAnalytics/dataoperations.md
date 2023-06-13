# Operations performed on Data

[prev](./splitofdata3.md.md) | [home](./introduction.md)  | [next]()

There are 2 major categories of Data Operations you need to think about when planning a Data Analytics pipeline. ETL (Extract,Transform,Load) v/s ETL (Extract, Load, Transform).

**Data Extraction**: Extracting dataset from similar/different sources and bringing them to a common platform which you can operate on it collectively
![DataExtraction](/images/ExtractionIcon.png)

**Data Loading** : Joining different datasets & moving them into a designated service / storage layer
![DataConsolidation](/images/ConsolidationIcon.png)

- **Data Transformation**: Most of the pipelines you configure will have one or more categories of the transformations below
![DataTransformation](/images/TransformationIcon.png)

1. Filtering : Reducing the size of the dataset (rows, columns, content, etc)
1. Join/Merge : Combining datasets from 2 different &/or similar forms/tables/services
1. Modification : Modifying values,schema of existing dataset
1. Aggregation : Grouping values on specific conditions
1. Looping: Running some action over a dataset in a repeated fashion

With ETL you can remove/redacting sensitive information before storing
With ELT are preferred where data in its raw form (Structured,Un-structured,Semi-structured) maybe required to be referenced later.

>Note
>
>We have covered type of data, type of database scenarios and types of operations. Now its easier to list the services required for various layers of your DataAnalytics pipeline storage layer(integration),compute layer(operation) & presentation layer(consolidation and governance)



## Additional Information
