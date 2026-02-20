# Tabular Baseline (Risk Model MVP)

This is the fastest path to an end-to-end working result using:

- `patient Records/Dataset-9/structured_endometriosis_data.csv`

## 1) Goal

Train a **reproducible** binary classifier for `Diagnosis` and expose it as a "risk module" for the twin.

## 2) Step-by-step

### Step 1 - Data sanity checks

- Verify schema (columns + types)
- Check label balance and missingness
- Store a small EDA summary to `outputs/eda_tabular.md`

### Step 2 - Split data

- Use stratified split (train/val/test), e.g. 70/15/15
- Fix a random seed (and record it)

### Step 3 - Baseline models

Start simple and move up only if needed:

1. Logistic regression (with standardization)
2. Random forest / gradient boosting (XGBoost/LightGBM) for non-linearities

### Step 4 - Evaluate

Minimum metrics:

- ROC-AUC + PR-AUC
- Confusion matrix at a chosen threshold
- Calibration: reliability plot + Brier score

### Step 5 - Explain

- Logistic regression: coefficients + standardized features
- Tree models: permutation importance; optional SHAP

### Step 6 - Package the module

Save:

- model artifact (e.g., `outputs/models/tabular_risk_model.pkl`)
- preprocessing object (scaler/imputer)
- a JSON with metrics and config

## 3) Suggested implementation structure

Create (example):

- `src/tabular/train.py` - training entrypoint
- `src/tabular/features.py` - schema + feature transforms
- `src/tabular/eval.py` - evaluation utilities
- `tests/test_tabular_schema.py` - schema tests

## 4) Minimal "notebook first" code sketch (optional)

If you want to validate quickly in a notebook:

```python
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_auc_score

df = pd.read_csv(r"patient Records/Dataset-9/structured_endometriosis_data.csv")
X = df.drop(columns=["Diagnosis"])
y = df["Diagnosis"]

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

model = Pipeline([
    ("scaler", StandardScaler()),
    ("clf", LogisticRegression(max_iter=2000)),
])
model.fit(X_train, y_train)
proba = model.predict_proba(X_test)[:, 1]
print("ROC-AUC:", roc_auc_score(y_test, proba))
```

## 5) Common pitfalls

- Data leakage from scaling before splitting (use pipelines).
- Picking a threshold using test data (choose on val set only).
- Reporting only accuracy (use AUC + calibration).

