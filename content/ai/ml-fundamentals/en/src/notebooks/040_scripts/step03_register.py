import argparse
import os
from azureml.core.run import Run
import lightgbm as lgb
import json

# retrieve arguments configured through script_params in estimator
parser = argparse.ArgumentParser()
parser.add_argument(
    "--input-path", type=str, dest="input_path", help="Directory to load model"
)
parser.add_argument(
    "--dataset-id", type=str, dest="dataset_id", help="Dataset id passed as input"
)
args = parser.parse_args()

input_path = args.input_path

run = Run.get_context()
# Load metadata from the training process

tags = {}
with open(os.path.join(input_path, "model.tags.json"), "r") as read_file:
    tags = json.load(read_file)

# Get reference to the training dataset to associate with model
training_ds = run.input_datasets["input_dataset"]

# Register the model
# We need to upload artifact first to the run
run.upload_folder("model", input_path)
model = run.register_model(
    model_name="pipeline_model",
    model_path="model",
    tags=tags,
    model_framework="LightGBM",
    model_framework_version=lgb.__version__,
    datasets=[("training data", training_ds)],
)

print(f"Registered version {model.version} for model {model.name}")
