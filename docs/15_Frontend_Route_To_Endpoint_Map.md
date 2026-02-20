# Frontend Route to Endpoint Map

This map reflects current frontend code and target integration path.

## 1) Current Route Map

| Route | Component | Current API Calls | Status |
|---|---|---|---|
| `/` | `src/App.js` welcome text | none | ok |
| `/live-monitoring` | `src/LiveMonitoring.js` + `src/SensorData.js` | `GET /start_iot`, `GET /stop_iot`, `GET /sensor/anomalies` | wired |
| `/historical-data` | `src/HistoricalData.js` | `GET /get_historical_data?num_data=N` | wired |
| `/sensor-graph` | `src/SensorGraph.js` | `GET /sensor/anomalies` | wired |
| `/predictions` | `src/Predictions.js` | none | demo only |
| `/train-model` | `src/TrainModel.js` | none | demo only |

## 2) Target Endometriosis Route Map

| Route | Target Endpoint(s) | Required Change |
|---|---|---|
| `/train-model` | `POST /endo/train` | replace random accuracy with backend response |
| `/predictions` | `POST /endo/predict`, `POST /endo/state` | replace synthetic globe/chart placeholders with model outputs |
| `/historical-data` | optional `GET /endo/history` | can remain if needed or repurpose for patient timeline |
| `/sensor-graph` | optional stress endpoint | keep only if stress context remains in scope |

## 3) Integration Checklist

1. Define API base URL in one config file.
2. Replace inline hardcoded URLs with config constant.
3. Add request/response validation in frontend.
4. Add loading, error, and empty states for each endpoint.
5. Remove demo-only random output paths once backend integration is complete.
