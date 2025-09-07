import '../entities/auth_state.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Check if user is currently authenticated
  Future<bool> isAuthenticated();

  /// Get current user if authenticated
  Future<User?> getCurrentUser();

  /// Login with email and password
  Future<User> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  /// Register new user
  Future<User> register({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
  });

  /// Logout current user
  Future<void> logout();

  /// Send password reset email
  Future<void> resetPassword({required String email});

  /// Update user profile
  Future<User> updateProfile({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
  });

  /// Verify email with code
  Future<void> verifyEmail({required String verificationCode});

  /// Send phone verification OTP
  Future<void> sendPhoneVerification({required String phoneNumber});

  /// Verify phone with OTP
  Future<void> verifyPhone({required String otp});

  /// Social login methods
  Future<User> loginWithGoogle();
  Future<User> loginWithFacebook();

  /// Refresh authentication token
  Future<String> refreshToken();

  /// Delete user account
  Future<void> deleteAccount();

  /// Update user sports profile
  Future<User> updateSportsProfile({
    String? height,
    String? weight,
    String? gender,
    String? location,
    String? state,
    String? district,
    List<String>? interestedSports,
    String? experience,
    String? preferredLanguage,
    bool? isRuralArea,
  });

  /// Get authentication token
  Future<String?> getToken();

  /// Check if token is valid
  Future<bool> isTokenValid();

  /// Get user by ID
  Future<User?> getUserById(String userId);
}
