/// Custom exceptions for the Sports Talent Assessment app
class ServerException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic data;

  const ServerException({
    required this.message,
    this.code,
    this.statusCode,
    this.data,
  });

  @override
  String toString() {
    return 'ServerException: $message (Code: $code, Status: $statusCode)';
  }
}

class NetworkException implements Exception {
  final String message;
  final String? code;

  const NetworkException({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'NetworkException: $message (Code: $code)';
  }
}

class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'AuthException: $message (Code: $code)';
  }
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;

  const ValidationException({
    required this.message,
    this.errors,
  });

  @override
  String toString() {
    return 'ValidationException: $message';
  }
}

class FileException implements Exception {
  final String message;
  final String? code;
  final String? filePath;

  const FileException({
    required this.message,
    this.code,
    this.filePath,
  });

  @override
  String toString() {
    return 'FileException: $message (Path: $filePath, Code: $code)';
  }
}

class CameraException implements Exception {
  final String message;
  final String? code;

  const CameraException({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'CameraException: $message (Code: $code)';
  }
}

class AnalysisException implements Exception {
  final String message;
  final String? code;
  final String? videoPath;

  const AnalysisException({
    required this.message,
    this.code,
    this.videoPath,
  });

  @override
  String toString() {
    return 'AnalysisException: $message (Video: $videoPath, Code: $code)';
  }
}

class PermissionException implements Exception {
  final String message;
  final String permissionType;

  const PermissionException({
    required this.message,
    required this.permissionType,
  });

  @override
  String toString() {
    return 'PermissionException: $message (Permission: $permissionType)';
  }
}

class DatabaseException implements Exception {
  final String message;
  final String? code;
  final String? table;

  const DatabaseException({
    required this.message,
    this.code,
    this.table,
  });

  @override
  String toString() {
    return 'DatabaseException: $message (Table: $table, Code: $code)';
  }
}

class CacheException implements Exception {
  final String message;
  final String? key;

  const CacheException({
    required this.message,
    this.key,
  });

  @override
  String toString() {
    return 'CacheException: $message (Key: $key)';
  }
}

class TimeoutException implements Exception {
  final String message;
  final Duration timeout;

  const TimeoutException({
    required this.message,
    required this.timeout,
  });

  @override
  String toString() {
    return 'TimeoutException: $message (Timeout: ${timeout.inSeconds}s)';
  }
}

class RateLimitException implements Exception {
  final String message;
  final int? resetTime;

  const RateLimitException({
    required this.message,
    this.resetTime,
  });

  @override
  String toString() {
    return 'RateLimitException: $message (Reset in: ${resetTime}s)';
  }
}
