# Project Setup (Environment + Structure)

This project now has two parts:

- `datasets/` for raw datasets and analysis docs
- `../software/` for the runnable backend/frontend application

Set up both sides before development.

## 0) Required tools

- OS: Windows 10/11 (PowerShell)
- Python: 3.9 to 3.11 (backend dependencies are older; 3.9 is safest)
- Node.js: 18+ (20.x works)
- npm: 9+
- Git (optional but recommended)

## 1) Folder structure you should use

- Dataset root (this workspace): `.`
- Software root: `..\software`
- Backend app: `..\software\Backend`
- Frontend app: `..\software\Frontend\dt_frontend`

Treat raw data folders as read-only.

## 2) Backend setup

```powershell
cd ..\software\Backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt
python main_backend.py
```

Expected backend URL: `http://localhost:5000`.

Notes:

- The committed `venv_for_backend` is not portable. Recreate `.venv` locally.
- Backend code uses SQLite (`sqlite:///sensor_data.db`) by default.

## 3) Frontend setup

```powershell
cd ..\software\Frontend\dt_frontend
npm install
npm start
```

Expected frontend URL: `http://localhost:3000`.

## 4) Optional Docker setup

From `..\software`:

```powershell
docker compose up --build
```

This starts:

- backend on `5000`
- frontend on `3000`
- mysql on `3307`

## 5) Quick health checks

```powershell
Invoke-RestMethod http://localhost:5000/
Invoke-RestMethod http://localhost:5000/start_iot
Start-Sleep -Seconds 6
Invoke-RestMethod http://localhost:5000/sensor/anomalies
Invoke-RestMethod http://localhost:5000/stop_iot
```

If the frontend is up, open `http://localhost:3000` and navigate to:

- `Live Monitoring`
- `Historical Data`
- `Sensor Graph`

## 6) Reproducibility checklist

- Pin backend packages in a clean `.venv` (not the committed venv).
- Record Node and npm versions for frontend.
- Save run logs and output metrics under a versioned `outputs/` folder.
- Keep per-experiment config files (seed, data paths, hyperparameters).
