import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../shared/theme/app_theme.dart';
import '../shared/widgets/app_error_widget.dart';
import 'routes.dart';

/// Main application widget
class SportsAssessmentApp extends StatelessWidget {
  const SportsAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      // Routing
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.splash,
      
      // Error handling
      builder: (context, widget) {
        // Handle global errors
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return AppErrorWidget(
            error: errorDetails.exception.toString(),
            onRetry: () {
              // TODO: Implement global error recovery
            },
          );
        };
        
        return widget ?? const SizedBox.shrink();
      },
      
      // Localization (for future internationalization)
      locale: const Locale('en', 'US'),
      
      // Performance optimization
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,
      showPerformanceOverlay: false,
    );
  }
}
