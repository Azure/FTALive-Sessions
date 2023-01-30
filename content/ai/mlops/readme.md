# Machine Learning Operations (MLOps)



This live session will introduce the concepts of MLOps, discuss how organisations can adopt MLOps practises, and develop a machine learning lifecycle from a technical perspective.

<br/>

## Agenda
1. [MLOps overview](#1-mlops_overview)
2. [MLOps maturity model](#2-mlops-maturity-model")
3. [MLOps with Azure Machine Learning](#3-mlops-with-azure-ml)
4. [References](#4-references)

<br/>

---

 ## <a name="1-mlops-overview"></a>1. MLOps
In this section, we provide an overview of MLOps, the different components within an MLOps environment.  

Consider the machine learning lifecycle:

<img src='./images/end-to-end-lifecycle.JPG' width=1000 />

<br/>

### Background

MLOPs is the combination of people, processes, and platforms that enables the development and deployment of machine learning models in a production environment. It is a combination of DevOps and Data Science

<img src='./images/mlops-ppp.JPG' width=1000 />

Devops follows certain processes that include code, build, test, release, deploy, operate, monitor and plan. 

However, MLOPs differs from DevOps in several key areas. MLOPs has these characteristics:

* Exploration precedes development and operations.
* The data science lifecycle requires an adaptive way of working.
* Limits on data quality and availability limit progress.
* A greater operational effort is required than in DevOps.
* Work teams require specialists and domain experts.

<img src='./images/mlops-stages.png' width=1000 />

<br></br>
### Continuous Development vs Continuous Deployment
There are many ways that a user may create Azure Machine Learning Pipelines, Jobs, Notebooks, Compute etc.

For example, they may interact with the AzureML API/CLI by using:

i. VS Code on their local machine,
ii. the AzureML Workspace online; or
iii. a YAML Pipeline deployment on a DevOps Agent (e.g. GitHub Actions or Azure DevOps etc).

The programmatic way in which the first two scenarios allow us to interact with the AzureML API is akin to "Continuous Development", as opposed to "Continuous Deployment". The former is strong on flexibility, however, it is somewhat weak on governance, accountability and reproducibility.

In a nutshell, Continuous Development *is a partly manual process where developers can deploy any changes to customers by simply clicking a button, while continuous Deployment emphasizes automating the entire process.*

<br/>

### Continuous Deployment And Branching Strategy
Source control is an integral part of any MLOps environment. It is important to have a branching strategy in place to ensure that the correct code is deployed to the correct environment.

There are many branching strategies, but the most common are:
* Trunk Based Development
    - Developers merge small, frequent updates to a core “trunk” or main branch
    - This is the most common branching strategy
    - Short-lived branches with a few small commits compared to other long-lived feature branching strategies

<img src='./images/trunk-based-development-branching-strategy.png' width=500 />

* Feature Branching
    - Developers create a branch for each feature they are working on

* Release Branching
    - Developers maintain a separate branch for each release

* Gitflow
    - Uses long-lived feature branches and multiple primary branches
    - Has more, longer-lived branches and larger commits than trunk-based
    - Developers create a feature branch and delay merging it to the main trunk branch until the feature is complete

<img src='./images/gitflow-branching-strategy.png' width=500 />

* GitHub Flow
    - Simpler branching strategy
    - Doesn’t have release branches
    - Keeping master code in a constant deployable state

<img src='./images/github-flow-branching-model.jpeg' width=500>


<br></br>
### Seven principles of machine learning operations
As you plan to adopt machine learning operations in your organization, consider applying the following core principles as the foundation:

* Use version control for code, data, and experimentation outputs. Unlike in traditional software development, data has a direct influence on the quality of machine learning models. You should version your experimentation code base, but also version your datasets to ensure that you can reproduce experiments or inference results. Versioning experimentation outputs like models can save effort and the computational cost of re-creating them.

* Use multiple environments. To separate development and testing from production work, replicate your infrastructure in at least two environments. Access control for users might be different for each environment.

* Manage your infrastructure and configurations as code. When you create and update infrastructure components in your work environments, use infrastructure as code, so inconsistencies don't develop in your environments. Manage machine learning experiment job specifications as code so that you can easily rerun and reuse a version of your experiment in multiple environments.

* Track and manage machine learning experiments. Track key performance indicators and other artifacts for your machine learning experiments. When you keep a history of job performance, you can do a quantitative analysis of experimentation success and enhance team collaboration and agility.

* Test code, validate data integrity, and ensure model quality. Test your experimentation code base for correct data preparation and feature extraction functions, data integrity, and model performance.

* Machine learning continuous integration and delivery. Use continuous integration (CI) to automate testing for your team. Include model training as part of continuous training pipelines. Include A/B testing as part of your release to ensure that only a qualitative model is used in production.

* Monitor services, models, and data. When you serve models in a machine learning operations environment, it's critical to monitor the services for their infrastructure uptime, compliance, and model quality. Set up monitoring to identify data and model drift and to understand whether retraining is required. Consider setting up triggers for automatic retraining.


 ## <a name="2-mlops-maturity-model"></a>2. MLOps Maturity Model

https://learn.microsoft.com/en-us/azure/architecture/example-scenario/mlops/mlops-maturity-model

<p>The MLOps maturity model helps clarify the Development Operations (DevOps) principles and practices necessary to run a successful MLOps environment. It's intended to identify gaps in an existing organization's attempt to implement such an environment. It's also a way to show you how to grow your MLOps capability in increments rather than overwhelm you with the requirements of a fully mature environment. Use it as a guide to:</p>
<ul>
<li><p>Estimate the scope of the work for new engagements.</p>
</li>
<li><p>Establish realistic success criteria.</p>
</li>
<li><p>Identify deliverables you'll hand over at the conclusion of the engagement.</p>
</li>
</ul>
<p>As with most maturity models, the MLOps maturity model qualitatively assesses people/culture, processes/structures, and objects/technology. As the maturity level increases, the probability increases that incidents or errors will lead to improvements in the quality of the development and production processes.</p>
<p>The MLOps maturity model encompasses five levels of technical capability:</p>
<table>
<thead>
<tr>
<th>Level</th>
<th>Description</th>
<th>Highlights</th>
<th>Technology</th>
</tr>
</thead>
<tbody>
<tr>
<td>0</td>
<td><a name="level-0-no-mlops">No MLOps</a></td>
<td><ul><li>Difficult to manage full machine learning model lifecycle<li>The teams are disparate and releases are painful<li>Most systems exist as &quot;black boxes,&quot; little feedback during/post deployment</ul></td>
<td><ul><li>Manual builds and deployments<li>Manual testing of model and application<li>No centralized tracking of model performance<li>Training of model is manual</ul></td>
</tr>
<tr>
<td>1</td>
<td><a name="level-1-devops-no-mlops">DevOps but no MLOps</a></td>
<td><ul><li>Releases are less painful than No MLOps, but rely on Data Team for every new model<li>Still limited feedback on how well a model performs in production<li>Difficult to trace/reproduce results</ul></td>
<td><ul><li>Automated builds<li>Automated tests for application code</ul></td>
</tr>
<tr>
<td>2</td>
<td><a name="level-2-automated-training">Automated Training</a></td>
<td><ul><li>Training environment is fully managed and traceable<li>Easy to reproduce model<li>Releases are manual, but low friction</ul></td>
<td><ul><li>Automated model training<li>Centralized tracking of model training performance<li>Model management</ul></td>
</tr>
<tr>
<td>3</td>
<td><a name="level-3-automated-model-deployment">Automated Model Deployment</a></td>
<td><ul><li>Releases are low friction and automatic<li>Full traceability from deployment back to original data<li>Entire environment managed: train &gt; test &gt; production </ul></td>
<td><ul><li>Integrated A/B testing of model performance for deployment<li>Automated tests for all code<li>Centralized tracking of model training performance</ul></td>
</tr>
<tr>
<td>4</td>
<td><a name="level-4-full-mlops-automated-retraining">Full MLOps Automated Operations</a></td>
<td><ul><li>Full system automated and easily monitored<li>Production systems are providing information on how to improve and, in some cases, automatically improve with new models<li>Approaching a zero-downtime system </ul></td>
<td><ul><li>Automated model training and testing<li>Verbose, centralized metrics from deployed model</ul></td>
</tr>
</tbody>
</table>
<p>The tables that follow identify the detailed characteristics for that level of process maturity. Note that the model will continue to evolve.</p>
<h2 id="level-0-no-mlops">Level 0: No MLOps</h2>
<table>
<thead>
<tr>
<th>People</th>
<th>Model Creation</th>
<th>Model Release</th>
<th>Application Integration</th>
</tr>
</thead>
<tbody>
<tr>
<td><ul><li>Data scientists: siloed, not in regular communications with the larger team<li>Data engineers (<em>if exists</em>): siloed, not in regular communications with the larger team<li>Software engineers: siloed, receive model remotely from the other team members</ul></td>
<td><ul><li>Data gathered manually<li>Compute is likely not managed<li>Experiments aren't predictably tracked<li>End result may be a single model file manually handed off with inputs/outputs</ul></td>
<td><ul><li>Manual process<li>Scoring script may be manually created well after experiments, not version controlled<li>Release handled by data scientist or data engineer alone</ul></td>
<td><ul><li>Heavily reliant on data scientist expertise to implement<li>Manual releases each time</ul></td>
</tr>
</tbody>
</table>
<tr>
<img src='./images/level-1-no-mlops.JPG' width=1000 />
</tr>
<h2 id="level-1-devops-no-mlops">Level 1: DevOps no MLOps</h2>
<table>
<thead>
<tr>
<th>People</th>
<th>Model Creation</th>
<th>Model Release</th>
<th>Application Integration</th>
</tr>
</thead>
<tbody>
<tr>
<td><ul><li>Data scientists: siloed, not in regular communications with the larger team<li>Data engineers (if exists): siloed, not in regular communication with the larger team<li>Software engineers: siloed, receive model remotely from the other team members</ul></td>
<td><ul><li>Data pipeline gathers data automatically<li>Compute is or isn't managed<li>Experiments aren't predictably tracked<li>End result may be a single model file manually handed off with inputs/outputs</ul></td>
<td><ul><li>Manual process<li>Scoring script may be manually created well after experiments, likely version controlled<li>Is handed off to software engineers</ul></td>
<td><ul><li>Basic integration tests exist for the model<li>Heavily reliant on data scientist expertise to implement model<li>Releases automated<li>Application code has unit tests</ul></td>
</tr>
</tbody>
</table>
<h2 id="level-2-automated-training">Level 2: Automated Training</h2>
<table>
<thead>
<tr>
<th>People</th>
<th>Model Creation</th>
<th>Model Release</th>
<th>Application Integration</th>
</tr>
</thead>
<tbody>
<tr>
<td><ul><li>Data scientists: Working directly with data engineers to convert experimentation code into repeatable scripts/jobs<li>Data engineers: Working with data scientists<li>Software engineers: siloed, receive model remotely from the other team members</ul></td>
<td><ul><li>Data pipeline gathers data automatically<li>Compute managed<li>Experiment results tracked<li>Both training code and resulting models are version controlled</ul></td>
<td><ul><li>Manual release<li>Scoring script is version controlled with tests<li>Release managed by Software engineering team</ul></td>
<td><ul><li>Basic integration tests exist for the model<li>Heavily reliant on data scientist expertise to implement model<li>Application code has unit tests</ul></td>
</tr>
</tbody>
</table>
<tr>
<img src='./images/level-2-reproducible-model-training.JPG' width=1000 />
</tr>
<h2 id="level-3-automated-model-deployment">Level 3: Automated Model Deployment</h2>
<table>
<thead>
<tr>
<th>People</th>
<th>Model Creation</th>
<th>Model Release</th>
<th>Application Integration</th>
</tr>
</thead>
<tbody>
<tr>
<td><ul><li>Data scientists: Working directly with data engineers to convert experimentation code into repeatable scripts/jobs<li>Data engineers: Working with data scientists and software engineers to manage inputs/outputs<li>Software engineers: Working with data engineers to automate model integration into application code</ul></td>
<td><ul><li>Data pipeline gathers data automatically<li>Compute managed<li>Experiment results tracked<li>Both training code and resulting models are version controlled</ul></td>
<td><ul><li>Automatic release<li>Scoring script is version controlled with tests<li>Release managed by continuous delivery (CI/CD) pipeline</ul></td>
<td><ul><li>Unit and integration tests for each model release<li>Less reliant on data scientist expertise to implement model<li>Application code has unit/integration tests</ul></td>
</tr>
</tbody>
</table>
<tr>
<img src='./images/level-3-managed-model-operations.JPG' width=1000 />
</tr>
<h2 id="level-4-full-mlops-automated-retraining">Level 4: Full MLOps Automated Retraining</h2>
<table>
<thead>
<tr>
<th>People</th>
<th>Model Creation</th>
<th>Model Release</th>
<th>Application Integration</th>
</tr>
</thead>
<tbody>
<tr>
<td><ul><li>Data scientists: Working directly with data engineers to convert experimentation code into repeatable scripts/jobs. Working with software engineers to identify markers for data engineers<li>Data engineers: Working with data scientists and software engineers to manage inputs/outputs<li>Software engineers: Working with data engineers to automate model integration into application code. Implementing post-deployment metrics gathering</ul></td>
<td><ul><li>Data pipeline gathers data automatically<li>Retraining triggered automatically based on production metrics<li>Compute managed<li>Experiment results tracked<li>Both training code and resulting models are version controlled</ul></td>
<td><ul><li>Automatic Release<li>Scoring Script is version controlled with tests<li>Release managed by continuous integration and CI/CD pipeline</ul></td>
<td><ul><li>Unit and Integration tests for each model release<li>Less reliant on data scientist expertise to implement model<li>Application code has unit/integration tests</ul></td>
</tr>
</tbody>
</table>
<img src='./images/level-4-full-automated-retraining.JPG' width=1000 />

<h4 id="workflow-for-the-classical-machine-learning-architecture">Workflow for the classical machine learning architecture</h4>
<ol>
<li><p>Data estate</p>
<p>This element illustrates the data estate of the organization, and potential data sources and targets for a data science project. Data engineers are the primary owners of this element of the MLOps v2 lifecycle. The Azure data platforms in this diagram are neither exhaustive nor prescriptive. The data sources and targets that represent recommended best practices based on the customer use case are indicated by a green check mark.</p>
</li>
<li><p>Administration and setup</p>
<p>This element is the first step in the MLOps v2 accelerator deployment. It consists of all tasks related to creation and management of resources and roles associated with the project. These can include the following tasks, and perhaps others:</p>
<ol>
<li>Creation of project source code repositories</li>
<li>Creation of Machine Learning workspaces by using Bicep, ARM, or Terraform</li>
<li>Creation or modification of datasets and compute resources that are used for model development and deployment</li>
<li>Definition of project team users, their roles, and access controls to other resources</li>
<li>Creation of CI/CD pipelines</li>
<li>Creation of monitors for collection and notification of model and infrastructure metrics</li>
</ol>
<p>The primary persona associated with this phase is the infrastructure team, but there can also be data engineers, machine learning engineers, and data scientists.</p>
</li>
<li><p>Model development (inner loop)</p>
<p>The inner loop element consists of your iterative data science workflow that acts within a dedicated, secure Machine Learning workspace. A typical workflow is illustrated in the diagram. It proceeds from data ingestion, exploratory data analysis, experimentation, model development and evaluation, to registration of a candidate model for production. This modular element as implemented in the MLOps v2 accelerator is agnostic and adaptable to the process your data science team uses to develop models.</p>
<p>Personas associated with this phase include data scientists and machine learning engineers.</p>
</li>
<li><p>Machine Learning registries</p>
<p>After the data science team develops a model that's a candidate for deploying to production, the model can be registered in the Machine Learning workspace registry. CI pipelines that are triggered, either automatically by model registration or by gated human-in-the-loop approval, promote the model and any other model dependencies to the model deployment phase.</p>
<p>Personas associated with this stage are typically machine learning engineers.</p>
</li>
<li><p>Model deployment (outer loop)</p>
<p>The model deployment or outer loop phase consists of pre-production staging and testing, production deployment, and monitoring of model, data, and infrastructure. CD pipelines manage the promotion of the model and related assets through production, monitoring, and potential retraining, as criteria that are appropriate to your organization and use case are satisfied.</p>
<p>Personas associated with this phase are primarily machine learning engineers.</p>
</li>
<li><p>Staging and test</p>
<p>The staging and test phase can vary with customer practices but typically includes operations such as retraining and testing of the model candidate on production data, test deployments for endpoint performance, data quality checks, unit testing, and responsible AI checks for model and data bias. This phase takes place in one or more dedicated, secure Machine Learning workspaces.</p>
</li>
<li><p>Production deployment</p>
<p>After a model passes the staging and test phase, it can be promoted to production by using a human-in-the-loop gated approval. Model deployment options include a managed batch endpoint for batch scenarios or, for online, near-real-time scenarios, either a managed online endpoint or Kubernetes deployment by using Azure Arc. Production typically takes place in one or more dedicated, secure Machine Learning workspaces.</p>
</li>
<li><p>Monitoring</p>
<p>Monitoring in staging, test, and production makes it possible for you to collect metrics for, and act on, changes in performance of the model, data, and infrastructure. Model and data monitoring can include checking for model and data drift, model performance on new data, and responsible AI issues. Infrastructure monitoring can watch for slow endpoint response, inadequate compute capacity, or network problems.</p>
</li>
<li><p>Data and model monitoring: events and actions</p>
<p>Based on criteria for model and data matters of concern such as metric thresholds or schedules, automated triggers and notifications can implement appropriate actions to take. This can be regularly scheduled automated retraining of the model on newer production data and a loopback to staging and test for pre-production evaluation. Or, it can be due to triggers on model or data issues that require a loopback to the model development phase where data scientists can investigate and potentially develop a new model.</p>
</li>
<li><p>Infrastructure monitoring: events and actions</p>
<p>Based on criteria for infrastructure matters of concern such as endpoint response lag or insufficient compute for the deployment, automated triggers and notifications can implement appropriate actions to take. They trigger a loopback to the setup and administration phase where the infrastructure team can investigate and potentially reconfigure the compute and network resources.</p>
</li>
</ol>
<img src="./images/classical-ml-architecture.png" alt="Diagram for the classical machine learning architecture." width=1000  />
</a>
</p>
<br/>

 ## <a name="3-mlops-with-azure-ml"></a>3. MLOps with Azure ML

### Azure Machine Learning provides the following MLOps capabilities:

* Create reproducible pipelines. Machine learning pipelines enable you to define repeatable and reusable steps for your data preparation, training, and scoring processes.
* Create reusable software environments for training and deploying models.
* Register, package, and deploy models from anywhere. You can track the associated metadata required to use the model.
* Capture the governance data for the end-to-end lifecycle. The logged information can include who is publishing models, why changes were made, and when models were deployed or used in production.
* Notify and alert on events in the lifecycle. For example, you can get alerts for experiment completion, model registration, model deployment, and data drift detection.
* Monitor applications for operational and machine learning-related issues. Compare model inputs between training and inference, explore model-specific metrics, and provide monitoring and alerts on your machine learning infrastructure.
* Automate the end-to-end machine learning lifecycle with Azure Machine Learning and Azure Pipelines. With pipelines, you can frequently update models, test new models, and continuously roll out new machine learning models alongside your other applications and services.

### Best practices from Azure Machine Learning
Azure Machine Learning offers asset management, orchestration, and automation services to help you manage the lifecycle of your machine learning model training and deployment workflows. Review the best practices and recommendations to apply machine learning operations in the resource areas of people, process, and technology, all supported by Azure Machine Learning.

#### People
* Work in project teams to best use specialist and domain knowledge in your organization. Set up Azure Machine Learning workspaces for each project to comply with use case segregation requirements.
* Define a set of responsibilities and tasks as a role so that any team member on a machine learning operations project team can be assigned to and fulfill multiple roles. Use custom roles in Azure to define a set of granular Azure RBAC operations for Azure Machine Learning that each role can perform.
* Standardize on a project lifecycle and Agile methodology. The Team Data Science Process provides a reference lifecycle implementation.
* Balanced teams can run all machine learning operations stages, including exploration, development, and operations.

#### Process
* Standardize on a code template for code reuse and to accelerate ramp-up time on a new project or when a new team member joins the project. Use Azure Machine Learning pipelines, job submission scripts, and CI/CD pipelines as a basis for new templates.
* Use version control. Jobs that are submitted from a Git-backed folder automatically track repo metadata with the job in Azure Machine Learning for reproducibility.
* Use versioning for experiment inputs and outputs for reproducibility. Use Azure Machine Learning datasets, model management, and environment management capabilities to facilitate versioning.
* Build up a run history of experiment runs for comparison, planning, and collaboration. Use an experiment-tracking framework like MLflow to collect metrics.
* Continuously measure and control the quality of your team's work through CI on the full experimentation code base.
* Terminate training early in the process when a model doesn't converge. Use an experiment-tracking framework and the run history in Azure Machine Learning to monitor job runs.
* Define an experiment and model management strategy. Consider using a name like champion to refer to the current baseline model. A challenger model is a candidate model that might outperform the champion model in production. Apply tags in Azure Machine Learning to mark experiments and models. In a scenario like sales forecasting, it might take months to determine whether the model's predictions are accurate.
* Elevate CI for continuous training by including model training in the build. For example, begin model training on the full dataset with each pull request.
* Shorten the time it takes to get feedback on the quality of the machine learning pipeline by running an automated build on a data sample. Use Azure Machine Learning pipeline parameters to parameterize input datasets.
* Use continuous deployment (CD) for machine learning models to automate deployment and testing real-time scoring services in your Azure environments.
* In some regulated industries, you might be required to complete model validation steps before you can use a machine learning model in a production environment. Automating validation steps might accelerate time to delivery. When manual review or validation steps are still a bottleneck, consider whether you can certify the automated model validation pipeline. Use resource tags in Azure Machine Learning to indicate asset compliance and candidates for review or as triggers for deployment.
* Don't retrain in production, and then directly replace the production model without doing integration testing. Even though model performance and functional requirements might appear good, among other potential issues, a retrained model might have a larger environment footprint and break the server environment.
* When production data access is available only in production, use Azure RBAC and custom roles to give a select number of machine learning practitioners read access. Some roles might need to read the data for related data exploration. Alternatively, make a data copy available in nonproduction environments.
* Agree on naming conventions and tags for Azure Machine Learning experiments to differentiate retraining baseline machine learning pipelines from experimental work.

#### Technology
* If you currently submit jobs via the Azure Machine Learning studio UI or CLI, instead of submitting jobs via the SDK, use the CLI or Azure DevOps Machine Learning tasks to configure automation pipeline steps. This process might reduce the code footprint by reusing the same job submissions directly from automation pipelines.
* Use event-based programming. For example, trigger an offline model testing pipeline by using Azure Functions after a new model is registered. Or, send a notification to a designated email alias when a critical pipeline fails to run. Azure Machine Learning creates events in Azure Event Grid. Multiple roles can subscribe to be notified of an event.
* When you use Azure DevOps for automation, use Azure DevOps Tasks for Machine Learning to use machine learning models as pipeline triggers.
* When you develop Python packages for your machine learning application, you can host them in an Azure DevOps repository as artifacts and publish them as a feed. By using this approach, you can integrate the DevOps workflow for building packages with your Azure Machine Learning workspace.
* Consider using a staging environment to test machine learning pipeline system integration with upstream or downstream application components.
* Create unit and integration tests for your inference endpoints for enhanced debugging and to accelerate time to deployment.
* To trigger retraining, use dataset monitors and event-driven workflows. Subscribe to data drift events and automate the trigger of machine learning pipelines for retraining.

## <a name="4-references"></a>4. References


|Topics          |Links                                               |Notes    |
|----------------|----------------------------------------------------|---------|
|Azure MLOps     |[DevOps for Machine Learning](https://www.youtube.com/playlist?list=PLiQS6N-W1p3m9squzZ2cPgGdH5SBhjY6f)|Youtube step-by-step|
|Learning Path   |[End-to-end machine learning operations](https://learn.microsoft.com/en-us/training/paths/build-first-machine-operations-workflow/)||
|Code Tests      |[Example tests for MLOps](https://github.com/microsoft/recommenders/tree/main/tests)|         |
|MLOps Maturity with AzureML|[MLOps Maturity Model with Azure Machine Learning](https://techcommunity.microsoft.com/t5/ai-machine-learning-blog/mlops-maturity-model-with-azure-machine-learning/ba-p/3520625)||
|Team Data Science Process|[Team Data Science Process](https://learn.microsoft.com/en-us/azure/architecture/data-science-process/overview)||
|Azure MLOps Best Practises|[Azure Machine Learning best practices for MLOps](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-mlops)||

|Topics          |Links                                               |Notes    |
|----------------|----------------------------------------------------|---------|
|GitHub Flow     |[GitHub Flow](http://scottchacon.com/2011/08/31/github-flow.html)||
|Git             |[Git in Practice](https://www.amazon.com/gp/product/1617291978)||
|Git branching strategies |[A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)||

