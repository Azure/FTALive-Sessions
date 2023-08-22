import argparse
import os
from azureml.core.run import Run
import lightgbm as lgb
import json
import mlflow
from pathlib import Path


parser = argparse.ArgumentParser("register-model")
parser.add_argument("--model_name", type=str, help="Name of the model")
parser.add_argument("--model_input_path", type=str, help="Path to model from training run")


args = parser.parse_args()

current_experiment = Run.get_context().experiment
tracking_uri = current_experiment.workspace.get_mlflow_tracking_uri()
print("tracking_uri: {0}".format(tracking_uri))
mlflow.set_tracking_uri(tracking_uri)
mlflow.set_experiment(current_experiment.name)

print("Loading model")
mlflow_model = mlflow.lightgbm.load_model(args.model_input_path)

registered_name = args.model_name

print("Registering via MLFlow")
mlflow.lightgbm.log_model(
    lgb_model=mlflow_model,
    registered_model_name=registered_name,
    artifact_path=registered_name,
)
