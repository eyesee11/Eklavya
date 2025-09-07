# AI Models Directory

This directory contains TensorFlow Lite models for sports talent assessment:

## Pose Detection Models
- `pose_detection/` - MediaPipe BlazePose models
  - `pose_landmark_full.tflite` - Main pose detection model
  - `pose_detection.tflite` - Pose detection model
  - `pose_landmark_lite.tflite` - Lightweight pose model for low-end devices

## Sports Analysis Models
- `sports_analysis/` - Custom trained models for sports movement analysis
  - `vertical_jump_analyzer.tflite` - Vertical jump height and form analysis
  - `sprint_analyzer.tflite` - Sprint speed and technique analysis
  - `flexibility_analyzer.tflite` - Flexibility assessment model
  - `balance_analyzer.tflite` - Balance and stability analysis

## Model Loading
Models are loaded in the `AIModelManager` class with automatic fallback to CPU processing for unsupported devices.

## Performance
- GPU acceleration enabled where supported
- Quantized models for better performance on mobile devices
- Adaptive model selection based on device capabilities
