
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:application/screens/login/domain/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<AuthEntity> call(String phone) {
    return repository.sendOtp(phone);
  }
}