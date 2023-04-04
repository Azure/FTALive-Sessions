---
challenge:
    module: 'Work with environments in GitHub Actions'
    challenge: '5: Work with environments'
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

# Challenge 5: Work with environments

<button class="button" onclick="window.location.href='https://microsoftlearning.github.io/mslearn-mlops/';">Back to overview</button>

## Challenge scenario

There are many advantages to using environments in machine learning projects. When you have separate environments for development, staging, and production, you can more easily control access to resources. 

Use environments to isolate workloads and control the deployment of the model.

## Prerequisites

If you haven't, complete the [previous challenge](04-unit-test-linting.md) before you continue.

**Your repo should be set to public**. If you're using a private repo without GitHub Enterprise Cloud, you'll not be able to create environments. [Change the visibility of your repo to public](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility) if your repo is set to private.

You'll re-use the workflow you created for [challenge 2: trigger the Azure Machine Learning job with GitHub Actions](02-github-actions.md). 

## Objectives

By completing this challenge, you'll learn how to:

- Set up a development and production environment.
- Add a required reviewer.
- Add environments to a GitHub Actions workflow.

> **Important!**
> Each challenge is designed to allow you to explore how to implement DevOps principles when working with machine learning models. Some instructions may be intentionally vague, inviting you to think about your own preferred approach. If for example, the instructions ask you to create an Azure Machine Learning workspace, it's up to you to explore and decide how you want to create it. To make it the best learning experience for you, it's up to you to make it as simple or as challenging as you want.

## Challenge Duration

- **Estimated Time**: 60 minutes

## Instructions

Initially, data scientists will train the model in an Azure Machine Learning workspace which is configured for experimentation. Ideally, we don't want to make the production data available in the experimentation or development environment. Instead, data scientists will only have access to a small dataset which should behave similarly to the production dataset. 

By reusing the training script created by the data scientists, you can train the model in the production environment using the production data, simply by changing the data input.

> **Note:**
> Though it's a best practice to associate a separate Azure Machine Learning workspace to each separate environment, you can use one workspace for both the development and production environment for this challenge (to avoid extra costs). 

- Within your GitHub repo, create a development and production environment.
- Add an approval check for the production environment. 
- Remove the global repo **AZURE_CREDENTIALS** secret, so that each environment will only be able to use its own secret.
- For each environment, add the **AZURE_CREDENTIALS** secret that contains the service principal output. 

> **Note:**
> If you don't have the service principal output anymore from [challenge 2](03-github-actions.md), go back to the Azure portal and create it again. You can only get the necessary output at the time of creation.

- Create a new data asset in the workspace with the following configuration:
  - **Name**: *diabetes-prod-folder*
  - **Path**: The **data** folder in the **production** folder which contains a larger CSV file to train the model. The path should point to the folder, not to the specific file.  
- Create one GitHub Actions workflow, triggered by changes being pushed to the main branch, with two jobs:
  - The **experiment** job that trains the model using the *diabetes-dev-folder* dataset in the **development environment**. 
  - The **production** job that trains the model in the **production environment**, using the production data (the *diabetes-prod-folder* data asset as input).
- Add a condition that the **production** job is only allowed to run when the **experiment** job ran *successfully*. Success means that the Azure Machine Learning job ran successfully too.

<details>
<summary>Hint</summary>
<br/>
You'll need to do two things to ensure the production job only runs when the experiment job is successful: add <code>needs</code> to the workflow and add <code>--stream</code> to the CLI command to trigger the Azure Machine Learning job. 
</details>

## Success criteria

To complete this challenge successfully, you should be able to show:

- Show the environment secrets in the settings.
- A successfully completed Actions workflow that contains two jobs. The production job needs the experimentation job to be successful to run.
- Show that the workflow required an approval before running the production workload.
- Show two successful Azure Machine Learning jobs, one trained with the *diabetes-dev-folder* as input and the other with the *diabetes-prod-folder* as input.

## Useful resources

- Learn more about [continuous deployment for machine learning.](https://docs.microsoft.com/learn/modules/continuous-deployment-for-machine-learning/)
- [Workflow syntax for GitHub Actions.](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions)
- [Using environments for deployment in GitHub.](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [How to create a secret in a GitHub repo.](https://docs.github.com/actions/security-guides/encrypted-secrets)
- [CLI reference for jobs.](https://docs.microsoft.com/cli/azure/ml/job?view=azure-cli-latest)

<button class="button" onclick="window.location.href='06-deploy-model';">Continue with challenge 6</button>