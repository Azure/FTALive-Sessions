import argparse
import os
from azureml.core.run import Run
import lightgbm as lgb
from sklearn.model_selection import train_test_split

parser = argparse.ArgumentParser()
parser.add_argument(
    "--dataset-id", type=str, dest="dataset_id", help="Dataset id passed as input"
)
parser.add_argument(
    "--output-path", type=str, dest="output_path", help="directory to store results"
)
args = parser.parse_args()

run = Run.get_context()
training_dataset = run.input_datasets["input_dataset"]

print(f"Dataset id: {training_dataset.id} which is equal to {args.dataset_id}")
train_df = training_dataset.to_pandas_dataframe()

x = train_df[["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]]
y = train_df["target"].values
feature_names = x.columns.to_list()

# Create training and validation sets
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42
)


# Create the LightGBM data containers
train_data = lgb.Dataset(x_train, label=y_train, feature_name=feature_names)
test_data = lgb.Dataset(x_test, label=y_test, reference=train_data)

# Create output path if not exists
output_path = args.output_path
if not os.path.exists(output_path):
    os.makedirs(output_path)

# Store the data in an optimized format
train_data.save_binary(os.path.join(output_path, "train_dataset.bin"))
test_data.save_binary(os.path.join(output_path, "validation_dataset.bin"))

print(f"Prepared data in {output_path}")
