# Data Inventory (What You Have + What It's Good For)

This document summarizes what's in the dataset workspace, including **schemas, sizes, and caveats**.

## 1) High-level map (by modality)

### Tabular / patient records

- `patient Records/Dataset-9/structured_endometriosis_data.csv`
  - Rows: 10,000
  - Columns: `Age`, `Menstrual_Irregularity`, `Chronic_Pain_Level`, `Hormone_Level_Abnormality`, `Infertility`, `BMI`, `Diagnosis`
  - Label distribution: `Diagnosis=1` is ~40.79% (4,079 / 10,000)
  - Best use: MVP **risk classifier** + what-if simulation on structured factors

- `patient Records/Dataset-7/Psychological Wellbeing and Endometriosis and Adenomyosis.csv`
  - Rows: 115 (113 non-empty ages)
  - Columns: 56 (questionnaire blocks + Depression/Anxiety/Stress scores)
  - Best use: add **mental health dimension** to the twin (not a clean diagnostic label)

- `patient Records/Dataset-8/Characteristics of women with an endometriosis diagnosis.xlsx`
  - 17 sheets (Tables 1-14 + cover/notes/contents)
  - Best use: population-level **priors**, calibration checks, and "does the twin behave plausibly?"

### Pathology / labs

- `pathology reports/Dataset-6/Table_1_Gut Microbiota Exceeds Cervical Microbiota for Early Diagnosis of Endometriosis.xlsx`
  - Rows: 1,000 including header (999 data rows)
  - Columns: 32 (includes EM stage, CA125, WBC diff, DDI, fibrinogen, NLR, etc.)
  - Best use: lab-feature risk signals, stage-related modeling (if group labels are usable)

### Imaging

- GLENDA: `medical imaging/Dataset-4/Glenda_v1.5_classes`
  - `frames/` images and `annots/` masks + `coco.json`
  - COCO: 373 images, 628 annotations
  - Classes (from `labels.txt`): Peritoneum, Ovar, TIE, Uterus (+ background)
  - Best use: multi-class segmentation + lesion burden feature extraction

- Roboflow Uterus: `medical imaging/Dataset-5/Uterus.v3i.coco`
  - 24 images; COCO annotations present but appear to be **Uterus bounding boxes only**
  - Best use: uterus localization or a tiny sanity-check dataset

- EndoTect/Kvasir-SEG style: `medical imaging/Dataset-3/EndoTect`
  - Training: 1,000 images + masks + bbox CSV
  - Test: 200 images + masks + bbox CSV
  - BBox CSV schema: `class_name,xmin,ymin,xmax,ymax` (observed `class_name=polyp`)
  - Best use: segmentation pipeline validation / transfer learning (not endometriosis-specific)

### Genomics

- Expression table: `genomic data/Dataset-2/nb737txvr5-1/Data.txt`
  - 96 genes; 19 columns total (gene + 18 measurements/DeltaCT columns)
  - Best use: biomarker scoring and small-scale classification experiments

- WGCNA workbook: `genomic data/Dataset-1/Data_Sheet_4_Weighted Gene Co-expression Network Analysis of Endometriosis and Identification of Functional Modules Associated With Its Main Hallmarks.xlsx`
  - Sheets: `Modules` (10,130 rows), `kME` (3,859 rows), `kIM` (3,859 rows)
  - Best use: module-level features and gene-to-module mapping

### Sensors (wearables)

- WESAD: `sensor data/Dataset-10/WESAD`
  - Readme defines structure and label IDs in `sensor data/Dataset-10/WESAD/wesad_readme.pdf`
  - Caveat: in this snapshot, most subjects have only `*_readme.txt` and `*_quest.csv`; raw signals present only for some subjects (see `07_Sensors_WESAD.md`).

## 2) Cross-modal integration caveat (important)

These datasets are not linked by patient ID. Plan for:

- **Modular twin**: each modality model runs independently when data is available.
- **Late fusion**: combine module outputs (risk scores, lesion burden, biomarker indices).
- Avoid claiming "multimodal patient-level training" unless you later curate linked patients.

## 3) Data handling rules

- Treat raw dataset folders as **immutable**.
- Write all derived artifacts to `outputs/` (models, plots, reports) and optionally `data/processed/`.
- Track provenance: which raw file(s) produced which processed artifact.


