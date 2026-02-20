# Pathology / Labs Module (Structured Clinical Table)

Dataset file:

- `pathology reports/Dataset-6/Table_1_Gut Microbiota Exceeds Cervical Microbiota for Early Diagnosis of Endometriosis.xlsx`

## 1) Goal

Use lab and clinical variables (e.g., CA125, WBC differential, coagulation markers) to produce a **lab-based risk/stage signal** that can feed the digital twin.

## 2) Step-by-step

### Step 1 - Extract the table

- Export sheet1 to CSV (or read with a Python Excel reader)
- Verify:
  - 32 columns
  - ~999 data rows

### Step 2 - Define the prediction target

The file includes a `Group` column and `EM stage`. Decide:

- classification: group label (case/control) if labels are clean
- ordinal regression: stage (if meaningful and sufficiently populated)

### Step 3 - Preprocess

- Parse dates (`Date_in`) if needed
- Convert percentages to numeric
- Handle missing values and outliers

### Step 4 - Baseline models

- logistic regression (with standardization)
- gradient boosting (often strong for lab tables)

### Step 5 - Evaluate

- ROC-AUC / macro-F1 (classification)
- confusion matrix per stage (stage task)
- calibration (very important for clinical use)

## 3) Testing checklist

- Column type checks (numeric where expected)
- Reasonable value ranges (e.g., BMI > 10 and < 80)

