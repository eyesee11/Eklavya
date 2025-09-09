import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:camera/camera.dart';

import 'injection.config.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Initialize dependency injection
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

/// Setup external dependencies that require async initialization
@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @preResolve
  Future<List<CameraDescription>> get cameras => availableCameras();
}

/// Initialize all dependencies for the application
class DependencyInjection {
  static bool _isInitialized = false;
  
  static Future<void> init() async {
    // Prevent duplicate initialization
    if (_isInitialized) {
      return;
    }
    
    try {
      // Register external dependencies first
      await configureDependencies();
      _isInitialized = true;
    } catch (e) {
      // If initialization fails, reset the flag so it can be retried
      _isInitialized = false;
      rethrow;
    }
  }
  
  /// Reset the dependency injection system for testing or hot reload
  static Future<void> reset() async {
    if (getIt.isRegistered()) {
      await getIt.reset();
    }
    _isInitialized = false;
  }
}

/// Service locator shortcuts for easy access
class ServiceLocator {
  static T get<T extends Object>() => getIt<T>();
  
  static T? getOrNull<T extends Object>() {
    if (getIt.isRegistered<T>()) {
      return getIt<T>();
    }
    return null;
  }
  
  static bool isRegistered<T extends Object>() => getIt.isRegistered<T>();
  
  static Future<void> reset() => getIt.reset();
  
  static void registerSingleton<T extends Object>(T instance) {
    if (!getIt.isRegistered<T>()) {
      getIt.registerSingleton<T>(instance);
    }
  }
  
  static void registerLazySingleton<T extends Object>(T Function() factory) {
    if (!getIt.isRegistered<T>()) {
      getIt.registerLazySingleton<T>(factory);
    }
  }
  
  static void registerFactory<T extends Object>(T Function() factory) {
    if (!getIt.isRegistered<T>()) {
      getIt.registerFactory<T>(factory);
    }
  }
}
