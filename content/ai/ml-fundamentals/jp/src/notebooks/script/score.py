import os
import json
import numpy as np
import pandas as pd
import lightgbm as lgb


def data_preprocess(df, categorical_cols, float_cols):
    df[categorical_cols] = df[categorical_cols].astype("category")
    df[float_cols] = df[float_cols].astype("float")
    return df


def init():
    global bst
    model_root = os.getenv("AZUREML_MODEL_DIR")
    # The name of the folder in which to look for LightGBM model files
    lgbm_model_folder = "model"
    bst = lgb.Booster(
        model_file=os.path.join(model_root, lgbm_model_folder, "model.lgb")
    )


def run(raw_data):
    categorical_cols = ["Name", "Sex", "Ticket", "Cabin", "Embarked"]
    float_cols = ["Pclass", "Age", "SibSp", "Parch", "Fare"]
    columns = bst.feature_name()
    data = np.array(json.loads(raw_data)["data"])
    test_df_original = pd.DataFrame(data=data, columns=columns)
    test_df = data_preprocess(test_df_original, categorical_cols, float_cols)
    # Make prediction
    out = bst.predict(test_df)
    return out.tolist()
