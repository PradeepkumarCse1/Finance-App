import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/data/auth_model.dart';
import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, AuthModel>> sendOtp(String phone) async {

    try {

      final response = await dio.post(
        '/auth/send-otp/',
        data: {"phone": phone},
      );

      final model = AuthModel.fromJson(response.data);

      return Right(model);

    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkFailure("No internet connection"));
      }

      if (e.response != null) {
        return Left(
          ValidationFailure(
            e.response!.data['detail'] ?? "OTP failed",
          ),
        );
      }

      return Left(ServerFailure("Server error"));

    } catch (_) {

      return Left(ServerFailure("Unexpected error"));
    }
  }
}