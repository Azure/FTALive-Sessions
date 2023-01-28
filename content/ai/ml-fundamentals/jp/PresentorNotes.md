## セッション事前準備

### 事前にブラウザで開いておくもの
- [ ] 教材の GitHub の [README.md](./README.md)
- [ ] [Azure Portal](https://portal.azure.com/?feature.customportal=false#create/hub) リソース作成画面
- [ ] Azure Portal における Azure Machine Learning が含まれるリソースグループ画面
- [ ] [Azure Machine Learning Studio](ml.azure.com) トップページ

### 起動しておくアプリケーション
- [ ] [パワーポイントスライド](./FTA-Live-AzureML-Fundamental.pdf)
- [ ] Microsoft Teams
- [ ] Azure ML Compute Instance に接続された VSCode デモ環境


<br/>

## コンテンツ作成 Tips
### Jupyter Notebooks を Markdown Files に変換

```bash
jupyter nbconvert --to markdown train-notebook.ipynb
jupyter nbconvert --to markdown deploy-notebook.ipynb
```