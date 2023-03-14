# Import libraries

import argparse
import glob
import os

import pandas as pd

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split

# define functions
def main(args):
    # TO DO: enable autologging


    # read data
    df = get_csvs_df(args.training_data)

    # split data
    X_train, X_test, y_train, y_test = split_data(df)

    # train model
    trained_model = train_model(args.reg_rate, X_train, X_test, y_train, y_test)

    # evaluate model
    evaluate_model(trained_model, X_test, y_test)
    

def get_csvs_df(path):
    if not os.path.exists(path):
        raise RuntimeError(f"Cannot use non-existent path provided: {path}")
    csv_files = glob.glob(f"{path}/*.csv")
    if not csv_files:
        raise RuntimeError(f"No CSV files found in provided data path: {path}")
    return pd.concat((pd.read_csv(f) for f in csv_files), sort=False)


# TO DO: add function to split data
def split_data(df):
    X = df.drop("Diabetic", axis=1)
    y = df["Diabetic"]
    return train_test_split(X, y, test_size=0.2, random_state=42)

def train_model(reg_rate, X_train, X_test, y_train, y_test):
    # train model
    model = LogisticRegression(C=1/reg_rate, solver="liblinear").fit(X_train, y_train)

    return model

# evaluate model
def evaluate_model(model, X_test, y_test):
    y_pred = model.predict(X_test)
    accuracy = (y_pred == y_test).mean()
    print(f"Accuracy: {accuracy:.2f}")



def parse_args():
    # setup arg parser
    parser = argparse.ArgumentParser()

    # add arguments
    parser.add_argument("--training_data", dest='training_data',
                        type=str)
    parser.add_argument("--reg_rate", dest='reg_rate',
                        type=float, default=0.01)

    # parse args
    args = parser.parse_args()

    # return args
    return args

# run script
if __name__ == "__main__":
    # add space in logs
    print("\n\n")
    print("*" * 60)

    # parse args
    args = parse_args()

    # run main function
    main(args)

    # add space in logs
    print("*" * 60)
    print("\n\n")
