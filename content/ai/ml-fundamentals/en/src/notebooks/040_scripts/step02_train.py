import argparse
import os
import lightgbm as lgb
import json
from datetime import datetime
import joblib

parser = argparse.ArgumentParser()
parser.add_argument(
    "--learning-rate",
    type=float,
    dest="learning_rate",
    help="Learning rate for LightGBM",
)
parser.add_argument(
    "--input-path",
    type=str,
    dest="input_path",
    help="Directory containing the datasets",
)
parser.add_argument(
    "--output-path", type=str, dest="output_path", help="Directory to store model"
)
args = parser.parse_args()

print(f"Loading data from {args.input_path}")
train_data = lgb.Dataset(os.path.join(args.input_path, "train_dataset.bin"))
validation_data = lgb.Dataset(os.path.join(args.input_path, "validation_dataset.bin"))

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

output_path = args.output_path
if not os.path.exists(output_path):
    os.makedirs(output_path)

joblib.dump(value=model, filename=os.path.join(output_path, "model.joblib"))

with open(os.path.join(output_path, "model.tags.json"), "w") as write_file:
    json.dump(tags, write_file)
