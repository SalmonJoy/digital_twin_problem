# Testing, Validation, and Results

This file defines how to test both the data-science workflow and the current software stack.

## 1) Dataset and model tests

Minimum checks:

- File existence checks for required datasets.
- Schema checks for key CSV/XLSX inputs.
- Row-count sanity checks for major tables.
- Split hygiene (no leakage by frame/video/subject where applicable).
- Fixed seeds for reproducibility.

## 2) Backend API smoke tests

Start backend first, then run:

```powershell
Invoke-RestMethod http://localhost:5000/
Invoke-RestMethod http://localhost:5000/start_iot
Start-Sleep -Seconds 6
Invoke-RestMethod http://localhost:5000/sensor/anomalies
Invoke-RestMethod "http://localhost:5000/get_historical_data?num_data=10"
Invoke-RestMethod http://localhost:5000/stop_iot
Invoke-RestMethod -Method Post http://localhost:5000/train
Invoke-RestMethod http://localhost:5000/predict
```

Expected outcomes:

- `/` returns backend health text.
- `/start_iot` and `/stop_iot` return success messages.
- `/sensor/anomalies` returns `sensor_data`, `anomalies`, `preventive_actions`.
- `/get_historical_data` returns a list of records.
- `/train` reports successful model training.
- `/predict` returns predicted latitude/longitude/altitude after training.

## 3) Frontend validation

Run frontend and check these routes manually:

- `/live-monitoring`
- `/historical-data`
- `/sensor-graph`
- `/predictions`
- `/train-model`

Current behavior caveats:

- `Train Model` is UI-only random accuracy and does not call backend.
- `Predictions` is currently demo visualization with synthetic values.

## 4) Endometriosis-specific acceptance tests (target state)

Once endometriosis modules are integrated, add:

- Tabular risk endpoint checks (`/endo/train`, `/endo/predict`).
- Imaging inference endpoint checks.
- Calibration and threshold-based clinical metrics.
- End-to-end patient state payload validation.

## 5) Results packaging

Store outputs in a reproducible structure:

- `outputs/report.md`
- `outputs/metrics.json`
- `outputs/models/`
- `outputs/figures/`
- `outputs/configs/`

## 6) Done criteria

- `../Solution.md` steps run end-to-end on a fresh machine.
- Backend and frontend smoke tests pass.
- At least one endometriosis baseline model is trained and evaluated.
- Reproducible artifacts and metrics are produced.

