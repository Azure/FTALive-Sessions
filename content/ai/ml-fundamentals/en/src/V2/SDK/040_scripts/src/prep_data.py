import argparse
import os
from pathlib import Path
from uuid import uuid4
from datetime import datetime
import pandas as pd
import lightgbm as lgb
from sklearn.model_selection import train_test_split


parser = argparse.ArgumentParser("prep")
parser.add_argument("--raw_data", type=str, help="Path to raw data")
parser.add_argument("--prep_data", type=str, help="Path of prepped data")

args = parser.parse_args()

print("Hello Data Prep Component - Convert to LightGBM Dataset")

print(f"Raw data path: {args.raw_data}")
print(f"Data output path: {args.prep_data}")

input_df = pd.read_csv(args.raw_data)

x = input_df[["age", "sex", "bmi", "bp", "s1", "s2", "s3", "s4", "s5", "s6"]]
y = input_df["target"].values
feature_names = x.columns.to_list()

# Create training and validation sets
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42
)

# Create the LightGBM data containers
train_data = lgb.Dataset(x_train, label=y_train, feature_name=feature_names)
test_data = lgb.Dataset(x_test, label=y_test, reference=train_data)


# Store the data in an optimized format
train_data.save_binary(os.path.join(Path(args.prep_data), "train_dataset.bin"))
test_data.save_binary(os.path.join(Path(args.prep_data), "validation_dataset.bin"))

print(f"files in output_dir: {os.listdir(args.prep_data)}")



