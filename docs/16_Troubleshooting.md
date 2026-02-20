# Troubleshooting Guide

## 1) Python command not found

Symptom:

- `python` is not recognized.

Fix:

1. Install Python 3.9 to 3.11.
2. Reopen terminal.
3. Verify with `python --version`.
4. Re-run `scripts/setup_backend.ps1`.

## 2) Backend venv is broken

Symptom:

- Existing `venv_for_backend` fails with missing interpreter path.

Fix:

1. Ignore checked-in `venv_for_backend`.
2. Create fresh `.venv` via script.

## 3) Port 5000 already in use

Symptom:

- Flask fails to bind `5000`.

Fix:

1. Stop conflicting process.
2. Or run backend on different port and update frontend API base URL.

## 4) Port 3000 already in use

Symptom:

- React start prompts to use another port.

Fix:

1. Accept alternate port or stop process on 3000.
2. Keep backend URL unchanged unless needed.

## 5) CORS errors in browser

Symptom:

- Browser blocks frontend calls to backend.

Fix:

1. Ensure backend starts with CORS enabled.
2. Confirm calls use `http://localhost:5000`.

## 6) /predict returns model not trained

Symptom:

- API says model not trained yet.

Fix:

1. Call `POST /train` first.
2. Retry `/predict`.

## 7) /sensor/anomalies returns no data

Symptom:

- API returns no rows in DB.

Fix:

1. Call `/start_iot`.
2. Wait 5 to 10 seconds.
3. Call `/sensor/anomalies` again.

## 8) npm install fails

Symptom:

- Dependency conflict or network issue.

Fix:

1. Ensure Node 18+ and npm 9+.
2. Remove `node_modules` and reinstall.
3. Retry with `npm install --legacy-peer-deps` if needed.

## 9) Docker compose fails

Symptom:

- Container build or startup errors.

Fix:

1. Check Docker Desktop is running.
2. Run from `../software`.
3. Rebuild with `docker compose up --build`.

## 10) Dataset path errors

Symptom:

- Scripts cannot locate dataset files.

Fix:

1. Confirm project folder layout remains unchanged.
2. Use absolute paths in configs when needed.
