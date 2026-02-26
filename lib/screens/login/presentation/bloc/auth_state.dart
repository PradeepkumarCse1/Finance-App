import 'package:equatable/equatable.dart';
import '../../domain/auth_entity.dart';
enum AuthStatus {
  initial,
  loading,
  otpSent,
  otpResent,
  verified,          //  OTP VALID
  authenticated,     //  EXISTING USER DONE
  newUser,           //  NEED NICKNAME
  error,
}

class AuthState extends Equatable {

  final AuthStatus status;

  /// ✅ API Response Data
  final AuthEntity? authData;

  /// ✅ Error Handling
  final String? errorMessage;

  /// ✅ Session Data
  final String? token;
  final String? nickname;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authData,
    this.errorMessage,
    this.token,
    this.nickname,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? authData,
    String? errorMessage,
    String? token,
    String? nickname,
  }) {
    return AuthState(
      status: status ?? this.status,
      authData: authData ?? this.authData,
      errorMessage: errorMessage,
      token: token ?? this.token,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  List<Object?> get props => [
        status,
        authData,
        errorMessage,
        token,
        nickname,
      ];
}