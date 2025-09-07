import 'dart:developer' as developer;

class Logger {
  static const String _tag = 'SIH_TalentApp';

  static void debug(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 500);
  }

  static void info(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 800);
  }

  static void warning(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 900);
  }

  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void performance(String message, {String? tag, int? duration}) {
    developer.log(
      '⏱️ $message${duration != null ? ' (${duration}ms)' : ''}',
      name: tag ?? _tag,
      level: 700,
    );
  }

  static void ai(String message, {String? tag}) {
    developer.log('🤖 $message', name: tag ?? _tag, level: 600);
  }

  static void device(String message, {String? tag}) {
    developer.log('📱 $message', name: tag ?? _tag, level: 600);
  }
}
