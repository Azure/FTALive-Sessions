import argparse
import os
import joblib
import mlflow
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LassoLars
from sklearn import datasets

# This script can run locally using
# python <name>.py --alpha 0.9
parser = argparse.ArgumentParser()
parser.add_argument("--alpha", type=float, dest="alpha", help="The alpha parameter")
args = parser.parse_args()

# Prepare the training dataset
diabetes = datasets.load_diabetes()
X = diabetes.data
y = diabetes.target

# Tracking with mlflow
mlflow.sklearn.autolog()
pipe = make_pipeline(StandardScaler(), LassoLars(alpha=args.alpha))
pipe.fit(X, y)

os.makedirs("./outputs", exist_ok=True)
joblib.dump(value=pipe, filename="./outputs/custom_serialization.pkl")

print(os.environ.get("MY_VAR", "MY_VAR is not set"))