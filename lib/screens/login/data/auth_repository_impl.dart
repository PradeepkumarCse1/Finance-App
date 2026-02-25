import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:dartz/dartz.dart';


class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> sendOtp(String phone) async {

    final result = await remoteDataSource.sendOtp(phone);

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}