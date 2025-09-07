/// API endpoints and network configuration
class ApiConstants {
  // Base URLs
  static const String baseUrlDev = 'http://localhost:3000/api/v1';
  static const String baseUrlStaging = 'https://staging-api.sportstalent.com/api/v1';
  static const String baseUrlProd = 'https://api.sportstalent.com/api/v1';
  
  // Current environment
  static const String baseUrl = baseUrlDev; // Change based on environment
  
  // Authentication Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  static const String verifyTokenEndpoint = '/auth/verify';
  static const String emailVerificationEndpoint = '/auth/verify-email';
  static const String phoneVerificationEndpoint = '/auth/verify-phone';
  static const String phoneOtpVerificationEndpoint = '/auth/verify-phone-otp';
  static const String passwordResetEndpoint = '/auth/reset-password';
  
  // User Endpoints
  static const String userProfileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/profile/update';
  static const String deleteAccountEndpoint = '/user/delete';
  static const String sportsProfileEndpoint = '/user/sports-profile';
  
  // Sports Test Endpoints
  static const String uploadVideo = '/tests/upload-video';
  static const String submitTest = '/tests/submit';
  static const String getTestResults = '/tests/results';
  static const String getTestHistory = '/tests/history';
  static const String retryAnalysis = '/tests/retry-analysis';
  
  // AI Analysis Endpoints
  static const String analyzeVideo = '/analysis/video';
  static const String getAnalysisStatus = '/analysis/status';
  static const String getAnalysisResult = '/analysis/result';
  
  // Leaderboard Endpoints
  static const String globalLeaderboard = '/leaderboard/global';
  static const String regionalLeaderboard = '/leaderboard/regional';
  static const String ageGroupLeaderboard = '/leaderboard/age-group';
  
  // Achievements Endpoints
  static const String getUserAchievements = '/achievements/user';
  static const String unlockAchievement = '/achievements/unlock';
  static const String getAllAchievements = '/achievements/all';
  
  // Benchmarks Endpoints
  static const String getBenchmarks = '/benchmarks';
  static const String compareBenchmark = '/benchmarks/compare';
  
  // File Upload Endpoints
  static const String uploadFile = '/files/upload';
  static const String getFileUrl = '/files/url';
  static const String deleteFile = '/files/delete';
  
  // Health Check
  static const String healthCheck = '/health';
  static const String version = '/version';
  
  // Headers
  static const String authHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String userAgentHeader = 'User-Agent';
  
  // Content Types
  static const String jsonContentType = 'application/json';
  static const String formDataContentType = 'multipart/form-data';
  static const String videoContentType = 'video/mp4';
}

/// Error codes from API
class ApiErrorCodes {
  // Authentication Errors
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String accountNotFound = 'ACCOUNT_NOT_FOUND';
  static const String accountAlreadyExists = 'ACCOUNT_ALREADY_EXISTS';
  
  // Validation Errors
  static const String validationError = 'VALIDATION_ERROR';
  static const String invalidInput = 'INVALID_INPUT';
  static const String missingRequiredField = 'MISSING_REQUIRED_FIELD';
  
  // File Upload Errors
  static const String fileTooLarge = 'FILE_TOO_LARGE';
  static const String invalidFileFormat = 'INVALID_FILE_FORMAT';
  static const String uploadFailed = 'UPLOAD_FAILED';
  
  // Analysis Errors
  static const String analysisInProgress = 'ANALYSIS_IN_PROGRESS';
  static const String analysisFailed = 'ANALYSIS_FAILED';
  static const String videoTooShort = 'VIDEO_TOO_SHORT';
  static const String videoTooLong = 'VIDEO_TOO_LONG';
  static const String lowVideoQuality = 'LOW_VIDEO_QUALITY';
  static const String poseNotDetected = 'POSE_NOT_DETECTED';
  
  // System Errors
  static const String serverError = 'SERVER_ERROR';
  static const String serviceUnavailable = 'SERVICE_UNAVAILABLE';
  static const String databaseError = 'DATABASE_ERROR';
  static const String externalServiceError = 'EXTERNAL_SERVICE_ERROR';
  
  // Rate Limiting
  static const String rateLimitExceeded = 'RATE_LIMIT_EXCEEDED';
  static const String quotaExceeded = 'QUOTA_EXCEEDED';
}

/// HTTP Status Codes
class HttpStatusCodes {
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int tooManyRequests = 429;
  
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}
