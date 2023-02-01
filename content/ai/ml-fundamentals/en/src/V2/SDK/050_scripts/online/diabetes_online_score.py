from azureml.core import Model
import joblib
import os


def init():
    global model
    model_path = os.path.join(os.environ["AZUREML_MODEL_DIR"], "Diabetest-LGBM-Model")
    model_location = os.path.join(model_path, "model.joblib")
    print(f"Loading model from {model_location}")
    model = joblib.load(model_location)


def run(mini_batch):
    print(mini_batch.info())
    # Drop id column which was not used during the training of the model
    mini_batch["target_predict"] = model.predict(mini_batch.drop("target", axis=1, inplace=False))
    return mini_batch["target","target_predict"].values.tolist()