# Decision Log

Record architectural and implementation decisions here.

## Decision 1

- Date: 2026-02-20
- Decision: Use modular digital twin architecture.
- Reason: Datasets are not linked by shared patient IDs.
- Impact: Independent module training with late fusion.

## Decision 2

- Date: 2026-02-20
- Decision: Use existing `../software` app as runtime shell.
- Reason: It already has backend + frontend + API workflow.
- Impact: Faster delivery by incremental replacement of model logic.

## Decision 3

- Date: 2026-02-20
- Decision: Prioritize tabular endometriosis module first.
- Reason: Fastest path to stable end-to-end deliverable.
- Impact: Early usable `/endo/predict` endpoint before heavier modules.

## Open Decision A

- Topic: Whether to keep IoT routes after endometriosis integration.
- Options:
  1. Keep as optional stress module demo.
  2. Deprecate from UI but keep backend.
  3. Remove completely.

## Open Decision B

- Topic: Explainability approach for tabular model.
- Options:
  1. SHAP values.
  2. Coefficient-based explanations (for linear baseline).
  3. Tree-based feature contribution approximation.

## Open Decision C

- Topic: API versioning strategy.
- Options:
  1. Prefix endpoints with `/v1/`.
  2. Keep path stable and version through headers.
