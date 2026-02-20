# Imaging Pipeline (Segmentation / Detection Modules)

This workspace contains multiple imaging datasets with different annotation formats. The recommended MVP is **segmentation** on GLENDA.

## 1) Datasets and formats

### GLENDA (primary)

- Root: `medical imaging/Dataset-4/Glenda_v1.5_classes`
- Images: `frames/`
- Masks: `annots/` (PNG per frame)
- COCO index: `coco.json`
- Classes: `medical imaging/Dataset-4/Glenda_v1.5_classes/labels.txt`

### EndoTect/Kvasir-SEG style (pipeline validation)

- Root: `medical imaging/Dataset-3/EndoTect`
- Images + masks available for train/test
- BBoxes per image in `bbox/*.csv` with `class_name,xmin,ymin,xmax,ymax`

### Uterus Roboflow (tiny)

- Root: `medical imaging/Dataset-5/Uterus.v3i.coco`
- COCO file: `train/_annotations.coco.json`
- Note: annotations appear to be **Uterus** only (no lesion labels in this export)

## 2) Segmentation MVP (GLENDA)

### Step 1 - Define the task

- Multi-class semantic segmentation:
  - background
  - Endo-Peritoneum
  - Endo-Ovar
  - Endo-TIE
  - Endo-Uterus

### Step 2 - Split without leakage

Frames from the same video are highly correlated. Prefer splitting by video ID embedded in filenames (e.g., `video_XXXX.mp4`).

### Step 3 - Baseline model

- Architecture: U-Net / DeepLabV3
- Loss: cross-entropy + Dice (or focal + Dice)
- Augmentation: flips, brightness, mild blur, crop/resize

### Step 4 - Evaluate

- Dice + IoU per class
- Visual sanity checks:
  - overlay masks on frames
  - verify class colors/labels match `labels.txt`

### Step 5 - Export features to the twin

From predicted masks compute:

- per-class area ratio
- lesion count (connected components)
- "lesion burden index" summary

Store per-image outputs to `outputs/imaging/` and aggregated stats to `outputs/imaging_features.csv`.

## 3) EndoTect/Kvasir pipeline checks

Use this dataset to validate your segmentation training loop (data loading, augmentations, metrics) even if it's not endometriosis-specific.

## 4) Testing checklist

- Assert that every image has a corresponding mask (GLENDA, EndoTect).
- Assert mask dimensions match image dimensions after transforms.
- Unit test metric computations with small synthetic masks.

