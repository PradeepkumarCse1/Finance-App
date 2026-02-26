import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/data/model/transaction_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'transaction_remote_datasource.dart';
class TransactionRemoteDataSourceImpl
    implements TransactionRemoteDataSource {

  final Dio dio;

  TransactionRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async {

    try {

      final response = await dio.get('/transactions/');

      final List list = response.data['transactions'];

      final models =
          list.map((e) => TransactionModel.fromJson(e)).toList();

      return Right(models);
    }

    on DioException catch (e) {

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {

        return Left(NetworkFailure("No Internet Connection"));
      }

      return Left(ServerFailure(
        e.response?.data["message"] ?? "Failed to load transactions",
      ));
    }

    catch (e) {
      return Left(ServerFailure("Unexpected Error"));
    }
  }

  @override
  Future<Either<Failure, List<String>>> syncTransactions(
    List<TransactionModel> transactions,
  ) async {

    try {

      final response = await dio.post(
        '/transactions/add/',
        data: {
          "transactions": transactions.map((e) => {
                "id": e.id,
                "amount": e.amount,
                "note": e.note,
                "type": e.type,
                "category_id": e.categoryId,
                "timestamp": e.timestamp,
              }).toList(),
        },
      );

      final syncedIds =
          List<String>.from(response.data['synced_ids']);

      return Right(syncedIds);
    }

    on DioException catch (e) {

      return Left(ServerFailure(
        e.response?.data["message"] ?? "Sync Failed",
      ));
    }

    catch (e) {
      return Left(ServerFailure("Unexpected Sync Error"));
    }
  }

  @override
  Future<Either<Failure, List<String>>> deleteTransactions(
    List<String> ids,
  ) async {

    try {

       final response = await dio.delete(
      '/transactions/delete/',
      data: {
        "ids": ids,  
      },
    );


      final deletedIds =
          List<String>.from(response.data['deleted_ids']);

      return Right(deletedIds);
    }

    on DioException catch (e) {

      return Left(ServerFailure(
        e.response?.data["message"] ?? "Delete Failed",
      ));
    }

    catch (e) {
      return Left(ServerFailure("Unexpected Delete Error"));
    }
  }
}