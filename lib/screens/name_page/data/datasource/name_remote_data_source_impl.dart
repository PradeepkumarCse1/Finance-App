import 'package:application/core/failure/failure.dart';
import 'package:application/screens/login/data/auth_model.dart';
import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:application/screens/name_page/data/datasource/name_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
class NameRemoteDataSourceImpl implements NameRemoteDataSource {
  final Dio dio;

  NameRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, String>> createAccount(
      String name,
      String phoneNumber,
  ) async {
    try {
      final response = await dio.post(
        '/auth/create-account/',
        data: {
          "phone": phoneNumber,
          "nickname": name,
        },
      );
        final status = response.data['status'];
      if (response.statusCode == 200 && status=="success") {
        final token = response.data['token'];
        return Right(token);
      } else {
        return Left(ServerFailure("Something went wrong on the server"));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkFailure("No internet connection"));
      }

      return Left(ServerFailure("Server error"));
    } catch (_) {
      return Left(ServerFailure("Unexpected error"));
    }
  }
}