import 'package:dio/dio.dart';
import '../../../../core/network/network_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';

/// Remote authentication data source for API calls
class AuthRemoteDataSource {
  final NetworkClient _networkClient;

  AuthRemoteDataSource({required NetworkClient networkClient})
      : _networkClient = networkClient;

  /// Login with email and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
          'remember_me': rememberMe,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Login failed',
          code: 'LOGIN_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'An unexpected error occurred during login',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Register new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phoneNumber != null) 'phone_number': phoneNumber,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Registration failed',
          code: 'REGISTRATION_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'An unexpected error occurred during registration',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Get current user data
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _networkClient.get(ApiConstants.userProfileEndpoint);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Failed to get user data',
          code: 'USER_DATA_ERROR',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to retrieve user data',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (phoneNumber != null) data['phone_number'] = phoneNumber;
      if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth.toIso8601String();
      if (profilePicture != null) data['profile_picture'] = profilePicture;

      final response = await _networkClient.put(
        ApiConstants.userProfileEndpoint,
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Profile update failed',
          code: 'PROFILE_UPDATE_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to update profile',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Send password reset email
  Future<void> resetPassword({required String email}) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.passwordResetEndpoint,
        data: {'email': email},
      );

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'Password reset failed',
          code: 'PASSWORD_RESET_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to send password reset email',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Verify email with code
  Future<void> verifyEmail({required String verificationCode}) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.emailVerificationEndpoint,
        data: {'verification_code': verificationCode},
      );

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'Email verification failed',
          code: 'EMAIL_VERIFICATION_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to verify email',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Send phone verification OTP
  Future<void> sendPhoneVerification({required String phoneNumber}) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.phoneVerificationEndpoint,
        data: {'phone_number': phoneNumber},
      );

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'Phone verification failed',
          code: 'PHONE_VERIFICATION_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to send phone verification',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Verify phone with OTP
  Future<void> verifyPhone({required String otp}) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.phoneOtpVerificationEndpoint,
        data: {'otp': otp},
      );

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'OTP verification failed',
          code: 'OTP_VERIFICATION_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to verify OTP',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Refresh authentication token
  Future<Map<String, dynamic>> refreshToken({required String refreshToken}) async {
    try {
      final response = await _networkClient.post(
        ApiConstants.refreshTokenEndpoint,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Token refresh failed',
          code: 'TOKEN_REFRESH_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to refresh token',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      final response = await _networkClient.post(ApiConstants.logoutEndpoint);

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'Logout failed',
          code: 'LOGOUT_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to logout',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Google login (placeholder - would integrate with Google Sign-In)
  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      // In a real implementation, you would:
      // 1. Use Google Sign-In to get Google auth token
      // 2. Send the token to your backend for verification
      // 3. Return user data and JWT token from your backend
      
      throw AuthException(
        message: 'Google login not implemented yet',
        code: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      throw AuthException(
        message: 'Google login failed',
        code: 'GOOGLE_LOGIN_FAILED',
      );
    }
  }

  /// Facebook login (placeholder - would integrate with Facebook Login)
  Future<Map<String, dynamic>> loginWithFacebook() async {
    try {
      // In a real implementation, you would:
      // 1. Use Facebook Login to get Facebook auth token
      // 2. Send the token to your backend for verification
      // 3. Return user data and JWT token from your backend
      
      throw AuthException(
        message: 'Facebook login not implemented yet',
        code: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      throw AuthException(
        message: 'Facebook login failed',
        code: 'FACEBOOK_LOGIN_FAILED',
      );
    }
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      final response = await _networkClient.delete(ApiConstants.deleteAccountEndpoint);

      if (response.statusCode != 200) {
        throw AuthException(
          message: response.data['message'] ?? 'Account deletion failed',
          code: 'ACCOUNT_DELETION_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to delete account',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Update sports profile
  Future<Map<String, dynamic>> updateSportsProfile({
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
  }) async {
    try {
      final data = <String, dynamic>{};
      if (height != null) data['height'] = height;
      if (weight != null) data['weight'] = weight;
      if (gender != null) data['gender'] = gender;
      if (location != null) data['location'] = location;
      if (state != null) data['state'] = state;
      if (district != null) data['district'] = district;
      if (interestedSports != null) data['interested_sports'] = interestedSports;
      if (experience != null) data['experience'] = experience;
      if (preferredLanguage != null) data['preferred_language'] = preferredLanguage;
      if (isRuralArea != null) data['is_rural_area'] = isRuralArea;

      final response = await _networkClient.put(
        ApiConstants.sportsProfileEndpoint,
        data: {'profile': data},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw AuthException(
          message: response.data['message'] ?? 'Sports profile update failed',
          code: 'SPORTS_PROFILE_UPDATE_FAILED',
        );
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthException(
        message: 'Failed to update sports profile',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  /// Handle Dio exceptions and convert to appropriate custom exceptions
  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(message: 'Connection timeout. Please try again.');
      
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        
        if (statusCode == 401) {
          return AuthException(
            message: data?['message'] ?? 'Authentication failed',
            code: 'UNAUTHORIZED',
          );
        } else if (statusCode == 422) {
          return ValidationException(
            message: data?['message'] ?? 'Validation failed',
            errors: data?['errors'] != null 
                ? Map<String, List<String>>.from(
                    (data!['errors'] as Map<String, dynamic>).map(
                      (key, value) => MapEntry(key, List<String>.from(value as List))
                    )
                  )
                : null,
          );
        } else if (statusCode == 500) {
          return ServerException(
            message: data?['message'] ?? 'Internal server error',
          );
        } else {
          return NetworkException(
            message: data?['message'] ?? 'Network error occurred',
          );
        }
      
      case DioExceptionType.cancel:
        return NetworkException(message: 'Request was cancelled');
      
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network.',
        );
      
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: 'An unexpected network error occurred',
        );
    }
  }
}
