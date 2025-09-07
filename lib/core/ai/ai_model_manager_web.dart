// Platform-specific AI model manager stub for web
class AIModelManager {
  static final AIModelManager _instance = AIModelManager._internal();
  
  factory AIModelManager() => _instance;
  
  AIModelManager._internal();

  /// Initialize AI models - Web platform stub
  Future<void> initialize() async {
    // Web platform doesn't support TensorFlow Lite
    // AI features are available on mobile platforms only
    throw UnsupportedError(
      'AI model processing is not supported on web platform. '
      'Please use the mobile app for AI-powered sports analysis.'
    );
  }

  /// Analyze pose from image data - Web platform stub
  Future<List<Map<String, dynamic>>> analyzePose(dynamic imageData) async {
    throw UnsupportedError(
      'Pose analysis is not supported on web platform. '
      'Please use the mobile app for AI-powered pose analysis.'
    );
  }

  /// Analyze vertical jump performance - Web platform stub
  Future<Map<String, dynamic>> analyzeVerticalJump(
    List<Map<String, dynamic>> poseLandmarks,
  ) async {
    throw UnsupportedError(
      'Vertical jump analysis is not supported on web platform. '
      'Please use the mobile app for AI-powered jump analysis.'
    );
  }

  /// Get device capability information - Web platform stub
  Map<String, dynamic> getDeviceCapabilities() {
    return {
      'platform': 'web',
      'supportsAI': false,
      'gpuSupport': false,
      'nnApiSupport': false,
      'message': 'AI features are available on mobile platforms only'
    };
  }

  /// Check if models are loaded - Web platform stub
  bool get isInitialized => false;

  /// Dispose resources - Web platform stub
  void dispose() {
    // Nothing to dispose on web platform
  }
}
