import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/data/auth_model.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthModel>> sendOtp(String phone);
}