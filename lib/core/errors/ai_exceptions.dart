class AIException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  const AIException(
    this.message, {
    this.code,
    this.originalException,
  });

  @override
  String toString() => 'AIException: $message${code != null ? ' (Code: $code)' : ''}';
}

class ModelLoadException extends AIException {
  const ModelLoadException(super.message, {super.code, super.originalException});
}

class InferenceException extends AIException {
  const InferenceException(super.message, {super.code, super.originalException});
}

class DeviceCapabilityException extends AIException {
  const DeviceCapabilityException(super.message, {super.code, super.originalException});
}
