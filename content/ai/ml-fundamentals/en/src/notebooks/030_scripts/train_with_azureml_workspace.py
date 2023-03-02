import argparse
import os
import joblib
import mlflow
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LassoLars
from azureml.core import Workspace
from azureml.core.run import Run, _OfflineRun

# This script can run locally using
# python <name>.py --alpha 0.9
parser = argparse.ArgumentParser()
parser.add_argument("--alpha", type=float, dest="alpha", help="The alpha parameter")
args, unknown_args = parser.parse_known_args()

# This code could have been much simpler if we were only planning
# to run on a remote compute passing the dataset as a named input.
# This code allows you to run the same script in a local terminal.

# Get access to the workspace
run = Run.get_context()
ws = None
if type(run) == _OfflineRun:
    # If running locally
    ws = Workspace.from_config()
else:
    # If running on remote cluster
    ws = run.experiment.workspace

# Prepare the training dataset
diabetes_ds = None
if type(run) != _OfflineRun and "diabetes_dataset" in run.input_datasets:
    # If we passed the dataset as_named_input
    diabetes_ds = run.input_datasets["diabetes_dataset"]
    print("Loading dataset from input")
else:
    # If we are offline, or we didn't pass the dataset as input,
    # get the latest dataset, registered in 010_basic_sdk.ipynb
    diabetes_ds = ws.datasets["diabetes-tabular"]
    print("Loading dataset from workspace")

X = diabetes_ds.drop_columns("target").to_pandas_dataframe()
y = diabetes_ds.keep_columns("target").to_pandas_dataframe()

# Tracking with mlflow
mlflow.sklearn.autolog()

pipe = make_pipeline(StandardScaler(), LassoLars(alpha=args.alpha))
pipe.fit(X, y)

os.makedirs("./outputs", exist_ok=True)
joblib.dump(value=pipe, filename="./outputs/custom_serialization.pkl")

print(os.environ.get("MY_VAR", "MY_VAR is not set"))
