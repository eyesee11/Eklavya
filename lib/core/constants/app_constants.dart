/// Application-wide constants for Sports Talent Assessment App
class AppConstants {
  // App Information
  static const String appName = 'Sports Talent Assessment';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'AI-Powered Sports Talent Discovery for Rural India';
  
  // Sports Test Types
  static const String verticalJumpTest = 'vertical_jump';
  static const String situpsTest = 'situps';
  static const String shuttleRunTest = 'shuttle_run';
  static const String enduranceRunTest = 'endurance_run';
  static const String flexibilityTest = 'flexibility';
  
  // Video Recording Constants
  static const int maxRecordingDurationSeconds = 30;
  static const int minRecordingDurationSeconds = 5;
  static const String videoFormat = 'mp4';
  static const int videoQualityMedium = 720;
  static const int videoQualityHigh = 1080;
  
  // AI Analysis Constants
  static const double minConfidenceThreshold = 0.7;
  static const int poseKeypointsCount = 33; // BlazePose landmarks
  static const int analysisTimeoutSeconds = 30;
  
  // Database Constants
  static const String localDatabaseName = 'sports_talent_local.db';
  static const int localDatabaseVersion = 1;
  
  // Shared Preferences Keys
  static const String keyUserToken = 'user_token';
  static const String keyUserId = 'user_id';
  static const String keyUserProfile = 'user_profile';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyOfflineMode = 'offline_mode';
  
  // Network Constants
  static const int connectionTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;
  
  // File Paths
  static const String videosDirectory = 'videos';
  static const String modelsDirectory = 'models';
  static const String tempDirectory = 'temp';
  
  // Achievement Constants
  static const int pointsPerTest = 10;
  static const int pointsPerImprovement = 5;
  static const int pointsStreakBonus = 20;
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String cameraPermissionError = 'Camera permission is required to record videos.';
  static const String storagePermissionError = 'Storage permission is required to save videos.';
  
  // Success Messages
  static const String videoRecordedSuccess = 'Video recorded successfully!';
  static const String analysisCompleteSuccess = 'Analysis completed successfully!';
  static const String profileUpdatedSuccess = 'Profile updated successfully!';
}

/// UI Constants
class UIConstants {
  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Button Heights
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;
}

/// Sports Test Configuration
class TestConfig {
  static const Map<String, Map<String, dynamic>> testConfigurations = {
    AppConstants.verticalJumpTest: {
      'name': 'Vertical Jump Test',
      'description': 'Measure your explosive leg power and jump height',
      'duration': 15, // seconds
      'instructions': [
        'Stand with feet shoulder-width apart',
        'Keep your arms at your sides',
        'Jump as high as possible',
        'Land softly on both feet',
        'Perform 3 consecutive jumps'
      ],
      'icon': '🏃‍♂️',
      'color': 0xFF2196F3,
      'difficulty': 'Beginner',
      'equipment': 'None required',
    },
    AppConstants.situpsTest: {
      'name': 'Sit-ups Test',
      'description': 'Test your core strength and endurance',
      'duration': 60, // seconds
      'instructions': [
        'Lie on your back with knees bent',
        'Place hands behind your head',
        'Lift your torso towards your knees',
        'Return to starting position',
        'Maintain steady rhythm'
      ],
      'icon': '💪',
      'color': 0xFF4CAF50,
      'difficulty': 'Intermediate',
      'equipment': 'Exercise mat (optional)',
    },
  };
}
