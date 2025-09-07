import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/auth_event.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/errors/exceptions.dart';

/// Authentication BLoC for handling user authentication
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthInitial()) {
    // Register event handlers
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthProfileUpdateRequested>(_onAuthProfileUpdateRequested);
    on<AuthEmailVerificationRequested>(_onAuthEmailVerificationRequested);
    on<AuthPhoneVerificationRequested>(_onAuthPhoneVerificationRequested);
    on<AuthPhoneOTPVerificationRequested>(_onAuthPhoneOTPVerificationRequested);
    on<AuthGoogleLoginRequested>(_onAuthGoogleLoginRequested);
    on<AuthFacebookLoginRequested>(_onAuthFacebookLoginRequested);
    on<AuthErrorCleared>(_onAuthErrorCleared);
    on<AuthTokenRefreshRequested>(_onAuthTokenRefreshRequested);
  }

  /// Check if user is authenticated on app startup
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final isAuthenticated = await _authRepository.isAuthenticated();
      
      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle user login
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      // Validate input
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(const AuthError(
          message: 'Please enter both email and password',
          errorCode: 'INVALID_INPUT',
        ));
        return;
      }
      
      if (!_isValidEmail(event.email)) {
        emit(const AuthError(
          message: 'Please enter a valid email address',
          errorCode: 'INVALID_EMAIL',
        ));
        return;
      }
      
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
        rememberMe: event.rememberMe,
      );
      
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle user registration
  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      // Validate input
      final validationError = _validateRegistrationInput(event);
      if (validationError != null) {
        emit(AuthError(
          message: validationError,
          errorCode: 'VALIDATION_ERROR',
        ));
        return;
      }
      
      final user = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
      );
      
      emit(const AuthRegistrationSuccess(
        message: 'Registration successful! Please verify your email.',
      ));
      
      // Auto-login after registration
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle user logout
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await _authRepository.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle password reset
  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      if (!_isValidEmail(event.email)) {
        emit(const AuthError(
          message: 'Please enter a valid email address',
          errorCode: 'INVALID_EMAIL',
        ));
        return;
      }
      
      await _authRepository.resetPassword(email: event.email);
      emit(AuthPasswordResetSent(email: event.email));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle profile update
  Future<void> _onAuthProfileUpdateRequested(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      
      final updatedUser = await _authRepository.updateProfile(
        name: event.name,
        phoneNumber: event.phoneNumber,
        dateOfBirth: event.dateOfBirth,
        profilePicture: event.profilePicture,
      );
      
      emit(AuthProfileUpdated(user: updatedUser));
      emit(AuthAuthenticated(user: updatedUser));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle email verification
  Future<void> _onAuthEmailVerificationRequested(
    AuthEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await _authRepository.verifyEmail(verificationCode: event.verificationCode);
      
      // Refresh user data
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle phone verification
  Future<void> _onAuthPhoneVerificationRequested(
    AuthPhoneVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await _authRepository.sendPhoneVerification(phoneNumber: event.phoneNumber);
      
      // Return to authenticated state, waiting for OTP
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle phone OTP verification
  Future<void> _onAuthPhoneOTPVerificationRequested(
    AuthPhoneOTPVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await _authRepository.verifyPhone(otp: event.otp);
      
      // Refresh user data
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle Google login
  Future<void> _onAuthGoogleLoginRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      final user = await _authRepository.loginWithGoogle();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Handle Facebook login
  Future<void> _onAuthFacebookLoginRequested(
    AuthFacebookLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      final user = await _authRepository.loginWithFacebook();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(
        message: _getErrorMessage(e),
        errorCode: _getErrorCode(e),
      ));
    }
  }

  /// Clear error state
  Future<void> _onAuthErrorCleared(
    AuthErrorCleared event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle token refresh
  Future<void> _onAuthTokenRefreshRequested(
    AuthTokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.refreshToken();
      // Token refreshed successfully, maintain current state
    } catch (e) {
      // Token refresh failed, logout user
      emit(const AuthUnauthenticated());
    }
  }

  /// Validate registration input
  String? _validateRegistrationInput(AuthRegisterRequested event) {
    if (event.name.trim().isEmpty) {
      return 'Please enter your full name';
    }
    
    if (event.name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    if (event.email.isEmpty) {
      return 'Please enter your email address';
    }
    
    if (!_isValidEmail(event.email)) {
      return 'Please enter a valid email address';
    }
    
    if (event.password.isEmpty) {
      return 'Please enter a password';
    }
    
    if (event.password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (event.password != event.confirmPassword) {
      return 'Passwords do not match';
    }
    
    if (!event.agreeToTerms) {
      return 'Please agree to the terms and conditions';
    }
    
    if (event.phoneNumber != null && event.phoneNumber!.isNotEmpty) {
      if (!_isValidPhoneNumber(event.phoneNumber!)) {
        return 'Please enter a valid phone number';
      }
    }
    
    return null;
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate phone number format (Indian format)
  bool _isValidPhoneNumber(String phone) {
    return RegExp(r'^[+]?[91]?[0-9]{10}$').hasMatch(phone.replaceAll(' ', ''));
  }

  /// Extract error message from exception
  String _getErrorMessage(dynamic error) {
    if (error is NetworkException) {
      return 'Network error. Please check your internet connection.';
    } else if (error is AuthException) {
      return error.message;
    } else if (error is ValidationException) {
      return error.message;
    } else if (error is ServerException) {
      return 'Server error. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Extract error code from exception
  String? _getErrorCode(dynamic error) {
    if (error is AuthException) {
      return error.code;
    } else if (error is NetworkException) {
      return 'NETWORK_ERROR';
    } else if (error is ValidationException) {
      return 'VALIDATION_ERROR';
    } else if (error is ServerException) {
      return 'SERVER_ERROR';
    } else {
      return 'UNKNOWN_ERROR';
    }
  }
}
