# Final Working Solution: Endometriosis Digital Twin (FedPINN + Kubernetes + Explainable 3D Uterus)

Last verified: **February 24, 2026**

This guide now reflects the **implemented and tested** solution in this workspace.

## 1) What is working right now

## Backend
Implemented and wired in `../software/Backend`:

- `POST /endo/train`
- `POST /endo/predict`
- `POST /endo/state`
- `GET /endo/model/status`
- `GET /endo/explain/<case_id>`
- `GET /endo/validation/report`

Legacy IoT routes are still kept (migration-safe).

## Frontend
Implemented and wired in `../software/Frontend/dt_frontend`:

- `/train-model` calls `POST /endo/train`
- `/predictions` calls `POST /endo/predict` and `POST /endo/state`
- 3D uterus twin visualization is active on `/predictions`

## Infra + scaffolding
Added:

- Backend module structure for multimodal/federated/PINN/XAI/validation under `../software/Backend/src`
- Kubernetes production blueprint templates under `../software/k8s`
- Configs under `../software/Backend/configs`
- Output folders under `../software/Backend/outputs`

## 2) Final run steps (copy-paste)

## Step 1 - Start backend
Run from project root (`datasets-20260212T143122Z-1-001`):

```powershell
.\.venv\Scripts\python.exe .\software\Backend\main_backend.py
```

Keep this terminal open.

## Step 2 - Run endometriosis smoke test
In a second terminal from `datasets` folder:

```powershell
powershell -ExecutionPolicy Bypass -File "..\Solution guide\scripts\endo_smoke_test.ps1"
```

Expected: all checks `PASS`.

## Step 3 - Start frontend
In a third terminal:

```powershell
cd ..\software\Frontend\dt_frontend
npm start
```

Open:

- `http://localhost:3000/train-model`
- `http://localhost:3000/predictions`

## 3) Verified API commands (manual)

```powershell
Invoke-RestMethod http://localhost:5000/endo/model/status
Invoke-RestMethod -Method Post http://localhost:5000/endo/train -ContentType 'application/json' -Body '{"module":"tabular","random_seed":42}'
Invoke-RestMethod -Method Post http://localhost:5000/endo/predict -ContentType 'application/json' -Body '{"age":31,"menstrual_irregularity":1,"chronic_pain_level":7,"hormone_level_abnormality":1,"infertility":0,"bmi":27.1}'
Invoke-RestMethod -Method Post http://localhost:5000/endo/state -ContentType 'application/json' -Body '{"tabular_input":{"age":31,"menstrual_irregularity":1,"chronic_pain_level":7,"hormone_level_abnormality":1,"infertility":0,"bmi":27.1},"imaging_features":{"lesion_burden_index":0.28},"stress_index":0.33}'
Invoke-RestMethod http://localhost:5000/endo/validation/report
```

## 4) Verified result snapshot (this workspace)

Observed on **February 24, 2026**:

- `train.status = ok`
- `roc_auc = 0.6575`
- `pr_auc = 0.5495`
- `brier = 0.2321`
- `predict.risk_score = 0.678`
- `predict.risk_band = high`
- `state.patient_state.risk_score = 0.7225`
- validation report returned with metrics

## 5) Files that implement this solution

## Backend core
- `../software/Backend/main_backend.py`
- `../software/Backend/src/api/endo/routes.py`
- `../software/Backend/src/api/endo/service.py`
- `../software/Backend/src/data/schema.py`
- `../software/Backend/src/data/tabular_loader.py`
- `../software/Backend/src/models/fedpinn.py`
- `../software/Backend/src/federated/flower_adapter.py`
- `../software/Backend/src/xai/explain.py`
- `../software/Backend/src/validation/clinical.py`

## Frontend core
- `../software/Frontend/dt_frontend/src/TrainModel.js`
- `../software/Frontend/dt_frontend/src/Predictions.js`
- `../software/Frontend/dt_frontend/src/endo/api/client.js`
- `../software/Frontend/dt_frontend/src/endo/api/endpoints.js`
- `../software/Frontend/dt_frontend/src/endo/state/riskUtils.js`
- `../software/Frontend/dt_frontend/src/endo/three/UterusTwin.js`

## Infra/config
- `../software/k8s/base/*.yaml`
- `../software/k8s/api/*.yaml`
- `../software/k8s/trainer/deployment.yaml`
- `../software/k8s/federated/deployment.yaml`
- `../software/k8s/monitoring/service-monitoring.yaml`
- `../software/Backend/configs/train.yaml`
- `../software/Backend/configs/federated.yaml`
- `../software/Backend/configs/pinn.yaml`
- `../software/Backend/configs/k8s.yaml`

## Validation script
- `../Solution guide/scripts/endo_smoke_test.ps1`

## 6) Mapping to your requested tasks

## Task 1: Feed-forward network for weight computation in Kubernetes
- Implemented interface and scaffold in `src/models/fedpinn.py` (`WeightNet`).
- Kubernetes deployment blueprint added under `../software/k8s`.

## Task 2: Adaptive FedPINN for distributed prediction
- Adaptive strategy scaffold added in `src/federated/flower_adapter.py`.
- FedPINN interfaces and loss defined in `src/models/fedpinn.py`.

## Task 3: Digital twin framework + XAI + clinical validation
- End-to-end app flow wired with `/endo/*` APIs and frontend integration.
- Local XAI output (`top_features`) returned in `/endo/predict`.
- Clinical metrics/report generated and exposed through `/endo/validation/report`.
- 3D uterus twin view integrated in frontend `/predictions`.

## 7) Remaining work for full research-grade completion

1. Replace current tabular baseline trainer with true multimodal training pipeline.
2. Replace federated scaffold with full Flower server-client orchestration and real round training.
3. Add real physics residual computation tied to clinical/biological constraints.
4. Add subgroup and decision-curve validation in final clinical report.
5. Replace procedural uterus mesh with clinical mesh/segmentation-based geometry (`.glb` + overlays).

## 8) Definition of done for this stage

- [x] New `/endo/*` API contract implemented and reachable
- [x] Train/predict/state flow working
- [x] Frontend train and prediction pages wired to real backend
- [x] 3D uterus digital twin rendering active
- [x] Endometriosis smoke test script passes
- [x] Steps documented as final working runbook