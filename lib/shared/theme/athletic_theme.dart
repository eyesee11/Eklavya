import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Athletic/Sports app theme inspired by Nike Training Club & Adidas Training
class AthleticTheme {
  static const Color primaryRed = Color(0xFFFF6B35);
  static const Color primaryBlue = Color(0xFF0066CC);
  static const Color darkBlue = Color(0xFF1A237E);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color electricBlue = Color(0xFF00D4FF);
  
  // Nike-inspired colors
  static const Color nikeOrange = Color(0xFFFF6B35);
  static const Color nikeBlack = Color(0xFF111111);
  static const Color nikeGray = Color(0xFF707070);
  static const Color nikeWhite = Color(0xFFFAFAFA);
  
  // Adidas-inspired colors  
  static const Color adidasBlue = Color(0xFF0066CC);
  static const Color adidasDark = Color(0xFF000000);
  static const Color adidasGreen = Color(0xFF00A651);
  
  // Quick access getters
  static Color get primary => nikeOrange;
  static Color get background => nikeBlack;
  static Color get cardBackground => Color(0xFF2C2C2C);
  static Color get textPrimary => nikeWhite;
  static Color get textSecondary => nikeGray;
  
  // Gradient definitions
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A237E),
      Color(0xFF0066CC),
      Color(0xFF00D4FF),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2C2C2C),
      Color(0xFF1A1A1A),
    ],
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFF6B35),
      Color(0xFFFF8A50),
    ],
  );

  /// Main theme data
  static ThemeData get athleticTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: nikeBlack,
      
      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: Color.fromRGBO(255, 107, 53, 1),
        onPrimary: nikeWhite,
        secondary: electricBlue,
        onSecondary: nikeBlack,
        surface: Color(0xFF1A1A1A),
        onSurface: nikeWhite,
        error: Color(0xFFFF4444),
        onError: nikeWhite,
      ),
      
      // Typography
      textTheme: _buildTextTheme(),
      
      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: nikeWhite),
        titleTextStyle: TextStyle(
          color: nikeWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: nikeOrange,
        unselectedItemColor: nikeGray,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
      ),
      
      // Cards
      cardTheme: CardThemeData(
        color: const Color(0xFF2C2C2C),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: nikeOrange,
          foregroundColor: nikeWhite,
          elevation: 8,
          shadowColor: nikeOrange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
  
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      // Headers
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.5,
        color: nikeWhite,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: nikeWhite,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: nikeWhite,
        height: 1.3,
      ),
      
      // Headlines
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: nikeWhite,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: nikeWhite,
        height: 1.4,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: nikeWhite,
        height: 1.4,
      ),
      
      // Body text
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: nikeWhite,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: nikeGray,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: nikeGray,
        height: 1.4,
      ),
      
      // Labels
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
        color: nikeWhite,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        color: nikeGray,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: nikeGray,
        height: 1.4,
      ),
    );
  }
}

/// Custom button styles for athletic theme
class AthleticButtons {
  static ButtonStyle get primary => ElevatedButton.styleFrom(
    backgroundColor: AthleticTheme.nikeOrange,
    foregroundColor: AthleticTheme.nikeWhite,
    elevation: 8,
    shadowColor: AthleticTheme.nikeOrange.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );
  
  static ButtonStyle get secondary => ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AthleticTheme.electricBlue,
    side: const BorderSide(color: AthleticTheme.electricBlue, width: 2),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );
  
  static ButtonStyle get gradient => ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AthleticTheme.nikeWhite,
    elevation: 8,
    shadowColor: AthleticTheme.nikeOrange.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );
}

/// Custom card styles for athletic theme
class AthleticCards {
  static BoxDecoration get glass => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.05),
      ],
    ),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
  
  static BoxDecoration get workout => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: AthleticTheme.cardGradient,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );
  
  static BoxDecoration get hero => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: AthleticTheme.heroGradient,
    boxShadow: [
      BoxShadow(
        color: AthleticTheme.primaryBlue.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
