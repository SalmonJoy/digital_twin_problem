# Software Testing Playbook

Use this checklist each time you change backend/frontend code.

## 1) Pre-flight

1. Backend running at `http://localhost:5000`.
2. Frontend running at `http://localhost:3000`.
3. Browser console open for JS errors.
4. Backend terminal open for Flask errors.

## 2) Backend API sequence test

Run in PowerShell:

```powershell
Invoke-RestMethod http://localhost:5000/
Invoke-RestMethod http://localhost:5000/start_iot
Start-Sleep -Seconds 8
$anom = Invoke-RestMethod http://localhost:5000/sensor/anomalies
$hist = Invoke-RestMethod "http://localhost:5000/get_historical_data?num_data=15"
Invoke-RestMethod -Method Post http://localhost:5000/train
$pred = Invoke-RestMethod http://localhost:5000/predict
Invoke-RestMethod http://localhost:5000/stop_iot
```

Validate:

- `$anom.sensor_data` contains numeric sensor values.
- `$hist.Count` is greater than 0.
- `$pred` includes predicted latitude/longitude/altitude fields.

## 3) Frontend route checks

Open and verify:

1. `/live-monitoring`
2. `/historical-data`
3. `/sensor-graph`
4. `/predictions`
5. `/train-model`

Pass criteria:

- Pages render without crash.
- Live monitoring starts/stops data collection.
- Historical data page loads charts after fetch.
- Sensor graph updates over time.

## 4) Regression checks after backend changes

1. `/sensor/anomalies` response shape remains stable.
2. `/get_historical_data` supports `num_data` query parameter.
3. `/train` still works before `/predict`.
4. CORS remains enabled for frontend origin.

## 5) Endometriosis module checks (future integration)

When new endpoints are added:

1. Add API contract checks for `/endo/*` routes.
2. Validate model input schema and missing-value behavior.
3. Assert calibrated risk outputs and threshold decisions.
4. Verify frontend components display true model outputs, not placeholders.

## 6) Results logging

For each test run, store:

- timestamp
- git commit hash (if available)
- API responses summary
- screenshots for critical UI pages
- metrics file in `outputs/`
