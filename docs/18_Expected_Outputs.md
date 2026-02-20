# Expected Outputs and Templates

This document defines expected artifacts for reproducible delivery.

## 1) Required output structure

```text
outputs/
  report.md
  metrics.json
  models/
    tabular_model.pkl
  figures/
    roc_curve.png
    calibration_curve.png
  logs/
    smoke_test_latest.log
```

## 2) Required minimum files

1. `outputs/report.md`
2. `outputs/metrics.json`
3. At least one model artifact in `outputs/models/`
4. At least one figure in `outputs/figures/`

## 3) Templates in this folder

1. `templates/expected_metrics.json`
2. `templates/sample_predict_response.json`
3. `templates/report_template.md`

## 4) Acceptance checks

1. `metrics.json` parses as valid JSON.
2. Key metrics exist (`roc_auc`, `pr_auc`, `brier` for tabular).
3. Report contains dataset paths, model version, and test split details.
4. Output filenames include date or version to avoid overwrite.
