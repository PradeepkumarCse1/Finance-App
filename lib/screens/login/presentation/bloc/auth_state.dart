
import 'package:application/screens/login/domain/auth_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSentState extends AuthState {
  final AuthEntity authData;

  OtpSentState(this.authData);
}

class AuthenticatedState extends AuthState {
  final String token;
  AuthenticatedState(this.token);
}

class NewUserState extends AuthState {
  final String phone;
  NewUserState(this.phone);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}