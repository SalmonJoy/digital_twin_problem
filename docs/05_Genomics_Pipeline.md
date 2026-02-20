# Genomics Pipeline (Biomarker / Module Scoring)

This workspace contains:

- A small gene expression table (`Data.txt`) with control/eutopic/ectopic groups and DeltaCT fields.
- A WGCNA workbook with gene-to-module mappings and module connectivity/membership values.

## 1) Expression dataset (Dataset-2)

File: `genomic data/Dataset-2/nb737txvr5-1/Data.txt`

### Step 1 - Parse and clean

- Read tab-separated table
- Normalize column names (remove special characters like `?CT` if needed)
- Ensure gene symbols are unique

### Step 2 - Choose an expression scale

Ct and DeltaCT can be converted to relative expression (common choice):

- `expr = 2 ** (-DeltaCt)`

Keep both Ct and derived expression for comparison.

### Step 3 - Baseline analyses

- Differential expression: ectopic vs eutopic vs control (t-test/ANOVA as appropriate)
- Multiple testing correction (Benjamini-Hochberg)

### Step 4 - Build a simple classifier

Targets you can try:

- Control vs Ectopic
- Eutopic vs Ectopic
- 3-way: Control/Eutopic/Ectopic

Models:

- logistic regression (L2)
- random forest

## 2) WGCNA workbook (Dataset-1)

File: `genomic data/Dataset-1/Data_Sheet_4_Weighted Gene Co-expression Network Analysis of Endometriosis and Identification of Functional Modules Associated With Its Main Hallmarks.xlsx`

Sheets:

- `Modules`: gene -> module mapping + sizes/colors
- `kME`, `kIM`: per-gene membership/connectivity for Normal/Severe/Mild

### Step 1 - Build module-level features

For a given sample:

- compute mean expression per module (using `Modules` mapping)
- or compute a weighted score using `kME` values (module membership)

### Step 2 - Use module scores in models

Module-level features can reduce dimensionality and improve stability.

## 3) Testing checklist

- Schema tests: expected columns exist; row counts reasonable.
- Gene symbol consistency between datasets (expression vs WGCNA mapping).
- Reproducibility: fixed random seeds in modeling.

