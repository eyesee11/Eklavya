import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// Application theme configuration
class AppTheme {
  // Color schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: Color(0xFF2196F3),
    onPrimary: Colors.white,
    secondary: Color(0xFF4CAF50),
    onSecondary: Colors.white,
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF212121),
    error: Color(0xFFE57373),
    onError: Colors.white,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: Color(0xFF1976D2),
    onPrimary: Colors.white,
    secondary: Color(0xFF388E3C),
    onSecondary: Colors.white,
    surface: Color(0xFF121212),
    onSurface: Colors.white,
    error: Color(0xFFEF5350),
    onError: Colors.white,
  );

  /// Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusSmall),
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(0xFFE57373), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 4,
        margin: const EdgeInsets.all(UIConstants.spacingSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusLarge),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedItemColor: Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: Color(0xFF2196F3),
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusLarge),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 6,
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF2196F3),
      ),

      // Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: Color(0xFF2196F3),
        inactiveTrackColor: Colors.grey,
        thumbColor: Color(0xFF2196F3),
      ),
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(0xFF444444)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 4,
        margin: const EdgeInsets.all(UIConstants.spacingSmall),
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusLarge),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFF1976D2),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 8,
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusLarge),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 6,
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Get theme data based on brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  /// Custom text styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
}
