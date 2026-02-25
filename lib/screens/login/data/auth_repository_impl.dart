
import 'package:application/screens/login/data/auth_datasource.dart';
import 'package:application/screens/login/domain/auth_entity.dart';
import 'package:application/screens/login/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthEntity> sendOtp(String phone) async {
    return await remoteDataSource.sendOtp(phone);
  }

  @override
  Future<String> createAccount(String phone, String nickname) async {
    return await remoteDataSource.createAccount(phone, nickname);
  }
}