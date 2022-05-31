# Building

#### [prev](./designing.md) | [home](./readme.md)  | [next](./operating.md)

## Scenario based
* Don't attempt to 'boil the ocean' by building the entire MDW in one go! Instead, define business scenarios that need to be addressed, and work through them in order
* Start with *modern* requirements rather than rebuilding like-for-like
* Provide value to the business *fast*
* Make sure you have knowledge and the skills within the team to achieve the scenario
* Initially, focus on getting the Data Lake 'right' 

## Infrastructure as Code (IaC)
* [What is it](https://docs.microsoft.com/en-us/devops/deliver/what-is-infrastructure-as-code) (Check out the video and GitHub links too!)
* Why should you do it
* Video: [FastTrack for Azure - Infrastrcuture as Code](https://youtu.be/p4I9Xfp80ZQ)

## DataOps
* [What is it?](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/data-warehouse/dataops-mdw) 
* Why? (Answer: Source Control, supports collaboration, avoid environment drift and automated deployments)
* Bringing existing methodologies to the cloud won't make the most of it. IaC & DataOps are the 'secret ingredient' of getting the most out of the cloud
* Strongly recommend doing it
* [Blog series on CI/CD in Azure Synapse Analytics](https://techcommunity.microsoft.com/t5/data-architecture-blog/ci-cd-in-azure-synapse-analytics-part-5-deploying-azure-synapse/ba-p/2775403)

## Metadata Driven
* Avoid hard coding
* Reduce number of pipelines by using parametrisation.
* https://docs.microsoft.com/en-us/azure/data-factory/copy-data-tool-metadata-driven
* Plan for failure and define steps to recover

## Additional Resources
- [Azure Data Platform End2End (V2)](https://github.com/fabragaMS/ADPE2E)
- [Modern Data Warehouse DataOps E2E Samples](https://github.com/Azure-Samples/modern-data-warehouse-dataops/tree/main/e2e_samples)