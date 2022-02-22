# Welcome to the FastTrack for Vision AI/ML in Azure

## We will start 3-4 minutes after the scheduled time to accommodate those still connecting

> This call will not be recorded due to the wide audience and to encourage
> questions.

**Questions?** Feel free to type them in the chat window at any time. Note that
questions you post will be public.

**Slideless** No PowerPoint, we promise! As we update this content you will get
the changes straight away.

**Feeback** We would like to hear your thoughts, please provide us your feedback
and register for other sessions at [//aka.ms/ftalive](https://aka.ms/ftalive).

In this session you will learn about using Azure Machine Learning for vision related tasks. You will learn about deep computer vision and vision related tasks, including classification, segmentation, 2D, 3D pose estimation, video action recognition and more. We then discuss how to use Azure automation and cloud deployment and processing of your machine learning tasks.

## Agenda

1. [Overview of Vision AI with Azure](#Explore-Vision-AI-with-Azure)
2. [Getting Started](#Getting-Started)
3. [Vision AI Scenarios](#Vision-AI-Scenarios)
    - [Classification](#Classification)
    - [Detection](#Detection)
    - [Segmentation](#Segmentation)
    - [Object Tracking](#Object-Tracking)
    - [Keypoints Detection](#Keypoints-Detection)
    - [Action Recognition](#Action-Recognition)
4. [Vision Tasks in Azure](#Vision-Tasks-in-Azure) 
5. [Machine Learning Pipelines](#Machine-Learning-Pipelines)
6. [Fun with Vision AI](#Fun-with-Vision-AI)
7. [QnA](#frequently-asked-questions)
8. [Resources & Training](#resources)
 

## Explore Vision AI with Azure

Computer vision and machine learning have traditionally been separate fields, but today many computer vision tasks are performed with AI/ML methods. In fact, traditional computer vision libraries, like OpenCV, integrate many machine learning methods. Azure supports all of the familiar data science frameworks and vision libraries, in addition it includes many optimized models and tools, such as Cognitive Services, Image Understanding, Spatial Analysis, and more. Many data scientists use open source tools, such as Python, R, Lua, and Julia, which have become very popular. If you have a specific framework or vision library you'd like to use in Azure, you can always package your environment in an Azure virtual machine, serving a wide variety of operating systems, types of processors, storage, and configurations.

Consider Azure Cognitive Services, which provide a shortcut to many pretrained models and methods packaged for scale and efficiency as part of Cognitive Services APIs. Azure Cognitive Services are cloud-based services with REST APIs and client library SDKs available to help you build cognitive intelligence into your applications. You can add cognitive features to your applications without having artificial intelligence (AI) or data science skills. Azure Cognitive Services comprise various AI services that enable you to build cognitive solutions that can see, hear, speak, understand, and even make decisions.

## Getting Started 

There’re several areas, or paradigms in machine learning that define most of the methods with vision AI: supervised, unsupervised and reinforcement learning. This classification is open, in fact if you dig deeply into machine learning research and theory, you’ll also discover weakly supervised, self-learning and a wealth of other methods. 

- **Supervised** learning deals with datasets that include labeled data. Typical tasks for supervised learning include classification, for example classifying activities or objects on the image. For supervised learning to work, large labeled datasets are required. Fortunately, you don’t need to do most of image classification from scratch, datasets such as ImageNet contain tens of millions labeled images, and with techniques like transfer learning, you could use them in your model.
- **Unsupervised** learning doesn’t assume that data is labeled, instead its goal is finding similarities in the data. It’s often used for self-organizing dimensionality reduction and clustering, such as K-Means. For example, if you train an unsupervised model with sufficient data containing images of athletes performing actions in different activity, such a model should be able to predict what group, or sport a given image belongs to. This method is great if you don’t have a labeled data set, but sometimes you have some labels in an unlabeled set: this scenario is often called a semi-supervised problem.
- **Reinforcement learning (RL)** applies a concept of an agent trying to achieve the goal and receiving a reward for most positive actions. Reinforcement learning originated from game theory, theory of control, and Markov Decision Process: it is widely used for robot training, including autonomous vehicles. This book goes over several applications of reinforcement learning in sports: for movement analysis, simulation and coaching.

## Vision AI Tasks in Azure

There are a few different options that are available for Azure when it comes to AI tasks such as classification, detection, segmentation, object tracking, and video action recognition. One option would be to use Azure's pre-built AI services, which include services such as Azure Machine Learning and Azure Cognitive Services. These services provide a wide range of capabilities that can be used for a variety of tasks. Another option would be to use Azure's custom AI services. Azure's custom AI services allow you to use your own data and algorithms to train and deploy custom AI models. This option provides more flexibility and control over the AI models that are used. You can also use custom models with any of the open-source frameworks and tools and package them in virtual machines or deploy as part of Azure Machine Learning pipelines to your compute targets.

### Classification

Given an input image, predict what object is present in the image. Classification is one of the easiest problems to solve. Classification of objects is essential for a machine learning model to understand various classes of objects present in the video or image: for example, classifying a human, or a tennis ball is the first practical step towards analyzing the image. Most image classification models are trained on public datasets such as ImageNet and usually involve convolution neural networks (CNNs).

**Examples**:
- [Azure Workspace for Classification](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/classification/20_azure_workspace_setup.ipynb) 
- [Deployment to Azure Kubernetes Services](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/classification/22_deployment_on_azure_kubernetes_service.ipynb)
- [Classification Example](https://github.com/kevinash/ai-in-sports/blob/master/4.2_Classification.ipynb)

### Detection 

Given an input image, identify and locate which objects are present. Detection of objects from images or videos is a fundamental task in deep vision: typically, it involves finding a bounding box for an object. Detection is usually done with R-CNN (Region based CNN).

**Examples**:
- [Detection Example](https://github.com/kevinash/ai-in-sports/blob/master/4.3_Detection.ipynb)
- [Training](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/detection/01_training_introduction.ipynb) 
- [Deployment to Azure Kubernetes Services](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/detection/20_deployment_on_kubernetes.ipynb) 
- [Detecting objects in images](https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/concept-object-detection) 
- [Brand detection](https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/concept-brand-detection))

### Segmentation 

Segmentation is the next step from classification and detection, dividing the image to segments on the pixel level: given an input image, assign a label to objects within an image. Because objects are often occluded in images, with parts of one blocking another, instance segmentation helps identifying entire objects regardless of occlusion. Some examples of networks that semantic segmentation models use are Mask R-CNN.

**Examples**:
- [Segmentation Example](https://github.com/kevinash/ai-in-sports/blob/master/4.4_Segmentation.ipynb)
- [Training](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/segmentation/01_training_introduction.ipynb)

### Keypoints Detection

Keypoints detection, in particular human keypoints detection, is the task of estimating human body pose, typically based on the model that consists of human body parts and joints. 

**Example**:
[Human Keypoints Detection](https://github.com/kevinash/ai-in-sports/blob/master/4.5_HumanBodyKeypoints.ipynb)

### Action Recognition

Action recognition typically involves analyzing actions over time. Kinetics is an example of a dataset targeting action recognition. 

**Example**:
[Video Action Recognition](https://github.com/kevinash/ai-in-sports/blob/master/6.1_VideoActionRecognition.ipynb)

### Object Tracking

In computer vision, object tracking is the task of automatically tracking the position and orientation of some object in a digital image or video sequence. Methods used for object tracking include optical flow, Kalman filters, and deep learning. 

## Working with AI in Azure

Today, a lot of machine learning compute tasks happen in Azure data centers. As a data scientist, you may have started your research on your local computer, playing with various models, frameworks and sets of data, but there’s a good chance that when your project reaches the stage when people start using it, you’ll need the many resources that the cloud provides. Typically, once you created a prototype of your project in a notebook, you'll deploy it in Azure, and that involves model management, specifying compute environments, training models, continuous model delivery and using models in your apps:

- *Model Management*:  To make a model available for your client, the model needs to be deployed, so you can give your clients something like a link to an API, and then they can use it in their own apps.

- *Compute Environments*: Azure has a wide range of compute resources to choose from, and you need to select the right one for your model.

- *Training Models*: Azure Machine Learning has a number of different ways of training models, and you need to choose the right one for your data and project.

- *Continuous Model Delivery*: After your model is trained, you need to be able to deploy it in a way that is automatic and reliable.

- *Using Models in Apps*: Once your model is deployed, you need to be able to use it in your own apps.

## Machine Learning Pipelines

Azure ML pipelines help you to create a workflow that stitches together various ML phases. This allows you to track your model's performance in the real world, detect data drift, and more. ML pipelines are ideal for batch scoring scenarios, using various computes, and reusing steps instead of rerunning them. Additionally, you can share your ML workflows with others.

### Managing Models

The term CI/CD (Continuous Integration/Continuous Delivery) many times referring to the development cycle in machine learning, and in this section we’ll be going over some practical examples of taking your research to the level of best practices and standards used in modern data science.

The first step in deploying your models is registering them in the workspace, this saves them in the cloud so they can be used later from your code ([example](https://github.com/kevinash/ai-in-sports/blob/master/8.1_CloudBasedAI.ipynb)):

```python

from azureml.core.model import Model

model = Model.register(model_path = "./models",
             model_name = "TestModel",
             description = "Classification",
             workspace = workspace)

```

Now, referencing your models becomes easy, simply pass your workspace and model name and in your code, you have a reference to the model  ([example](https://github.com/kevinash/ai-in-sports/blob/master/8.1_CloudBasedAI.ipynb)):

```python

model = Model(workspace, 'TestModel')

```

You can check the path in the cloud of the model you just deployed, note that registration automatically versions your models  ([example](https://github.com/kevinash/ai-in-sports/blob/master/8.1_CloudBasedAI.ipynb)):

```python
Model.get_model_path('TestModel', _workspace=workspace)
```

The location of your registered model in the workspace will become important in the next steps, because you’ll need to reference this model in your scoring script’s initialization, when this model is loaded by your service.

- [Deploying Models to Azure](https://github.com/kevinash/ai-in-sports/blob/master/8.1_CloudBasedAI.ipynb)
- [Deploying to Azure Kubernetes Service](https://github.com/microsoft/computervision-recipes/blob/master/scenarios/classification/22_deployment_on_azure_kubernetes_service.ipynb)

### Dealing with AI/ML Data in Azure

Azure Data Lake Store and Azure Data Lake Analytics are services for storing and processing large data sets. Data Lake Storage is a storage service that you can use to store data in any format. Data Lake Analytics is an analytic service that you can use to process data in Data Lake Storage.

### Run a Pipeline

You can [trigger pipelines](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-trigger-published-pipeline) from Azure Portal, or on the schedule. To schedule a pipeline, you'll need a reference to your workspace, the identifier of your published pipeline, and the name of the experiment in which you wish to create the schedule.

```python
import uuid
import azureml.core
from azureml.core import Workspace
from azureml.pipeline.core import Pipeline, PublishedPipeline
from azureml.core.experiment import Experiment
from azureml.pipeline.core.schedule import ScheduleRecurrence, Schedule

ws = Workspace.from_config()

experiments = Experiment.list(ws)
for experiment in experiments:
    print(experiment.name)

published_pipelines = PublishedPipeline.list(ws)
for published_pipeline in  published_pipelines:
    print(f"{published_pipeline.name},'{published_pipeline.id}'")

experiment_name = "Test Experiment" 
pipeline_id = str(uuid.uuid4())

recurrence = ScheduleRecurrence(frequency="Minute", interval=15)
recurring_schedule = Schedule.create(ws, name="MyRecurringSchedule", 
                            description="Based on time",
                            pipeline_id=pipeline_id, 
                            experiment_name=experiment_name, 
                            recurrence=recurrence)
``` 

## Cognitive Services
 
Azure Cognitive Services are a set of cloud-based services that allow you to add features like speech recognition, facial recognition, and sentiment analysis to your applications without having any AI or data science skills. These services are divided into different categories, like vision, speech, and language, which each have their own set of APIs and SDKs.


## Frequently asked questions

Check for the questions that came up during live sessions.

## Resources

A list of curated AzureML samples:

- [Microsoft Best practices and Guidance for Vision](https://github.com/microsoft/computervision-recipes)
- [Architectural Approaches to AI/ML in Azure](https://docs.microsoft.com/en-us/azure/architecture/guide/multitenant/approaches/ai-ml)
- [Many models solution accelerator](https://github.com/microsoft/solution-accelerator-many-models)
- [Official AzureML notebook samples](https://github.com/Azure/MachineLearningNotebooks/)
- [MLOps starter](https://aka.ms/mlops) 
- [Applied Machine Learning for Health and Fitness](https://github.com/kevinash/ai-in-sports)
- 

### Fun with Vision AI

- [Sketching](https://github.com/kevinash/awesome-ai/#project-41-explore-sketching)
- [Colorization](https://github.com/kevinash/awesome-ai/#project-42-colorize-your-sketch)
- [Faces and Facial Expressions](https://github.com/kevinash/awesome-ai/#chapter-5-faces-and-expressions)
- [Body and Pose](https://github.com/kevinash/awesome-ai/#chapter-6-body-and-poses)
- [Animation with AI](https://github.com/kevinash/awesome-ai/#chapter-7-animation)
- [Style and Creativity](https://github.com/kevinash/awesome-ai/#chapter-9-style-and-creativity)

### Books 

- [Make Art with Artificial Intelligence](https://www.amazon.com/dp/B091J3T4HM)
- [Applied Machine Learning for Health and Fitness](https://www.amazon.com/dp/B091J3T4HM)

### Courses

- [Microsoft Azure AI Fundamentals course](https://docs.microsoft.com/en-us/learn/certifications/azure-ai-fundamentals/)
- [AI in Sports with Python](http://ai-learning.vhx.tv/) 