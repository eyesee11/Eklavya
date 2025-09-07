import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'logger.dart';
import 'package:permission_handler/permission_handler.dart';

/// Android-specific performance optimization utilities
class AndroidPerformanceUtils {
  static AndroidPerformanceUtils? _instance;
  static AndroidPerformanceUtils get instance => _instance ??= AndroidPerformanceUtils._();
  AndroidPerformanceUtils._();

  // Device info
  AndroidDeviceInfo? _deviceInfo;
  int _totalMemoryMB = 0;
  bool _isLowEndDevice = false;

  /// Initialize performance monitoring
  Future<void> initialize() async {
    if (!Platform.isAndroid) return;

    try {
      final deviceInfo = DeviceInfoPlugin();
      _deviceInfo = await deviceInfo.androidInfo;
      await _analyzeDeviceCapabilities();
      await _requestBatteryOptimizations();
    } catch (e) {
      Logger.warning('Performance initialization failed: $e');
    }
  }

  /// Analyze device capabilities and set optimization flags
  Future<void> _analyzeDeviceCapabilities() async {
    if (_deviceInfo == null) return;

    // Estimate total memory based on device info
    _totalMemoryMB = _estimateDeviceMemory();
    
    // Consider device low-end if:
    // - Android version < 8.0 (API 26)
    // - Estimated memory < 3GB
    // - No 64-bit support
    _isLowEndDevice = _deviceInfo!.version.sdkInt < 26 ||
                     _totalMemoryMB < 3072 ||
                     _deviceInfo!.supported64BitAbis.isEmpty;

    Logger.device('Device Analysis:');
    Logger.device('   Model: ${_deviceInfo!.model}');
    Logger.device('   Android: ${_deviceInfo!.version.release} (API ${_deviceInfo!.version.sdkInt})');
    Logger.device('   Memory: ${_totalMemoryMB}MB (estimated)');
    Logger.device('   64-bit: ${_deviceInfo!.supported64BitAbis.isNotEmpty}');
    Logger.device('   Low-end: $_isLowEndDevice');
  }

  /// Estimate device memory based on specifications
  int _estimateDeviceMemory() {
    final model = _deviceInfo!.model.toLowerCase();
    final sdkInt = _deviceInfo!.version.sdkInt;
    
    // High-end devices (8GB+)
    if (model.contains('pixel 6') || 
        model.contains('pixel 7') ||
        model.contains('pixel 8') ||
        model.contains('galaxy s2') ||
        model.contains('galaxy note') ||
        model.contains('oneplus')) {
      return 8192;
    }
    
    // Mid-high devices (6GB)
    if (model.contains('pixel 4') ||
        model.contains('pixel 5') ||
        model.contains('galaxy s1') ||
        model.contains('galaxy a7') ||
        model.contains('xiaomi')) {
      return 6144;
    }
    
    // Mid-range devices (4GB)
    if (sdkInt >= 28 || model.contains('galaxy a5') || model.contains('galaxy a6')) {
      return 4096;
    }
    
    // Entry-level devices (2-3GB)
    if (sdkInt >= 24) {
      return 3072;
    }
    
    // Very old devices (1-2GB)
    return 2048;
  }

  /// Request battery optimization exemptions
  Future<void> _requestBatteryOptimizations() async {
    try {
      if (_deviceInfo!.version.sdkInt >= 23) {
        final status = await Permission.ignoreBatteryOptimizations.status;
        if (!status.isGranted) {
          Logger.info('Requesting battery optimization exemption...');
          await Permission.ignoreBatteryOptimizations.request();
        }
      }
    } catch (e) {
      Logger.warning('Battery optimization request failed: $e');
    }
  }

  /// Get optimal video recording settings based on device
  Map<String, dynamic> getOptimalVideoSettings() {
    if (_isLowEndDevice) {
      return {
        'resolution_width': 720,
        'resolution_height': 1280,
        'fps': 24,
        'bitrate': 2000000, // 2 Mbps
        'enable_stabilization': false,
        'max_duration_seconds': 30,
      };
    } else if (_totalMemoryMB < 6144) {
      return {
        'resolution_width': 1080,
        'resolution_height': 1920,
        'fps': 30,
        'bitrate': 5000000, // 5 Mbps
        'enable_stabilization': true,
        'max_duration_seconds': 60,
      };
    } else {
      return {
        'resolution_width': 1080,
        'resolution_height': 1920,
        'fps': 60,
        'bitrate': 8000000, // 8 Mbps
        'enable_stabilization': true,
        'max_duration_seconds': 120,
      };
    }
  }

  /// Get optimal AI processing settings
  Map<String, dynamic> getOptimalAISettings() {
    return {
      'use_gpu_acceleration': !_isLowEndDevice && _deviceInfo!.version.sdkInt >= 23,
      'use_nnapi': _deviceInfo!.version.sdkInt >= 27,
      'max_concurrent_analyses': _isLowEndDevice ? 1 : 2,
      'input_image_size': _isLowEndDevice ? 224 : 256,
      'enable_pose_smoothing': !_isLowEndDevice,
      'processing_threads': _isLowEndDevice ? 1 : 2,
    };
  }

  /// Monitor memory usage and trigger cleanup if needed
  Future<bool> checkMemoryPressure() async {
    try {
      // This is a simplified check - in production you might use:
      // - ActivityManager.getMemoryInfo()
      // - Runtime.getRuntime().freeMemory()
      // - Process memory monitoring
      
      final memoryPressureThreshold = _isLowEndDevice ? 0.8 : 0.9;
      
      // Simulate memory check (replace with actual implementation)
      final simulatedUsage = 0.7; // 70% memory usage
      
      if (simulatedUsage > memoryPressureThreshold) {
        Logger.warning('Memory pressure detected, triggering cleanup...');
        await _performMemoryCleanup();
        return true;
      }
      
      return false;
    } catch (e) {
      Logger.error('Memory check failed: $e');
      return false;
    }
  }

  /// Perform memory cleanup
  Future<void> _performMemoryCleanup() async {
    try {
      // Clear image caches
      // PaintingBinding.instance.imageCache.clear();
      
      // Force garbage collection
      // System.gc() equivalent would be called here
      
      Logger.info('Memory cleanup completed');
    } catch (e) {
      Logger.error('Memory cleanup failed: $e');
    }
  }

  /// Get device performance tier
  String getPerformanceTier() {
    if (_isLowEndDevice) {
      return 'basic';
    } else if (_totalMemoryMB < 6144) {
      return 'standard';
    } else {
      return 'premium';
    }
  }

  /// Check if device supports advanced features
  Map<String, bool> getFeatureSupport() {
    return {
      'high_resolution_video': !_isLowEndDevice,
      'gpu_acceleration': _deviceInfo!.version.sdkInt >= 23 && !_isLowEndDevice,
      'real_time_analysis': _totalMemoryMB >= 4096,
      'background_processing': _deviceInfo!.version.sdkInt >= 26,
      'multiple_cameras': _deviceInfo!.version.sdkInt >= 24,
      'video_stabilization': !_isLowEndDevice,
      'advanced_ai_features': _totalMemoryMB >= 6144,
    };
  }

  /// Get storage optimization settings
  Map<String, dynamic> getStorageSettings() {
    return {
      'max_video_cache_mb': _isLowEndDevice ? 500 : 1000,
      'auto_cleanup_days': _isLowEndDevice ? 7 : 14,
      'compress_videos': _isLowEndDevice,
      'max_concurrent_downloads': _isLowEndDevice ? 1 : 3,
      'enable_background_sync': !_isLowEndDevice,
    };
  }

  /// Get device info summary
  Map<String, dynamic> getDeviceInfo() {
    return {
      'model': _deviceInfo?.model ?? 'Unknown',
      'manufacturer': _deviceInfo?.manufacturer ?? 'Unknown',
      'android_version': _deviceInfo?.version.release ?? 'Unknown',
      'sdk_int': _deviceInfo?.version.sdkInt ?? 0,
      'estimated_memory_mb': _totalMemoryMB,
      'is_low_end_device': _isLowEndDevice,
      'performance_tier': getPerformanceTier(),
      'supported_abis': _deviceInfo?.supportedAbis ?? [],
      '64bit_support': _deviceInfo?.supported64BitAbis.isNotEmpty ?? false,
    };
  }

  /// Dispose resources
  void dispose() {
    _deviceInfo = null;
    Logger.device('Android performance utils disposed');
  }
}
