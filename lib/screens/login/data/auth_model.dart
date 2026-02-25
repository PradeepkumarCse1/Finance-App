
import 'package:application/screens/login/domain/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required String status,
    required String otp,
    required bool userExists,
    required String? nickname,
    required String token,
  }) : super(
          status: status,
          otp: otp,
          userExists: userExists,
          nickname: nickname,
          token: token,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'],
      otp: json['otp'],
      userExists: json['user_exists'],
      nickname: json['nickname'],
      token: json['token'],
    );
  }
}