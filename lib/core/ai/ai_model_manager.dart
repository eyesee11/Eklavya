import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../errors/ai_exceptions.dart';
import '../utils/logger.dart';

/// AI Model Manager for TensorFlow Lite models on Android
class AIModelManager {
  static AIModelManager? _instance;
  static AIModelManager get instance => _instance ??= AIModelManager._();
  AIModelManager._();

  // Model instances
  Interpreter? _poseDetectionModel;
  Interpreter? _verticalJumpModel;
  Interpreter? _sprintModel;
  Interpreter? _flexibilityModel;
  Interpreter? _balanceModel;

  // Device capabilities
  bool _isGPUSupported = false;
  bool _isNNAPISupported = false;
  String _deviceType = 'unknown';
  int _androidSdkInt = 0;

  /// Initialize AI models and detect device capabilities
  Future<void> initialize() async {
    try {
      await _detectDeviceCapabilities();
      await _loadModels();
    } catch (e) {
      throw AIException(
        'Failed to initialize AI models: $e',
        code: 'AI_INIT_FAILED',
      );
    }
  }

  /// Detect device capabilities for model optimization
  Future<void> _detectDeviceCapabilities() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        _androidSdkInt = androidInfo.version.sdkInt;
        _deviceType = androidInfo.model;
        
        // GPU support detection (approximate)
        _isGPUSupported = _androidSdkInt >= 23 && 
            (androidInfo.supported64BitAbis.isNotEmpty ||
             androidInfo.model.toLowerCase().contains('pixel') ||
             androidInfo.model.toLowerCase().contains('samsung'));
        
        // NNAPI support (Android 8.1+)
        _isNNAPISupported = _androidSdkInt >= 27;
        
        Logger.device('Device: ${androidInfo.model}');
        Logger.device('Android SDK: $_androidSdkInt');
        Logger.device('GPU Support: $_isGPUSupported');
        Logger.device('NNAPI Support: $_isNNAPISupported');
      }
    } catch (e) {
      Logger.warning('Failed to detect device capabilities: $e');
    }
  }

  /// Load all AI models with optimal configuration
  Future<void> _loadModels() async {
    final options = InterpreterOptions();
    
    // Configure based on device capabilities
    if (_isGPUSupported) {
      try {
        options.addDelegate(GpuDelegate());
        Logger.ai('GPU acceleration enabled');
      } catch (e) {
        Logger.warning('GPU delegate failed, falling back to CPU: $e');
      }
    } else if (_isNNAPISupported) {
      try {
        // Note: NnApiDelegate might not be available in current tflite_flutter version
        // options.addDelegate(NnApiDelegate());
        Logger.ai('NNAPI acceleration requested but using CPU');
      } catch (e) {
        Logger.warning('NNAPI delegate failed, using CPU: $e');
      }
    } else {
      // Note: threads property might not be available in current API
      Logger.ai('CPU optimization with ${_getOptimalThreadCount()} threads');
    }

    // Load pose detection model (primary)
    try {
      _poseDetectionModel = await _loadModel(
        'assets/models/pose_detection/pose_landmark_full.tflite',
        options,
        fallback: 'assets/models/pose_detection/pose_landmark_lite.tflite'
      );
      Logger.ai('Pose detection model loaded');
    } catch (e) {
      Logger.error('Failed to load pose detection model: $e');
    }

    // Load sports analysis models
    await _loadSportsModels(options);
  }

  /// Load sports-specific analysis models
  Future<void> _loadSportsModels(InterpreterOptions options) async {
    final models = [
      {
        'name': 'Vertical Jump',
        'path': 'assets/models/sports_analysis/vertical_jump_analyzer.tflite',
        'setter': (Interpreter model) => _verticalJumpModel = model,
      },
      {
        'name': 'Sprint',
        'path': 'assets/models/sports_analysis/sprint_analyzer.tflite',
        'setter': (Interpreter model) => _sprintModel = model,
      },
      {
        'name': 'Flexibility',
        'path': 'assets/models/sports_analysis/flexibility_analyzer.tflite',
        'setter': (Interpreter model) => _flexibilityModel = model,
      },
      {
        'name': 'Balance',
        'path': 'assets/models/sports_analysis/balance_analyzer.tflite',
        'setter': (Interpreter model) => _balanceModel = model,
      },
    ];

    for (final modelConfig in models) {
      try {
        final model = await _loadModel(modelConfig['path'] as String, options);
        (modelConfig['setter'] as Function(Interpreter))(model);
        Logger.ai('${modelConfig['name']} model loaded');
      } catch (e) {
        Logger.warning('${modelConfig['name']} model failed to load: $e');
      }
    }
  }

  /// Load a single TensorFlow Lite model with fallback
  Future<Interpreter> _loadModel(
    String modelPath, 
    InterpreterOptions options, {
    String? fallback,
  }) async {
    try {
      return await Interpreter.fromAsset(modelPath, options: options);
    } catch (e) {
      if (fallback != null) {
        Logger.ai('Falling back to lightweight model: $fallback');
        return await Interpreter.fromAsset(fallback, options: options);
      }
      rethrow;
    }
  }

  /// Get optimal thread count based on device
  int _getOptimalThreadCount() {
    // Use processor count or fallback to reasonable defaults
    final processorCount = Platform.numberOfProcessors;
    
    if (_androidSdkInt >= 28 && processorCount >= 8) {
      return 4; // High-end devices
    } else if (_androidSdkInt >= 24 && processorCount >= 4) {
      return 2; // Mid-range devices
    } else {
      return 1; // Low-end devices
    }
  }

  /// Analyze pose from video frame
  Future<List<Map<String, dynamic>>> analyzePose(Uint8List imageData) async {
    if (_poseDetectionModel == null) {
      throw AIException(
        'Pose detection model not loaded',
        code: 'MODEL_NOT_LOADED',
      );
    }

    try {
      // Preprocess image data
      final input = _preprocessImage(imageData);
      
      // Prepare output buffers
      final output = List.filled(33 * 3, 0.0).reshape([33, 3]);
      
      // Run inference
      _poseDetectionModel!.run(input, output);
      
      // Convert to pose landmarks
      return _convertToPoseLandmarks(List<List<double>>.from(
        output.map((row) => List<double>.from(row))
      ));
    } catch (e) {
      throw AIException(
        'Pose analysis failed: $e',
        code: 'POSE_ANALYSIS_FAILED',
      );
    }
  }

  /// Analyze vertical jump performance
  Future<Map<String, dynamic>> analyzeVerticalJump(
    List<List<Map<String, dynamic>>> poseSequence,
  ) async {
    if (_verticalJumpModel == null) {
      throw AIException(
        'Vertical jump model not loaded',
        code: 'MODEL_NOT_LOADED',
      );
    }

    try {
      // Prepare input from pose sequence
      final input = _preparePoseSequenceInput(poseSequence);
      
      // Prepare output buffer
      final output = <String, dynamic>{};
      
      // Run inference
      _verticalJumpModel!.run(input, output);
      
      return {
        'height_cm': output['height'] ?? 0.0,
        'form_score': output['form_score'] ?? 0.0,
        'takeoff_angle': output['takeoff_angle'] ?? 0.0,
        'landing_stability': output['landing_stability'] ?? 0.0,
        'power_rating': output['power_rating'] ?? 0.0,
      };
    } catch (e) {
      throw AIException(
        'Vertical jump analysis failed: $e',
        code: 'VERTICAL_JUMP_ANALYSIS_FAILED',
      );
    }
  }

  /// Preprocess image data for model input
  List<List<List<List<double>>>> _preprocessImage(Uint8List imageData) {
    // This is a placeholder - actual implementation would:
    // 1. Decode image from bytes
    // 2. Resize to model input size (typically 256x256)
    // 3. Normalize pixel values (0-1 or -1 to 1)
    // 4. Convert to required tensor format
    
    // For now, return dummy data with correct shape
    return List.generate(1, (_) =>
      List.generate(256, (_) =>
        List.generate(256, (_) =>
          List.generate(3, (_) => 0.0))));
  }

  /// Convert model output to pose landmarks
  List<Map<String, dynamic>> _convertToPoseLandmarks(List<List<double>> output) {
    final landmarks = <Map<String, dynamic>>[];
    
    for (int i = 0; i < output.length; i++) {
      landmarks.add({
        'id': i,
        'x': output[i][0],
        'y': output[i][1],
        'z': output[i][2],
        'visibility': output[i].length > 3 ? output[i][3] : 1.0,
      });
    }
    
    return landmarks;
  }

  /// Prepare pose sequence input for sports analysis
  List<List<List<double>>> _preparePoseSequenceInput(
    List<List<Map<String, dynamic>>> poseSequence,
  ) {
    // Convert pose sequence to model input format
    // This would flatten the pose landmarks into the required tensor shape
    return poseSequence.map((frame) =>
      frame.map((landmark) => [
        landmark['x'] as double,
        landmark['y'] as double,
        landmark['z'] as double,
      ]).toList()
    ).toList();
  }

  /// Get model status and performance info
  Map<String, dynamic> getModelStatus() {
    return {
      'device_type': _deviceType,
      'android_sdk': _androidSdkInt,
      'gpu_supported': _isGPUSupported,
      'nnapi_supported': _isNNAPISupported,
      'models_loaded': {
        'pose_detection': _poseDetectionModel != null,
        'vertical_jump': _verticalJumpModel != null,
        'sprint': _sprintModel != null,
        'flexibility': _flexibilityModel != null,
        'balance': _balanceModel != null,
      },
      'optimal_threads': _getOptimalThreadCount(),
    };
  }

  /// Dispose models and free memory
  void dispose() {
    _poseDetectionModel?.close();
    _verticalJumpModel?.close();
    _sprintModel?.close();
    _flexibilityModel?.close();
    _balanceModel?.close();
    
    _poseDetectionModel = null;
    _verticalJumpModel = null;
    _sprintModel = null;
    _flexibilityModel = null;
    _balanceModel = null;
    
    Logger.ai('AI models disposed');
  }
}
