from sklearn.datasets import load_diabetes
import pandas as pd

features, target = load_diabetes(return_X_y=True)
diabetes_df = pd.DataFrame(features)
diabetes_df["target"] = target

diabetes_df.to_csv("diabetes_raw_data.csv", index=False)
