---
challenge:
    module: 'Trigger GitHub Actions with trunk-based development'
    challenge: '3: Trigger GitHub Actions with trunk-based development'
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

# Challenge 3: Trigger GitHub Actions with trunk-based development

<button class="button" onclick="window.location.href='https://microsoftlearning.github.io/mslearn-mlops/';">Back to overview</button>

## Challenge scenario

Triggering a workflow by pushing directly to the repo is **not** considered a best practice. Preferably, you'll want to review any changes before you build them with GitHub Actions.

## Prerequisites

If you haven't, complete the [previous challenge](02-github-actions.md) before you continue.

## Objectives

By completing this challenge, you'll learn how to:

- Work with trunk-based development.
- Protect the main branch.
- Trigger a GitHub Actions workflow by creating a pull request.

> **Important!**
> Each challenge is designed to allow you to explore how to implement DevOps principles when working with machine learning models. Some instructions may be intentionally vague, inviting you to think about your own preferred approach. If for example, the instructions ask you to create an Azure Machine Learning workspace, it's up to you to explore and decide how you want to create it. To make it the best learning experience for you, it's up to you to make it as simple or as challenging as you want.

## Challenge Duration

- **Estimated Time**: 45 minutes

## Instructions

Use trunk-based development to better govern changes made to the repo and the triggering of GitHub Actions.

- Create a GitHub Actions workflow which is triggered by the creation of a pull request. 

    The workflow will be used for code verification in the next challenge. For now, you can include whatever step you want. For example, use the `echo` command:

```yml
    - name: Placeholder
      run: |
        echo "Will add code checks here in next challenge"
```

- Create a **branch protection rule** to block any direct pushes to the **main** branch.

> **Note:**
> By default, branch protection rules do not apply to administrators. If you're the administrator of the repo you're working with, you'll still be allowed to push directly to the repo. 

To trigger the workflow, do the following:

- Create a branch in the repo.
- Make a change and push it. For example, change the hyperparameter value. 
- Create a pull request merge the new branch with the main. 

## Success criteria

To complete this challenge successfully, you should be able to show:

- The branch protection rule for the main branch.
- A successfully completed Action in your GitHub repo which is triggered by a new pull request.

## Useful resources

- Learn more about source control for machine learning projects and [how to work with trunk-based development and GitHub repos.](https://docs.microsoft.com/learn/modules/source-control-for-machine-learning-projects/)
- [General documentation for GitHub Actions.](https://docs.github.com/actions/guides)
- [Triggering a GitHub Actions workflow.](https://docs.github.com/actions/using-workflows/triggering-a-workflow)
- [Events that trigger workflows.](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows)
- [Workflow syntax for GitHub Actions.](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions)

<button class="button" onclick="window.location.href='04-unit-test-linting';">Continue with challenge 4</button>