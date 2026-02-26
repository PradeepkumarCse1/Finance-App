import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:application/screens/name_page/data/datasource/name_remote_data_source.dart';
import 'package:application/screens/name_page/domain/repository/name_repository.dart';
import 'package:dartz/dartz.dart';


class NameRepositoryImpl implements NameRepository {

  final NameRemoteDataSource remoteDataSource;

  NameRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> createAccount(String name, String phoneNumber) async {

    final result = await remoteDataSource.createAccount(name, phoneNumber);

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}