# API Contract and Payloads

This document defines current and target backend API contracts.

Base URL: `http://localhost:5000`

## 1) Current Endpoints (Implemented)

### GET /

Purpose: health check.

Success response (text):

```text
Backend is running!
```

### GET /start_iot

Purpose: start synthetic IoT data collection loop.

Success response:

```json
{ "message": "IoT sensor data collection started!" }
```

### GET /stop_iot

Purpose: stop synthetic IoT data collection loop.

Success response:

```json
{ "message": "IoT sensor data collection stopped!" }
```

### GET /sensor/anomalies

Purpose: latest sensor sample + anomaly labels + preventive actions.

Success response shape:

```json
{
  "sensor_data": {
    "acceleration": 0.0,
    "temperature": 0.0,
    "pressure": 0.0,
    "fuel_flow": 0.0,
    "oxygen_level": 0.0,
    "humidity": 0.0,
    "strain": 0.0,
    "co2_emission": 0.0,
    "air_flowrate": 0.0,
    "load": 0.0,
    "latitude": 0.0,
    "longitude": 0.0,
    "altitude": 0.0
  },
  "anomalies": ["High anomaly detected in temperature: 58.2"],
  "preventive_actions": ["Inspect the temperature sensor for overheating or malfunction."]
}
```

### GET /get_historical_data?num_data=N

Purpose: fetch latest N sensor records.

Success response shape:

```json
[
  {
    "timestamp": "2026-02-20T12:00:00",
    "acceleration": 0.0,
    "temperature": 0.0,
    "pressure": 0.0,
    "fuel_flow": 0.0,
    "oxygen_level": 0.0,
    "humidity": 0.0,
    "strain": 0.0,
    "co2_emission": 0.0,
    "air_flowrate": 0.0,
    "load": 0.0,
    "latitude": 0.0,
    "longitude": 0.0,
    "altitude": 0.0
  }
]
```

### POST /train

Purpose: train random forest position regressor.

Success response:

```json
{ "message": "Random Forest model trained successfully!" }
```

### GET /predict

Purpose: return fused ML + physics position prediction.

Success response shape:

```json
{
  "predicted_latitude": 0.0,
  "predicted_longitude": 0.0,
  "predicted_altitude": 0.0
}
```

## 2) Target Endometriosis Endpoints (To Implement)

### POST /endo/train

Purpose: train endometriosis model(s).

Request body:

```json
{
  "module": "tabular",
  "dataset_path": "..\\datasets\\patient Records\\Dataset-9\\structured_endometriosis_data.csv",
  "target": "Diagnosis",
  "random_seed": 42
}
```

Success response:

```json
{
  "status": "ok",
  "module": "tabular",
  "model_artifact": "outputs/models/tabular_model.pkl",
  "metrics": {
    "roc_auc": 0.82,
    "pr_auc": 0.79,
    "brier": 0.16
  }
}
```

### POST /endo/predict

Purpose: predict endometriosis risk for one patient payload.

Request body:

```json
{
  "age": 31,
  "menstrual_irregularity": 1,
  "chronic_pain_level": 7,
  "hormone_level_abnormality": 1,
  "infertility": 0,
  "bmi": 27.1
}
```

Success response:

```json
{
  "risk_score": 0.78,
  "risk_band": "high",
  "explanations": {
    "top_features": [
      { "name": "chronic_pain_level", "contribution": 0.21 },
      { "name": "hormone_level_abnormality", "contribution": 0.15 }
    ]
  },
  "model_version": "tabular_v1"
}
```

### POST /endo/state

Purpose: merge available module outputs into a patient digital state.

Request body:

```json
{
  "tabular_input": {},
  "imaging_features": {},
  "genomics_features": {},
  "labs_features": {},
  "stress_index": 0.41
}
```

Success response:

```json
{
  "patient_state": {
    "risk_score": 0.78,
    "severity_proxy": "moderate",
    "module_confidence": {
      "tabular": 0.83,
      "imaging": 0.0,
      "genomics": 0.0,
      "labs": 0.0
    }
  }
}
```

## 3) Error Response Standard

All endpoints should return:

```json
{
  "status": "error",
  "error_code": "STRING_CODE",
  "message": "Human readable message"
}
```

Use HTTP status codes:

- 200 for success
- 400 for validation errors
- 404 for not found
- 500 for internal errors
