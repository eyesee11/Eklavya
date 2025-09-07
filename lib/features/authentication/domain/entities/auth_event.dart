import 'package:equatable/equatable.dart';

/// Authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check if user is already authenticated (app startup)
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// User login event
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

/// User registration event
class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String? phoneNumber;
  final bool agreeToTerms;

  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.phoneNumber,
    required this.agreeToTerms,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        phoneNumber,
        agreeToTerms,
      ];
}

/// User logout event
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Password reset event
class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  const AuthPasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Profile update event
class AuthProfileUpdateRequested extends AuthEvent {
  final String? name;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? profilePicture;

  const AuthProfileUpdateRequested({
    this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [name, phoneNumber, dateOfBirth, profilePicture];
}

/// Email verification event
class AuthEmailVerificationRequested extends AuthEvent {
  final String verificationCode;

  const AuthEmailVerificationRequested({required this.verificationCode});

  @override
  List<Object?> get props => [verificationCode];
}

/// Phone number verification event
class AuthPhoneVerificationRequested extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneVerificationRequested({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Verify phone OTP event
class AuthPhoneOTPVerificationRequested extends AuthEvent {
  final String otp;

  const AuthPhoneOTPVerificationRequested({required this.otp});

  @override
  List<Object?> get props => [otp];
}

/// Social login events
class AuthGoogleLoginRequested extends AuthEvent {
  const AuthGoogleLoginRequested();
}

class AuthFacebookLoginRequested extends AuthEvent {
  const AuthFacebookLoginRequested();
}

/// Clear error state
class AuthErrorCleared extends AuthEvent {
  const AuthErrorCleared();
}

/// Refresh token event
class AuthTokenRefreshRequested extends AuthEvent {
  const AuthTokenRefreshRequested();
}
