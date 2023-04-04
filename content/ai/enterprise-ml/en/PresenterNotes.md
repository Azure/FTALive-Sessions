# Presenter's notes for AzureML Enterprise Deployment

## Demo environment setup

- Deploy workspace using the instructions in [the src folder](./src/deployment/README.md)
- Navigate to **Author** | **Notebooks**. To demonstrate you cannot access Notebooks.Run all notebooks located in the **fta-live** | **fundamentals** | **src** | **notebooks** folder in the **Files** tree.
- Configure and run a regression autoML experiment on top of the **diabetes-tabular** that got registered. You can create a new experiment named **diabetes-automl-experiment**. Target column is **target** and you can use the **cpu-cluster** cluster that is available. In the **View additional configuration settings** specify 0.5 in the **Exit criterion** | **Training job time (hours)**.
- Navigate to the AutoML run and name it **30minute_automl_run**.
- Select a trained model from the AutoML run (not the best one) and select the **Explain model** option to perform a model explanation.
- Deploy the selected model as an Azure Container Instance named **deploy-to-aci**.
- Navigate to **Assets** | **Datasets** | **pending-diabetes** and complete the **Generate profile** wizard.

## Before the live event

- Start your compute instance and execute the [before_event.py](./src/before_event.py) script in a terminal to scale up the **cpu-cluster**.
- Open an Azure portal, navigate to the resource group and filter out the **container instances** to be able to show only the 5 AzureML deployed resources.
- Navigate to the **deploy-to-aci** endpoint:
  - Open the **Swagger URI**. Copy paste it in a [json formatter](https://www.jsonformatter.io/)
  - Copy the **REST endpoint** and paste it in the [reqbin sample](https://reqbin.com/etrbvco6). Select the **Content (27)** tab to have the sample request ready to send. If you want to try it, you can then remove one of the two records during the live event.
- Dismiss all notifications in the AzureML studio.

## During the live event

- Tell audience that you will be training models against the [scikit learn diabetes dataset](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_diabetes.html). The dataset contains features like blood pressure and glucose concentration of 442 diabetes patients which are normalized and stored into 10 features named 0 to 9. The target column of the dataset is a numeric value representing a quantitative measure of the disease progression, one year after the features where measured.
- While showing the profile of the **diabetes-tabular** dataset, show the **box and whisker plot** where you can see some outliers above 0.1, something that you will use later in the model interpretation to form a cohort.

  ![Outliers in dataset profile](images/show_feature_2_outlier_more_than_0.1.png)
- In AutoML run, in the best model's **Explanations** tab, create a cohort named **Feature 2 more than 0.1** (or just **F2G0.1**) to show how in that cohort, the most important feature is the feature named **2**.

  ![Creating the cohort](images/explainer_cohort.jpg)
- After creating the cohort, go to the **Individual feature importance** and show how in that cohort, all records have **Predicted Y** value above 220 (show audience that axis of that graph can change).

  ![Cohort individual records](images/show_feature_2_individual_records.png)
- Ask for [feedback](https://aka.ms/ftaLive-feedback).

## After the live event

- Execute the [after_event.py](./src/after_event.py) script in a terminal to delete deployed web services, scale down clusters and shut down you compute instance.
