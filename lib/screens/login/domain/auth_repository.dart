
import 'package:application/screens/login/domain/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> sendOtp(String phone);
  Future<String> createAccount(String phone, String nickname);
}