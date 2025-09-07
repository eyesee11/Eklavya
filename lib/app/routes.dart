import 'package:flutter/material.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/authentication/presentation/pages/login_page.dart';
import '../features/authentication/presentation/pages/register_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/video_recording/presentation/pages/test_selection_page.dart';
import '../features/video_recording/presentation/pages/camera_page.dart';
import '../features/ai_analysis/presentation/pages/analysis_loading_page.dart';
import '../features/ai_analysis/presentation/pages/results_page.dart';


/// Application routes configuration
class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String testSelection = '/test-selection';
  static const String camera = '/camera';
  static const String analysisLoading = '/analysis-loading';
  static const String results = '/results';

  /// Generate routes based on route settings
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(
          const SplashPage(),
          settings: settings,
        );

      case onboarding:
        return _buildRoute(
          const OnboardingPage(),
          settings: settings,
        );

      case login:
        return _buildRoute(
          const LoginPage(),
          settings: settings,
        );

      case register:
        return _buildRoute(
          const RegisterPage(),
          settings: settings,
        );

      case home:
        return _buildRoute(
          const HomePage(),
          settings: settings,
        );

      case profile:
        return _buildRoute(
          const ProfilePage(),
          settings: settings,
        );

      case testSelection:
        return _buildRoute(
          const TestSelectionPage(),
          settings: settings,
        );

      case camera:
        return _buildRoute(
          const CameraPage(),
          settings: settings,
        );

      case analysisLoading:
        return _buildRoute(
          const AnalysisLoadingPage(),
          settings: settings,
        );

      case results:
        return _buildRoute(
          const ResultsPage(),
          settings: settings,
        );

      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('Route "${settings.name}" not found'),
                  const SizedBox(height: 8),
                  const Text('Page not found', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          settings: settings,
        );
    }
  }

  /// Build route with consistent animation
  static Route<dynamic> _buildRoute(
    Widget page, {
    required RouteSettings settings,
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide transition from right to left
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }



  /// Navigation helper methods
  static Future<void> pushAndClearStack(BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  static Future<void> pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> push<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    return Navigator.pop<T>(context, result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}

/// Route arguments classes
class CameraPageArguments {
  final String testType;
  final int testDuration;

  const CameraPageArguments({
    required this.testType,
    required this.testDuration,
  });
}

class AnalysisLoadingPageArguments {
  final String videoPath;
  final String testType;

  const AnalysisLoadingPageArguments({
    required this.videoPath,
    required this.testType,
  });
}

class ResultsPageArguments {
  final Map<String, dynamic>? analysisResult;

  const ResultsPageArguments({
    this.analysisResult,
  });
}
