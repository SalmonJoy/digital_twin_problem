# Software Runbook (Backend + Frontend)

This runbook is for the actual codebase in `..\software`.

## 1) What is implemented now

Backend (`..\software\Backend\main_backend.py`):

- Generates synthetic IoT sensor data.
- Stores data in SQLite table `iot_sensor_data`.
- Exposes API endpoints:
  - `GET /`
  - `GET /start_iot`
  - `GET /stop_iot`
  - `GET /sensor/anomalies`
  - `GET /get_historical_data?num_data=N`
  - `POST /train`
  - `GET /predict`

Frontend (`..\software\Frontend\dt_frontend`):

- React app with pages for live monitoring, historical data, sensor graph, predictions, and train model UI.
- Calls backend endpoints mostly on `http://localhost:5000`.

## 2) Backend local run

```powershell
cd ..\software\Backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python main_backend.py
```

If `python` is unavailable, install Python first and reopen terminal.

## 3) Frontend local run

```powershell
cd ..\software\Frontend\dt_frontend
npm install
npm start
```

## 4) API quick checks

```powershell
Invoke-RestMethod http://localhost:5000/
Invoke-RestMethod http://localhost:5000/start_iot
Start-Sleep -Seconds 6
Invoke-RestMethod http://localhost:5000/sensor/anomalies
Invoke-RestMethod "http://localhost:5000/get_historical_data?num_data=5"
Invoke-RestMethod -Method Post http://localhost:5000/train
Invoke-RestMethod http://localhost:5000/predict
Invoke-RestMethod http://localhost:5000/stop_iot
```

## 5) Useful backend helper scripts

- Export DB to CSV:

```powershell
cd ..\software\Backend
python export_db_to_csv.py
```

- Train pseudo-supervised CSV model:

```powershell
cd ..\software\Backend
python csv_trainer.py
```

- Train anomaly model from CSV:

```powershell
cd ..\software\Backend\ml
python train_test_model.py
```

## 6) Docker option

```powershell
cd ..\software
docker compose up --build
```

## 7) Current technical gaps vs endometriosis objective

- Backend model logic is IoT-centric, not endometriosis-specific.
- Frontend `Train Model` page is frontend-only simulation.
- Predictions page is synthetic visualization and not wired to `/predict` output.
- No automated tests are present for backend or frontend app logic.

Use this stack as the app shell, then integrate endometriosis modules incrementally.
