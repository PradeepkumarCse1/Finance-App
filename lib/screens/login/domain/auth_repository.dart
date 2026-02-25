import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRepository {

  Future<Either<Failure, AuthEntity>> sendOtp(String phone);
}