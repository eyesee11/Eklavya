import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import '../errors/exceptions.dart';
import '../constants/app_constants.dart';

/// Utility class for handling device permissions
class PermissionUtils {
  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      throw PermissionException(
        message: AppConstants.cameraPermissionError,
        permissionType: 'camera',
      );
    }
  }

  /// Request microphone permission
  static Future<bool> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      throw PermissionException(
        message: 'Microphone permission is required to record videos with audio.',
        permissionType: 'microphone',
      );
    }
  }

  /// Request storage permission
  static Future<bool> requestStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        return status == PermissionStatus.granted;
      }
      return true; // iOS doesn't need explicit storage permission
    } catch (e) {
      throw PermissionException(
        message: AppConstants.storagePermissionError,
        permissionType: 'storage',
      );
    }
  }

  /// Request all necessary permissions for video recording
  static Future<bool> requestVideoRecordingPermissions() async {
    final cameraGranted = await requestCameraPermission();
    final microphoneGranted = await requestMicrophonePermission();
    final storageGranted = await requestStoragePermission();

    return cameraGranted && microphoneGranted && storageGranted;
  }

  /// Check if camera permission is granted
  static Future<bool> isCameraPermissionGranted() async {
    final status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }

  /// Check if microphone permission is granted
  static Future<bool> isMicrophonePermissionGranted() async {
    final status = await Permission.microphone.status;
    return status == PermissionStatus.granted;
  }

  /// Check if storage permission is granted
  static Future<bool> isStoragePermissionGranted() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      return status == PermissionStatus.granted;
    }
    return true; // iOS doesn't need explicit storage permission
  }

  /// Open app settings for manual permission grant
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// Get permission status description
  static String getPermissionStatusDescription(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Permission granted';
      case PermissionStatus.denied:
        return 'Permission denied';
      case PermissionStatus.restricted:
        return 'Permission restricted';
      case PermissionStatus.limited:
        return 'Permission limited';
      case PermissionStatus.permanentlyDenied:
        return 'Permission permanently denied. Please enable it in settings.';
      default:
        return 'Unknown permission status';
    }
  }
}
