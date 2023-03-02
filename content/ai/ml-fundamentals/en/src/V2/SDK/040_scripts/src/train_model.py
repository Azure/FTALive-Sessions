import argparse
import os
import lightgbm as lgb
import json
from datetime import datetime
import joblib
import mlflow
from pathlib import Path
from uuid import uuid4
import pandas as pd

mlflow.lightgbm.autolog()

parser = argparse.ArgumentParser("train")
parser.add_argument("--training_data", type=str, help="Path to training data")
parser.add_argument("--learning_rate", type = float, help = "Learning rate for LightGBM")
#parser.add_argument("--test_data", type=str, help="Path to test data")
parser.add_argument("--model_output", type=str, help="Path of output model")

args = parser.parse_args()

print(f"Training data path: {args.training_data}")
print(f"Learning rate: {args.learning_rate}")
print(f"Model output path: {args.model_output}")

print("mounted_path files: ")
arr = os.listdir(args.training_data)
print(arr)

print("Loading Data")
train_data = lgb.Dataset(os.path.join(args.training_data, "train_dataset.bin"))
validation_data = lgb.Dataset(os.path.join(args.training_data, "validation_dataset.bin"))


metric = "rmse"
validation_set_name = (
    "test_dataset"  # The name that will appear in the evaluation results
)
param = {
    "task": "train",
    "objective": "regression",
    "metric": metric,
    "num_leaves": 5,
    "learning_rate": args.learning_rate,
}

evals_result = {}
model = lgb.train(
    param,
    train_set=train_data,
    valid_sets=validation_data,
    valid_names=[validation_set_name],
    early_stopping_rounds=5,
    evals_result=evals_result,
)

tags = {
    "metric": metric,
    "best_score": model.best_score[validation_set_name][metric],
    "best_iteration": model.best_iteration,
    "trained_date": datetime.now().isoformat(),
}

print(f"Saving model and tags to path: {args.model_output}")
mlflow.lightgbm.save_model(model, args.model_output)

with open(os.path.join(args.model_output, "model.tags.json"), "w") as write_file:
    json.dump(tags, write_file)

mlflow.register_model


