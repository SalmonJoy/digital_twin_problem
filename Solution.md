# Endometriosis Digital Twin - End-to-End Solution Guide

This folder is the single source of truth for solving the project.

- Data root: `../datasets`
- Software root: `../software`

Use this file first, then follow linked docs in `docs/`.

## 1) 30-Minute Quickstart

Run from `Solution guide`:

```powershell
# Terminal 1 - backend setup and run
powershell -ExecutionPolicy Bypass -File .\scripts\setup_backend.ps1 -Run
```

```powershell
# Terminal 2 - frontend run
powershell -ExecutionPolicy Bypass -File .\scripts\run_frontend.ps1
```

```powershell
# Terminal 3 - smoke test
powershell -ExecutionPolicy Bypass -File .\scripts\smoke_test.ps1
```

Expected quickstart outcomes:

1. Backend healthy on `http://localhost:5000`.
2. Frontend opens on `http://localhost:3000`.
3. Smoke test ends with all checks `PASS`.

## 2) Golden Path (Single Recommended Path)

1. Complete environment setup (`docs/00_Project_Setup.md`).
2. Validate data assumptions (`docs/01_Data_Inventory.md`, `docs/12_Dataset_Report_Summary.md`).
3. Run current software baseline (`docs/10_Software_Runbook.md`).
4. Pass software smoke tests (`docs/11_Software_Testing_Playbook.md`).
5. Build tabular endometriosis baseline (`docs/03_Tabular_Baseline.md`).
6. Add backend `/endo/*` endpoints (`docs/13_Api_Contract.md`).
7. Wire frontend routes to real endometriosis endpoints (`docs/15_Frontend_Route_To_Endpoint_Map.md`).
8. Package results (`docs/18_Expected_Outputs.md`).

Do not branch into optional modules before Step 5 is stable.

## 3) Milestones and Gates

See full details in `docs/19_Milestones_And_DoD.md`.

- M1: Environment + baseline software running.
- M2: Dataset validation + reproducible baseline model training.
- M3: Endometriosis backend API contract implemented.
- M4: Frontend integrated with backend endometriosis outputs.
- M5: Final report and artifacts packaged.

Each milestone has pass/fail criteria.

## 4) Definition of Done (Summary)

Project is done only when all are true:

1. `scripts/smoke_test.ps1` passes.
2. At least one endometriosis model is trained on project data.
3. `/endo/predict` returns valid payload with confidence and explanation fields.
4. Frontend displays real backend outputs (not placeholders) for the target workflow.
5. Outputs generated in a reproducible structure (`outputs/metrics.json`, `outputs/report.md`, model artifact files).

## 5) Step-by-Step Deep Plan

### Step 0 - Confirm scope and success criteria

Define MVP outputs clearly:

1. Endometriosis risk score from tabular clinical features.
2. Imaging lesion segmentation metrics and lesion burden features.
3. Optional genomics/labs/wearables auxiliary signals.
4. Integrated patient-state output in one orchestrated flow.

Details: `docs/02_Problem_Definition.md`.

### Step 1 - Set up environments

1. Dataset and software setup: `docs/00_Project_Setup.md`.
2. Backend/frontend run details: `docs/10_Software_Runbook.md`.
3. Troubleshooting if blocked: `docs/16_Troubleshooting.md`.

### Step 2 - Understand and validate datasets

1. Data inventory and constraints: `docs/01_Data_Inventory.md`.
2. Source provenance summary: `docs/12_Dataset_Report_Summary.md`.
3. Dataset to module plan: `docs/14_Data_To_Module_Mapping.md`.

### Step 3 - Run baseline system and test

1. Run backend and frontend.
2. Execute API and UI smoke tests.

Details: `docs/11_Software_Testing_Playbook.md`.

### Step 4 - Build endometriosis modules

1. Tabular baseline: `docs/03_Tabular_Baseline.md`.
2. Imaging baseline: `docs/04_Imaging_Pipeline.md`.
3. Genomics baseline: `docs/05_Genomics_Pipeline.md`.
4. Pathology/labs baseline: `docs/06_Pathology_Labs.md`.
5. Wearables stress context: `docs/07_Sensors_WESAD.md`.

### Step 5 - Integrate modules into runtime app

1. Backend endpoint implementation plan: `docs/13_Api_Contract.md`.
2. Frontend wiring plan: `docs/15_Frontend_Route_To_Endpoint_Map.md`.
3. Integration architecture: `docs/08_Integration_Digital_Twin.md`.

### Step 6 - Validate and package final outputs

1. Testing and validation process: `docs/09_Testing_And_Results.md`.
2. Output packaging format and templates: `docs/18_Expected_Outputs.md`.

## 6) Progress Checklist

See full checklist in `docs/20_Execution_Checklist.md`.

- [ ] Backend setup complete.
- [ ] Frontend setup complete.
- [ ] Smoke tests pass.
- [ ] Data validation complete.
- [ ] Endometriosis tabular baseline complete.
- [ ] `/endo/*` endpoints implemented.
- [ ] Frontend integrated with `/endo/*`.
- [ ] Final metrics and report generated.

## 7) Decision Log

Track major decisions and assumptions in `docs/17_Decision_Log.md`.

## 8) Documentation Index

1. `docs/00_Project_Setup.md`
2. `docs/01_Data_Inventory.md`
3. `docs/02_Problem_Definition.md`
4. `docs/03_Tabular_Baseline.md`
5. `docs/04_Imaging_Pipeline.md`
6. `docs/05_Genomics_Pipeline.md`
7. `docs/06_Pathology_Labs.md`
8. `docs/07_Sensors_WESAD.md`
9. `docs/08_Integration_Digital_Twin.md`
10. `docs/09_Testing_And_Results.md`
11. `docs/10_Software_Runbook.md`
12. `docs/11_Software_Testing_Playbook.md`
13. `docs/12_Dataset_Report_Summary.md`
14. `docs/13_Api_Contract.md`
15. `docs/14_Data_To_Module_Mapping.md`
16. `docs/15_Frontend_Route_To_Endpoint_Map.md`
17. `docs/16_Troubleshooting.md`
18. `docs/17_Decision_Log.md`
19. `docs/18_Expected_Outputs.md`
20. `docs/19_Milestones_And_DoD.md`
21. `docs/20_Execution_Checklist.md`

## 9) Script Index

1. `scripts/setup_backend.ps1`
2. `scripts/run_frontend.ps1`
3. `scripts/smoke_test.ps1`

## 10) Template Index

1. `templates/expected_metrics.json`
2. `templates/sample_predict_response.json`
3. `templates/report_template.md`
