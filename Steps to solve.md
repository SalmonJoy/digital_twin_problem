# Steps to Solve: Final Working Implementation (Adaptive FedPINN + 3D Uterus Twin)

Last verified: **February 24, 2026**

This runbook reflects the current code exactly as implemented and tested.

## 1) What Is Implemented Now

Previously pending items are now implemented in code:

- [x] true multimodal fused training in production flow
- [x] full Flower distributed rounds wired end-to-end
- [x] expanded clinical-grade subgroup and decision analyses
- [x] clinical mesh/segmentation-grade 3D asset integration

## 2) Key Paths

Workspace root:
`C:\Users\salmo\Downloads\datasets-20260212T143122Z-1-001`

Main components:
- Backend: `software/Backend`
- Frontend: `software/Frontend/dt_frontend`
- Repro smoke script: `Solution guide/scripts/endo_smoke_test.ps1`

## 3) One-Time Setup

From workspace root:

```powershell
cd C:\Users\salmo\Downloads\datasets-20260212T143122Z-1-001
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r .\software\Backend\requirements.txt
cd .\software\Frontend\dt_frontend
npm install
```

If `.venv` and `node_modules` already exist, skip reinstallation.

## 4) Start Backend

Open Terminal A:

```powershell
cd C:\Users\salmo\Downloads\datasets-20260212T143122Z-1-001
.\.venv\Scripts\python.exe .\software\Backend\main_backend.py
```

Backend runs at `http://localhost:5000`.

## 5) Run Full Smoke Test (Exact Validation)

Open Terminal B:

```powershell
cd C:\Users\salmo\Downloads\datasets-20260212T143122Z-1-001
powershell -ExecutionPolicy Bypass -File ".\Solution guide\scripts\endo_smoke_test.ps1"
```

Expected checks:
- Backend health
- Model status endpoint
- Train endpoint (multimodal + Flower)
- Predict endpoint
- State endpoint (lesion segments + mesh field)
- Validation report endpoint (subgroups + decision curve + thresholds + release gate)

Latest verified output pattern:

```text
Train endpoint             PASS   roc_auc=0.506, fed=ok
Predict endpoint           PASS   risk_score=0.4018, band=moderate
State endpoint             PASS   state_risk=0.4904, segments=4
Validation report endpoint PASS   validation report with subgroup and decision analysis
```

## 6) Start Frontend

Open Terminal C:

```powershell
cd C:\Users\salmo\Downloads\datasets-20260212T143122Z-1-001\software\Frontend\dt_frontend
npm start
```

Open:
- `http://localhost:3000/train-model`
- `http://localhost:3000/predictions`

## 7) How To Reproduce Final Result In UI

1. Go to `/train-model`.
2. Click `Train /endo/train`.
3. Confirm metrics and federated summary appear.
4. Go to `/predictions`.
5. Keep default tabular and modality values (or edit).
6. Click `Predict /endo/predict`.
7. Confirm output includes:
- risk score
- risk band
- uncertainty
- top feature contributions
- modality weights
- 3D uterus state update
- lesion segment count and segmentation source

## 8) Exact API Contracts In Use

### Train
`POST /endo/train`

Default payload used by UI and smoke test:

```json
{
  "module": "multimodal_fedpinn",
  "random_seed": 42,
  "epochs": 6,
  "federated": true,
  "federated_rounds": 2,
  "federated_clients": 3,
  "federated_local_epochs": 1
}
```

### Predict
`POST /endo/predict`

```json
{
  "tabular_input": {
    "age": 31,
    "menstrual_irregularity": 1,
    "chronic_pain_level": 7,
    "hormone_level_abnormality": 1,
    "infertility": 0,
    "bmi": 27.1
  },
  "imaging_features": {
    "lesion_burden_index": 0.28,
    "lesion_count": 3,
    "tie_probability": 0.42
  },
  "genomics_features": {
    "module_score": 0.52,
    "ectopic_signal": 0.49,
    "inflammation_gene": 0.46
  },
  "labs_features": {
    "ca125_norm": 0.54,
    "nlr_proxy": 0.43,
    "fibrinogen_proxy": 0.45
  },
  "stress_index": 0.33
}
```

### State
`POST /endo/state`
- Uses same payload as `/endo/predict`.
- Returns `patient_state.mesh_asset`, `patient_state.lesion_segments`, module confidence, and blended risk.
- Current default is `mesh_asset = ""` (procedural uterus fallback).

### Explainability + Validation
- `GET /endo/explain/:case_id`
- `GET /endo/validation/report`

## 9) Output Artifacts Generated

After training:

- `software/Backend/outputs/models/multimodal_fedpinn.pt`
- `software/Backend/outputs/models/multimodal_fedpinn_meta.json`
- `software/Backend/outputs/metrics/metrics.json`
- `software/Backend/outputs/metrics/weight_stats.json`
- `software/Backend/outputs/metrics/federated_rounds.json`
- `software/Backend/outputs/clinical/validation_report.json`

## 10) Where Each Task Is Implemented

### Task 1: Feed-forward weight computation for multimodal data
- `software/Backend/src/models/fedpinn.py`
- `software/Backend/src/models/multimodal_fusion.py`
- `software/Backend/src/data/multimodal_builder.py`

### Task 2: Adaptive FedPINN for distributed systems
- `software/Backend/src/federated/flower_rounds.py`
- `software/Backend/src/api/endo/service.py`

### Task 3: Digital Twin + explainability + clinical validation
- Backend state and explainability: `software/Backend/src/api/endo/service.py`
- Clinical validation pipeline: `software/Backend/src/validation/clinical.py`
- Prediction UI + 3D rendering: `software/Frontend/dt_frontend/src/Predictions.js`
- Mesh and lesion overlays: `software/Frontend/dt_frontend/src/endo/three/UterusTwin.js`

## 11) 3D Mesh Note

The renderer currently runs in procedural uterus mode by default via:
- `patient_state.mesh_asset = ""`

Mesh mode is supported and can be enabled via:
- `patient_state.mesh_asset = "/model/uterus_clinical.glb"`
- `patient_state.lesion_segments = [...]`

Current mesh file path:
- `software/Frontend/dt_frontend/public/model/uterus_clinical.glb`

For real clinical deployment, replace this file with a validated uterus mesh/segmentation asset while keeping the same path.
## 12) Known Non-Blocking Warnings

Frontend build/dev may still show:
- `@mediapipe/tasks-vision` missing sourcemap warning
- CRA deprecation warnings
- Browserslist age warning

These do not block runtime or smoke test pass.

## 13) Final Status

Working now:
- [x] Backend `/endo/*` train/predict/state/explain/validation
- [x] Multimodal fusion with WeightNet and FedPINN objective
- [x] Flower rounds executed and logged
- [x] Clinical validation report with subgroup and decision analyses
- [x] 3D uterus twin driven by API state + lesion segments (procedural fallback enabled by default; mesh mode supported)
- [x] Reproducible smoke test passing
