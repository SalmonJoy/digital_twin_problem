# Data to Module Mapping

Use this table to avoid ambiguity about what each dataset contributes.

| Dataset | Local Path | Module | Baseline Task | Initial Model | Backend Output | Frontend Target |
|---|---|---|---|---|---|---|
| Structured endometriosis tabular | `../datasets/patient Records/Dataset-9/structured_endometriosis_data.csv` | Tabular risk | Binary classification (`Diagnosis`) | Logistic Regression + Gradient Boosting | `/endo/predict` risk payload | Train + prediction cards |
| Psychological wellbeing | `../datasets/patient Records/Dataset-7/...csv` | Psych context | Score aggregation and subgroup analysis | Rule-based + regression | optional psych score in `/endo/state` | profile/context panel |
| ONS characteristics | `../datasets/patient Records/Dataset-8/...xlsx` | Population priors | Cohort calibration checks | descriptive stats | calibration metadata | report section only |
| GLENDA imaging | `../datasets/medical imaging/Dataset-4/Glenda_v1.5_classes` | Imaging | Multiclass segmentation | U-Net baseline | lesion burden features to `/endo/state` | imaging summary panel |
| EndoTect/Kvasir style | `../datasets/medical imaging/Dataset-3/EndoTect` | Imaging pipeline validation | Segmentation pipeline shakedown | U-Net/DeepLab | dev-only metrics | dev/testing only |
| Uterus Roboflow COCO | `../datasets/medical imaging/Dataset-5/Uterus.v3i.coco` | Imaging localization | Object detection sanity checks | Faster R-CNN (optional) | optional uterus localization | optional visualization |
| Gene expression | `../datasets/genomic data/Dataset-2/nb737txvr5-1/Data.txt` | Genomics | Biomarker scoring | L1 Logistic / Random Forest | genomics score to `/endo/state` | genomics panel |
| WGCNA modules | `../datasets/genomic data/Dataset-1/...xlsx` | Genomics | Module-level feature extraction | module score model | module signatures | genomics panel |
| Microbiome/labs | `../datasets/pathology reports/Dataset-6/...xlsx` | Labs/pathology | Group/stage proxy prediction | XGBoost/LightGBM | lab risk features | labs panel |
| WESAD wearables | `../datasets/sensor data/Dataset-10/WESAD` | Stress context | Stress state classification | RF / simple deep model | `stress_index` to `/endo/state` | context factor panel |

## Notes

1. Not all datasets are patient-linked; modular fusion is required.
2. Start with tabular module for first end-to-end success.
3. Add imaging/genomics/labs modules incrementally after API contract is stable.
