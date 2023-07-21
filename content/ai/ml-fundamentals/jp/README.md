# Azure Machine Learning 基礎編 Live event

本ライブセッションでは、[Azure Machine Learning (AzureML)](https://docs.microsoft.com/azure/machine-learning/overview-what-is-azure-machine-learning) の概要を説明し、[AzureML Studio](https://docs.microsoft.com/azure/machine-learning/overview-what-is-machine-learning-studio) の Web ポータル機能や [Azure ML Python SDK](https://docs.microsoft.com/ja-JP/python/api/overview/azure/ml/?view=azure-ml-py) を使って機械学習のプロセスを実行する様子をデモンストレーションを通じて解説します。


<br/>

## アジェンダ
|     | トピック  | 機能 | 概要  
| :-- | :----- | :-----  | :-----
| 00. | Introduction  |     | セッションの概要について説明します。
| 01. | Azure ML 概要  |     | Azure AI の全体像、Azure Machine Learning のコンポーネントや特徴を説明します。<br/> - [スライド資料](FTA-Live-AzureML-Fundamental.pdf)
| 02. | Demo : Azure Machine Learning サービス作成 |[Azure Portal](http://portal.azure.com/) | Azure Portal を利用したサービスのデプロイ方法や作成される関連 Azure サービスの説明をします。<br/> - [Azure Portal デモンストレーション手順](demonstration/azure_portal_azureml.md)
| 03. | Demo : Azure Machine Learning Studio | [AzureML Studio](https://ml.azure.com/) | Azure ML Studio の Web ポータル機能を用いてモデル学習からデプロイまでの一連の流れをデモンストレーションします。<br/> - [Azure ML Studio デモンストレーション手順](demonstration/azureml_studio_walk_through.md)
| 04. | Demo : Azure Machine Learning Python SDK | [AzureML Python SDK](https://docs.microsoft.com/ja-JP/python/api/overview/azure/ml/?view=azure-ml-py) | Python SDK を使った E2E の機械学習プロセスの実行方法をデモンストレーションする。<br/> - モデル学習 : [Markdown 形式](src/notebooks/train-notebook.md) \| [Notebook 形式](src/notebooks/train-notebook.ipynb) <br/> - デプロイ: [Markdown 形式](src/notebooks/deploy-notebook.md) \| [Notebook 形式](src/notebooks/deploy-notebook.ipynb)

<br/>

## サンプル

Azure ML のサンプルコード・ノートブックの一覧 : 

- [Official AzureML Samples](https://github.com/Azure/MachineLearningNotebooks/)
- [Community-driven AzureML Samples](https://github.com/Azure/azureml-examples)
- [MLOps templates](https://aka.ms/mlops)