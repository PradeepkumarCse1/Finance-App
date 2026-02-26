import 'package:equatable/equatable.dart';
import '../../domain/auth_entity.dart';
enum AuthStatus {
  initial,
  loading,
  otpSent,
  verified,
  authenticated,
  error,
}
class AuthState extends Equatable {

  final AuthStatus status;
  final AuthEntity? authData;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authData,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? authData,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authData: authData ?? this.authData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, authData, errorMessage];
}