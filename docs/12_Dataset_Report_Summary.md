# Dataset Report Summary (PDF)

Source file reviewed:

- `Endometriosis_Datasets_Report.docx(3) (1).pdf`

## 1) Purpose stated in report

The report states the goal is to assemble datasets for an endometriosis digital twin for earlier detection and personalized insights.

## 2) Dataset list captured in report

1. Uterus Computer Vision Dataset (Roboflow) - medical imaging.
2. Psychological Wellbeing and Endometriosis - patient records.
3. GLENDA v1.0 (Gynecologic Datasets) - medical imaging.
4. Endotect 2020 Challenge - medical imaging.
5. Structured Endometriosis Dataset - patient records.
6. Endometriosis Diagnosis Statistics (ONS) - patient records.
7. Gene Expression: Eutopic vs Ectopic Tissues - genomic data.
8. WESAD wearable stress dataset - sensor wearables.
9. WGCNA gene co-expression data - genomic data.
10. Gut vs Cervical Microbiota profiling - pathology report.

## 3) How this maps to your local folders

- Imaging: `medical imaging/Dataset-3`, `medical imaging/Dataset-4`, `medical imaging/Dataset-5`
- Patient records: `patient Records/Dataset-7`, `patient Records/Dataset-8`, `patient Records/Dataset-9`
- Genomics: `genomic data/Dataset-1`, `genomic data/Dataset-2`
- Pathology/labs: `pathology reports/Dataset-6`
- Wearables: `sensor data/Dataset-10/WESAD`

## 4) Important caveat for implementation

The report aggregates useful datasets, but they are not linked by shared patient IDs in this workspace. The correct implementation approach remains modular fusion unless linked multimodal cohorts are curated.

## 5) Recommended use in your workflow

1. Treat this PDF as a provenance and source index.
2. Use `01_Data_Inventory.md` for local-file-level truth.
3. Use `../Solution.md` + `10_Software_Runbook.md` and `11_Software_Testing_Playbook.md` for executable project steps.

