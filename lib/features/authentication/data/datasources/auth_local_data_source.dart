import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/auth_state.dart';
import '../../../../core/errors/exceptions.dart';

/// Local authentication data source for storing user data locally
class AuthLocalDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _rememberMeKey = 'remember_me';
  static const String _lastLoginKey = 'last_login';

  final SharedPreferences _prefs;

  AuthLocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  /// Save authentication token
  Future<void> saveToken(String token) async {
    try {
      await _prefs.setString(_tokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to save authentication token');
    }
  }

  /// Get authentication token
  Future<String?> getToken() async {
    try {
      return _prefs.getString(_tokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve authentication token');
    }
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _prefs.setString(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw CacheException(message: 'Failed to save refresh token');
    }
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    try {
      return _prefs.getString(_refreshTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve refresh token');
    }
  }

  /// Save user data locally
  Future<void> saveUser(User user) async {
    try {
      final userJson = json.encode(user.toJson());
      await _prefs.setString(_userKey, userJson);
    } catch (e) {
      throw CacheException(message: 'Failed to save user data');
    }
  }

  /// Get cached user data
  Future<User?> getCachedUser() async {
    try {
      final userJson = _prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        return User.fromJson(userMap);
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve user data');
    }
  }

  /// Clear all authentication data
  Future<void> clearAuthData() async {
    try {
      await Future.wait([
        _prefs.remove(_tokenKey),
        _prefs.remove(_refreshTokenKey),
        _prefs.remove(_userKey),
        _prefs.remove(_rememberMeKey),
        _prefs.remove(_lastLoginKey),
      ]);
    } catch (e) {
      throw CacheException(message: 'Failed to clear authentication data');
    }
  }

  /// Check if user data exists locally
  Future<bool> hasAuthData() async {
    try {
      final token = _prefs.getString(_tokenKey);
      final user = _prefs.getString(_userKey);
      return token != null && user != null;
    } catch (e) {
      return false;
    }
  }

  /// Save remember me preference
  Future<void> saveRememberMe(bool rememberMe) async {
    try {
      await _prefs.setBool(_rememberMeKey, rememberMe);
    } catch (e) {
      throw CacheException(message: 'Failed to save remember me preference');
    }
  }

  /// Get remember me preference
  Future<bool> getRememberMe() async {
    try {
      return _prefs.getBool(_rememberMeKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Save last login timestamp
  Future<void> saveLastLogin() async {
    try {
      await _prefs.setString(_lastLoginKey, DateTime.now().toIso8601String());
    } catch (e) {
      throw CacheException(message: 'Failed to save last login timestamp');
    }
  }

  /// Get last login timestamp
  Future<DateTime?> getLastLogin() async {
    try {
      final lastLoginStr = _prefs.getString(_lastLoginKey);
      if (lastLoginStr != null) {
        return DateTime.parse(lastLoginStr);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if token is expired (basic check based on timestamp)
  Future<bool> isTokenExpired() async {
    try {
      final lastLogin = await getLastLogin();
      if (lastLogin == null) return true;
      
      // Consider token expired after 24 hours (adjust as needed)
      final expirationTime = lastLogin.add(const Duration(hours: 24));
      return DateTime.now().isAfter(expirationTime);
    } catch (e) {
      return true;
    }
  }

  /// Save user preferences
  Future<void> saveUserPreferences(Map<String, dynamic> preferences) async {
    try {
      final prefsJson = json.encode(preferences);
      await _prefs.setString('user_preferences', prefsJson);
    } catch (e) {
      throw CacheException(message: 'Failed to save user preferences');
    }
  }

  /// Get user preferences
  Future<Map<String, dynamic>?> getUserPreferences() async {
    try {
      final prefsJson = _prefs.getString('user_preferences');
      if (prefsJson != null) {
        return json.decode(prefsJson) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Update specific user preference
  Future<void> updateUserPreference(String key, dynamic value) async {
    try {
      final preferences = await getUserPreferences() ?? <String, dynamic>{};
      preferences[key] = value;
      await saveUserPreferences(preferences);
    } catch (e) {
      throw CacheException(message: 'Failed to update user preference');
    }
  }
}
