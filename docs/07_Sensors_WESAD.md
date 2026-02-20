# Sensors (WESAD) - Parsing, Features, and Stress Index

WESAD is included as a **generic physiology/stress module** for a digital twin. It is not endometriosis-specific.

Primary doc:

- `sensor data/Dataset-10/WESAD/wesad_readme.pdf`

## 1) What WESAD contains (from the readme)

Per subject `SX`:

- `SX_readme.txt`: subject info + data quality notes
- `SX_quest.csv`: protocol schedule + self-reports (PANAS, STAI, SAM, SSSQ)
- `SX_respiban.txt`: 8-channel RespiBAN raw data @ **700 Hz**
- `SX_E4_Data.zip`: Empatica E4 raw signals (ACC 32 Hz, BVP 64 Hz, EDA 4 Hz, TEMP 4 Hz)
- `SX.pkl`: synchronized data + labels

Label IDs used in synchronized data:

- 0 transient/not defined
- 1 baseline
- 2 stress
- 3 amusement
- 4 meditation
- 5/6/7 ignore

## 2) Important caveat in this workspace

This dataset snapshot is incomplete:

- Many subject folders contain only `*_readme.txt` and `*_quest.csv`.
- Raw signals are present for some subjects only (e.g., S2 nested under `sensor data/Dataset-10/WESAD/S2/S2`, S3 has RespiBAN+E4 directory, S9 has `S9.pkl` + E4 zip).

Plan accordingly:

- For a full WESAD pipeline, obtain the complete dataset from the official source.
- For MVP here, implement parsing on the subjects that include raw data.

## 3) Step-by-step pipeline

### Step 1 - Parse Empatica E4 files

When unzipped, E4 CSVs have:

- row 1: start time (unix timestamp UTC)
- row 2: sample rate (Hz)

Units:

- ACC is `1/64 g` (3 columns)
- TEMP is Celsius
- EDA is microsiemens
- BVP is photoplethysmograph signal

Example: `sensor data/Dataset-10/WESAD/S3/S3_E4_Data/info.txt`

### Step 2 - Parse RespiBAN (respiban.txt)

RespiBAN file:

- 10 columns: seq, ignore, then 8 sensor channels
- channel order in header

The readme contains conversion formulas (ECG/EDA/EMG/TEMP/ACC/RESP).

### Step 3 - Synchronize E4 and RespiBAN

Options:

- Use `SX.pkl` when available (already synchronized + labels)
- Otherwise align using the "double tapping gesture" visible in ACC signals (see readme)

### Step 4 - Feature extraction

Compute windowed features (e.g., 30-60s windows):

- HRV features from BVP/IBI
- EDA tonic/phasic features
- Respiration features
- Motion features from ACC

### Step 5 - Train a stress classifier

Use subject-wise splits (leave-one-subject-out or group CV).

Output a `stress_index` in [0,1] that can be consumed by the digital twin.

## 4) How it fits the Digital Twin

- The stress module provides a **contextual state** that may modulate symptom perception.
- Do not claim endometriosis prediction from WESAD; it's a reusable physiology module.

