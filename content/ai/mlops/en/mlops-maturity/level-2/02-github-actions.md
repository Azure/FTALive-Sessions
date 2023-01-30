---
challenge:
    module: 'Trigger Azure Machine Learning jobs with GitHub Actions'
    challenge: '2: Trigger the Azure Machine Learning job with GitHub Actions'
---

<style>
.button  {
  border: none;
  color: white;
  padding: 12px 28px;
  background-color: #008CBA;
  float: right;
}
</style>

# Challenge 2: Trigger the Azure Machine Learning job with GitHub Actions

<button class="button" onclick="window.location.href='https://microsoftlearning.github.io/mslearn-mlops/';">Back to overview</button>

## Challenge scenario

The benefit of using the CLI (v2) to run an Azure Machine Learning job, is that you can submit the job from anywhere. Using a platform like GitHub will allow you to automate Azure Machine Learning jobs. To trigger the job to run, you can use GitHub Actions.

## Prerequisites

If you haven't, complete the [previous challenge](01-aml-job.md) before you continue.

To complete the challenge, you need to have the authorization to create a service principal. 

## Objectives

By completing this challenge, you'll learn how to:

- Create a service principal and use it to create a GitHub secret for authentication.
- Run the Azure Machine Learning job with GitHub Actions.

> **Important!**
> Each challenge is designed to allow you to explore how to implement DevOps principles when working with machine learning models. Some instructions may be intentionally vague, inviting you to think about your own preferred approach. If for example, the instructions ask you to create an Azure Machine Learning workspace, it's up to you to explore and decide how you want to create it. To make it the best learning experience for you, it's up to you to make it as simple or as challenging as you want.

## Challenge Duration

- **Estimated Time**: 45 minutes

## Instructions

In the **.github/workflows** folder, you'll find the `02-manual-trigger.yml` file. The file defines a GitHub Action which can be manually triggered. The workflow checks out the repo onto the runner, installs the Azure Machine Learning extension for the CLI (v2), and logs in to Azure using the `AZURE_CREDENTIALS` secret.

- Create a service principal, using the Cloud Shell in the Azure portal, which has contributor access to your resource group. 
    
    **Save the output**, you'll *also* need it for later challenges. Update the `<service-principal-name>` (should be unique), `<subscription-id>`, and `<your-resource-group-name>` before using the following command:
```azurecli
    az ad sp create-for-rbac --name "<service-principal-name>" --role contributor \
                                --scopes /subscriptions/<subscription-id>/resourceGroups/<your-resource-group-name> \
                                --sdk-auth
```
- Create a GitHub secret in your repository. Name it `AZURE_CREDENTIALS` and copy and paste the output of the service principal to the **Value** field of the secret. 

<details>
<summary>Hint</summary>
<br/>
The output of the service principal which you need to paste into the <b>Value</b> field of the secret should be a JSON with the following structure:
<pre>
{
"clientId": "your-client-id",
"clientSecret": "your-client-secret",
"subscriptionId": "your-subscription-id",
"tenantId": "your-tenant-id",
"activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
"resourceManagerEndpointUrl": "https://management.azure.com/",
"activeDirectoryGraphResourceId": "https://graph.windows.net/",
"sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
"galleryEndpointUrl": "https://gallery.azure.com/",
"managementEndpointUrl": "https://management.core.windows.net/"
}
</pre>
</details>

- Edit the `02-manual-trigger.yml` workflow to trigger the Azure Machine Learning job you defined in challenge 1.

<details>
<summary>Hint</summary>
<br/>
GitHub is authenticated to use your Azure Machine Learning workspace with a service principal. The service principal is only allowed to submit jobs that use a compute cluster, not a compute instance.
</details>

## Success criteria

To complete this challenge successfully, you should be able to show:

- A successfully completed Action in your GitHub repo, triggered manually in GitHub.
- A step in the Action should have submitted a job to the Azure Machine Learning workspace.
- A successfully completed Azure Machine Learning job, shown in the Azure Machine Learning workspace.

## Useful resources

- The introduction to DevOps principles for machine learning module covers [how to integrate Azure Machine Learning with DevOps tools.](https://docs.microsoft.com/learn/paths/introduction-machine-learn-operations/)
- [Use GitHub Actions with Azure Machine Learning.](https://docs.microsoft.com/azure/machine-learning/how-to-github-actions-machine-learning)
- Learn more about [service principal objects in Azure Active Directory.](https://docs.microsoft.com/azure/active-directory/develop/app-objects-and-service-principals#service-principal-object)
- Learn more about encrypted secrets in GitHub, like [how to name and how to create a secret in a GitHub repo.](https://docs.github.com/actions/security-guides/encrypted-secrets)
- [Manually running a workflow in GitHub Actions.](https://docs.github.com/actions/managing-workflow-runs/manually-running-a-workflow)
- [Re-running workflows and jobs in GitHub Actions.](https://docs.github.com/actions/managing-workflow-runs/re-running-workflows-and-jobs)
- [General documentation for GitHub Actions.](https://docs.github.com/actions/guides)

<button class="button" onclick="window.location.href='03-trigger-workflow';">Continue with challenge 3</button>