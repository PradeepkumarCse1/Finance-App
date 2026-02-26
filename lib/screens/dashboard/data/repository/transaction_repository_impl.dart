import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/data/model/transaction_model.dart';
import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:application/screens/dashboard/domain/repository/transaction_repository.dart';
import 'package:dartz/dartz.dart';
import '../datasource/transaction_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {

  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {

    try {
      final result = await remoteDataSource.getTransactions();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> syncTransactions(
    List<TransactionEntity> transactions,
  ) async {

    try {

      final models = transactions.map((e) => TransactionModel(
            id: e.id,
            amount: e.amount,
            note: e.note,
            type: e.type,
            category: e.category,
            timestamp: e.timestamp,
          )).toList();

      final result =
          await remoteDataSource.syncTransactions(models);

      return Right(result);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> deleteTransactions(
    List<String> ids,
  ) async {

    try {
      final result =
          await remoteDataSource.deleteTransactions(ids);

      return Right(result);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}