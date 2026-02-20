# Milestones and Definition of Done

Use this as the execution control sheet.

## Milestone M1 - Environment and Baseline Runtime

Goal:

- Backend and frontend run locally.

Pass criteria:

1. Backend responds on `/`.
2. Frontend loads at `http://localhost:3000`.
3. `scripts/smoke_test.ps1` passes current route checks.

## Milestone M2 - Data and Baseline Modeling

Goal:

- Dataset assumptions are validated and at least one baseline model is trained.

Pass criteria:

1. Data inventory complete.
2. Tabular model training reproducible.
3. Metrics written to `outputs/metrics.json`.

## Milestone M3 - Endometriosis API Integration

Goal:

- Backend exposes `/endo/train` and `/endo/predict`.

Pass criteria:

1. Endpoints follow `docs/13_Api_Contract.md`.
2. Predict endpoint returns risk score and explanation fields.

## Milestone M4 - Frontend Integration

Goal:

- Frontend pages use real endometriosis endpoints.

Pass criteria:

1. `/train-model` calls `/endo/train`.
2. `/predictions` calls `/endo/predict`.
3. Demo placeholder values removed from final path.

## Milestone M5 - Packaging and Final Signoff

Goal:

- Reproducible final artifact package.

Pass criteria:

1. Outputs exist and pass schema checks.
2. Report summarizes method, metrics, and caveats.
3. Execution checklist fully complete.

## Definition of Done

Done means all are true:

1. M1 to M5 pass criteria all met.
2. Smoke tests pass.
3. One command sequence from `Solution.md` reproduces results.
4. Decision log updated with final architecture choices.
