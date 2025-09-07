import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic data;

  const Failure({
    required this.message,
    this.code,
    this.data,
  });

  @override
  List<Object?> get props => [message, code, data];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Network connection failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// File operation failures
class FileFailure extends Failure {
  const FileFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Camera related failures
class CameraFailure extends Failure {
  const CameraFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// AI Analysis failures
class AnalysisFailure extends Failure {
  const AnalysisFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Database failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Cache failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Timeout failures
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required super.message,
    super.code,
    super.data,
  });
}

/// Rate limit failures
class RateLimitFailure extends Failure {
  const RateLimitFailure({
    required super.message,
    super.code,
    super.data,
  });
}
