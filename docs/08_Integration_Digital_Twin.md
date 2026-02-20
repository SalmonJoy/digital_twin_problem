# Integration Layer (From Modules -> Digital Twin)

Because your datasets are not linked by patient ID, the cleanest architecture is a **modular digital twin** with late fusion.

## 1) Define a canonical Patient State

Create a single schema (Pydantic dataclass recommended) containing:

- Demographics: age, BMI, etc.
- Symptoms: pain scores, menstrual irregularity, infertility flags
- Imaging features: lesion area per class, lesion burden index
- Lab features: CA125, NLR, etc.
- Genomics features: top gene scores, module scores
- Physiology: stress index
- Uncertainty: confidence per module, missing modalities
- Timestamps for anything time-related

## 2) Orchestrator design

At inference time:

1. Detect which input modalities are provided for the patient/case.
2. Run the corresponding module pipelines.
3. Update the Patient State.
4. Produce:
   - risk score + calibrated confidence
   - explanations per module
   - "what-if" scenario outputs

## 3) Fusion strategy (pragmatic MVP)

Start with late fusion:

- If you have only tabular: use tabular risk score.
- If you have imaging: adjust risk via a calibrated mapping from lesion burden -> risk delta (learned from any linked dataset you later curate, or set as a configurable prior for MVP).
- If you have labs: combine using logistic stacking or a weighted average after calibration.

Avoid claiming joint multimodal training unless you have linked patient-level data.

## 4) What-if simulation (MVP)

Implement scenario simulation on the tabular module first:

- change BMI
- toggle hormone abnormality flag
- vary chronic pain level

Output:

- baseline risk
- scenario risk
- delta risk

## 5) Deliverable interface

Choose one:

- Notebook that generates `outputs/report.md`
- CLI: `python -m src.run_twin --input case.json --out outputs/case_result.json`
- API (later): FastAPI service returning Patient State + results

