import 'package:equatable/equatable.dart';

/// User authentication state
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state - checking if user is authenticated
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// User is authenticated
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Authentication loading state
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authentication error state
class AuthError extends AuthState {
  final String message;
  final String? errorCode;

  const AuthError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

/// Registration success state
class AuthRegistrationSuccess extends AuthState {
  final String message;

  const AuthRegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Password reset success state
class AuthPasswordResetSent extends AuthState {
  final String email;

  const AuthPasswordResetSent({required this.email});

  @override
  List<Object?> get props => [email];
}

/// User profile update success
class AuthProfileUpdated extends AuthState {
  final User user;

  const AuthProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// User model
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? profilePicture;
  final UserProfile? profile;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.profilePicture,
    this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phoneNumber,
        dateOfBirth,
        profilePicture,
        profile,
        createdAt,
        updatedAt,
      ];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
    UserProfile? profile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      profile: profile ?? this.profile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'profile_picture': profilePicture,
      'profile': profile?.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      profilePicture: json['profile_picture'] as String?,
      profile: json['profile'] != null
          ? UserProfile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

/// User profile with sports-specific information
class UserProfile extends Equatable {
  final String? height; // in cm
  final String? weight; // in kg
  final String? gender;
  final String? location;
  final String? state;
  final String? district;
  final List<String> interestedSports;
  final String? experience; // beginner, intermediate, advanced
  final String? preferredLanguage;
  final bool isRuralArea;

  const UserProfile({
    this.height,
    this.weight,
    this.gender,
    this.location,
    this.state,
    this.district,
    this.interestedSports = const [],
    this.experience,
    this.preferredLanguage,
    this.isRuralArea = false,
  });

  @override
  List<Object?> get props => [
        height,
        weight,
        gender,
        location,
        state,
        district,
        interestedSports,
        experience,
        preferredLanguage,
        isRuralArea,
      ];

  UserProfile copyWith({
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
  }) {
    return UserProfile(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      state: state ?? this.state,
      district: district ?? this.district,
      interestedSports: interestedSports ?? this.interestedSports,
      experience: experience ?? this.experience,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isRuralArea: isRuralArea ?? this.isRuralArea,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'gender': gender,
      'location': location,
      'state': state,
      'district': district,
      'interested_sports': interestedSports,
      'experience': experience,
      'preferred_language': preferredLanguage,
      'is_rural_area': isRuralArea,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      gender: json['gender'] as String?,
      location: json['location'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      interestedSports: json['interested_sports'] != null
          ? List<String>.from(json['interested_sports'] as List)
          : [],
      experience: json['experience'] as String?,
      preferredLanguage: json['preferred_language'] as String?,
      isRuralArea: json['is_rural_area'] as bool? ?? false,
    );
  }
}
