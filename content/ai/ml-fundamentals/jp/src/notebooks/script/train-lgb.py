# imports
import time
import mlflow
import argparse

import lightgbm as lgb

from sklearn.metrics import log_loss, accuracy_score
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split

from azureml.core import Run


# データ前処理 (データ型変更、特徴量と目的変数の作成、データ分割)
def preprocess_data(df, categorical_cols, float_cols):

    df[categorical_cols] = df[categorical_cols].astype("category")
    df[float_cols] = df[float_cols].astype("float")

    X = df.drop(["Survived", "PassengerId"], axis=1)
    y = df["Survived"]

    enc = LabelEncoder()
    y = enc.fit_transform(y)

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    return X_train, X_test, y_train, y_test, enc, categorical_cols


# モデル学習
def train_model(
    params, num_boost_round, X_train, X_test, y_train, y_test, categorical_cols
):
    t1 = time.time()
    train_data = lgb.Dataset(
        X_train, label=y_train, categorical_feature=categorical_cols
    )
    test_data = lgb.Dataset(X_test, label=y_test, categorical_feature=categorical_cols)
    model = lgb.train(
        params,
        train_data,
        num_boost_round=num_boost_round,
        valid_sets=[test_data],
        valid_names=["test"],
    )
    t2 = time.time()

    return model, t2 - t1


# モデル評価
def evaluate_model(model, X_test, y_test):
    y_proba = model.predict(X_test)
    y_pred = y_proba.argmax(axis=1)
    loss = log_loss(y_test, y_proba)
    acc = accuracy_score(y_test, y_pred)

    return loss, acc


print("*" * 60)
print("\n\n")


# Azure Machine Learning の実行オブジェクトの取得
run = Run.get_context()
ws = run.experiment.workspace


# 引数情報
parser = argparse.ArgumentParser()
parser.add_argument("--input-data", type=str)
parser.add_argument("--num-boost-round", type=int, default=10)
parser.add_argument("--boosting", type=str, default="gbdt")
parser.add_argument("--num-iterations", type=int, default=16)
parser.add_argument("--num-leaves", type=int, default=31)
parser.add_argument("--num-threads", type=int, default=0)
parser.add_argument("--learning-rate", type=float, default=0.1)
parser.add_argument("--metric", type=str, default="multi_logloss")
parser.add_argument("--seed", type=int, default=42)
parser.add_argument("--verbose", type=int, default=0)
args = parser.parse_args()

seed = 1234
mlflow.log_metric("seed", seed)

# 自動 Logging 機能の開始
mlflow.lightgbm.autolog()


# LightGBM ハイパーパラメータ
num_boost_round = args.num_boost_round

params = {
    "objective": "multiclass",
    "num_class": 2,
    "boosting": args.boosting,
    "num_iterations": args.num_iterations,
    "num_leaves": args.num_leaves,
    "num_threads": args.num_threads,
    "learning_rate": args.learning_rate,
    "metric": args.metric,
    "seed": args.seed,
    "verbose": args.verbose,
}

# 表形式データセット (Dataset) の読み込み
dataset = run.input_datasets["titanic"]
df = dataset.to_pandas_dataframe()

# データ前処理
categorical_cols = ["Name", "Sex", "Ticket", "Cabin", "Embarked"]
float_cols = ["Pclass", "Age", "SibSp", "Parch", "Fare"]
X_train, X_test, y_train, y_test, enc, categorical_cols = preprocess_data(
    df, categorical_cols, float_cols
)

# モデル学習
model, train_time = train_model(
    params, num_boost_round, X_train, X_test, y_train, y_test, categorical_cols
)
mlflow.log_metric("training_time", train_time)

# モデル評価
loss, acc = evaluate_model(model, X_test, y_test)
mlflow.log_metrics({"loss": loss, "accuracy": acc})

print("\n\n")
print("*" * 60)
