# Problem Definition (What "Solve It" Means)

You can't build a meaningful digital twin without a clear, testable problem definition. This file helps you lock the scope and metrics before coding.

## 1) Suggested MVP problem statement

Build a **modular Endometriosis Digital Twin** that can:

1. Estimate **endometriosis risk** from structured clinical features (tabular MVP).
2. Extract **imaging lesion burden features** from laparoscopic frames (segmentation MVP).
3. Produce **molecular biomarker scores** from gene expression/module information (genomics MVP).
4. Provide a **patient state summary** and basic "what-if" simulation (integration MVP).

## 2) Inputs and outputs (canonical)

### Inputs (optional per case)

- Tabular: age, menstrual irregularity, pain, hormone abnormality, infertility, BMI
- Imaging: frames (and/or MRI if later added)
- Genomics: gene expression (Ct/DeltaCt), module assignments
- Labs/pathology: CA125, blood counts, coagulation markers, stage if available
- Wearables: physiology signals (stress index)

### Outputs

- `risk_score`: probability of endometriosis (with calibration)
- `explanations`: feature contributions (tabular), salient regions (imaging), top genes/modules (genomics)
- `patient_state`: unified representation (see `08_Integration_Digital_Twin.md`)
- `what_if`: scenario results (e.g., change BMI -> risk delta)

## 3) Module-level tasks and metrics

### Tabular module (Dataset-9)

- Task: binary classification `Diagnosis`
- Metrics: ROC-AUC, PR-AUC, F1, calibration (Brier), sensitivity at chosen specificity

### Imaging module (GLENDA)

- Task: multi-class segmentation (background + 4 lesion types)
- Metrics: Dice and IoU per class, mean Dice, qualitative overlays
- Data split rule: split by **video** (avoid frame leakage) if possible

### Genomics module (Dataset-2 + WGCNA)

- Task ideas:
  - classify control vs eutopic vs ectopic (or ectopic vs others)
  - compute biomarker/module risk scores
- Metrics: ROC-AUC; stability of selected biomarkers across resampling

### Labs/pathology module (Dataset-6)

- Task: predict group/stage (depending on label quality)
- Metrics: ROC-AUC / macro-F1; sanity checks on distributions

### Wearables module (WESAD)

- Task: classify baseline/stress/amusement/meditation labels
- Metrics: subject-wise CV accuracy/F1; generalization to held-out subjects
- Note: use this as a **generic stress module**, not endometriosis prediction

## 4) MVP acceptance criteria (example)

- Tabular: ROC-AUC >= 0.80 on held-out test with reproducible training.
- Imaging: mean Dice >= 0.60 on held-out videos + believable overlays.
- Integration: a single command/notebook reproduces metrics + writes `outputs/report.md`.

Adjust these thresholds based on feasibility and stakeholder expectations.


