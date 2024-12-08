## Azure Data Factory
Azure Data Factory is a cloud-based data integration service that allows you to create, schedule, and manage data-driven workflows for orchestrating and automating data movement and data transformation.
</br>
![ADF Diagram](https://learn.microsoft.com/en-us/azure/data-factory/media/data-flow/overview.svg ) </br>
(Image source: [ADF Overview](https://learn.microsoft.com/en-us/azure/data-factory/introduction))
</br>
Let's explore how Managed Airflow can help address the existing challenges we could encounter when orchestrating pipelines in ADF.
</br>
![Airflow Diagram](https://learn.microsoft.com/en-us/azure/data-factory/media/concept-managed-airflow/data-integration.png) </br>
(Image source: [Managed Airflow](https://learn.microsoft.com/en-us/azure/data-factory/concept-managed-airflow))
</br>

## Challenge: Orchestrating ADF pipeline is a lot of work!
We're aware that in ADF, pipeline orchestration can be achieved through the 'execute pipeline' and 'switch' activities. This approach necessitates an additional pipeline to coordinate the others.
		

## Solution: How does Managed Airflow simplify the orchestartion of a pipelines in ADF?
Airflow is a flexible open-source tool that enables us to programmatically address the limitations found in ADF. 
		

### Demo : Let's explore how we can access the Managed Airflow in ADF today.
		

### FAQ
1. [How can I configure Airflow instance in ADF?](https://learn.microsoft.com/en-us/azure/data-factory/tutorial-run-existing-pipeline-with-airflow)
1. [How does Azure Data Factory Managed Airflow work?](https://learn.microsoft.com/en-us/azure/data-factory/how-does-managed-airflow-work)
1. Is it a replacement to Azure Data Factory?
1. When will it go GA?

