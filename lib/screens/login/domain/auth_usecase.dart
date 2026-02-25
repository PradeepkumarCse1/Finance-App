import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendOtpUseCase {

  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(String phone) {
    return repository.sendOtp(phone);
  }
}