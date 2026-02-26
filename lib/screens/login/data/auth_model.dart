
import 'package:application/screens/login/domain/auth_entity.dart';

class AuthModel extends AuthEntity {

  AuthModel({
    required super.otp,
    required super.userExists,
    required super.token,
    super.nickname,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      otp: json['otp']??"",
      userExists: json['user_exists']??false,
      nickname: json['nickname']??"",
      token: json['token']??"",
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      otp: otp,
      userExists: userExists,
      token: token,
      nickname: nickname,
    );
  }
}