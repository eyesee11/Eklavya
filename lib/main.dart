import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import 'core/di/injection.dart';
import 'core/ai/ai_model_manager.dart';
import 'core/utils/android_performance_utils.dart';
import 'app/app.dart';

/// Global logger instance
final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Set preferred orientations (portrait only for now)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  try {
    // Initialize dependency injection
    logger.i('Initializing dependencies...');
    await DependencyInjection.init();
    logger.i('Dependencies initialized successfully');
    
    // Initialize platform-specific optimizations
    try {
      if (Platform.isAndroid) {
        logger.i('Initializing Android optimizations...');
        await AndroidPerformanceUtils.instance.initialize();
        
        // Initialize AI models in background
        AIModelManager.instance.initialize().catchError((error) {
          logger.w('AI model initialization failed: $error');
        });
      }
    } catch (e) {
      // Platform operations not supported on web - this is expected
      logger.d('Platform-specific initialization skipped (web platform)');
    }
    
    // Run the app
    runApp(const SportsAssessmentApp());
  } catch (error, stackTrace) {
    logger.e('Failed to initialize app', error: error, stackTrace: stackTrace);
    
    // Show error screen if initialization fails
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to initialize app',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Restart the app
                  main();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
