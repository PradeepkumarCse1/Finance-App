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

  final result = await remoteDataSource.getTransactions();

  return result.fold(

    /// ❌ FAILURE → PASS THROUGH
    (failure) => Left(failure),

    /// ✅ SUCCESS → MAP MODEL → ENTITY
    (models) => Right(
      models.map((e) => e.toEntity()).toList(),
    ),
  );
}
@override
Future<Either<Failure, List<String>>> syncTransactions(
  List<TransactionEntity> transactions,
) async {

  final models = transactions.map((e) => TransactionModel(
        id: e.id,
        amount: e.amount,
        note: e.note,
        type: e.type,
        categoryId: e.categoryId,
        categoryName: e.categoryName,
        timestamp: e.timestamp,
      )).toList();

  final result = await remoteDataSource.syncTransactions(models);

  return result.fold(

    (failure) => Left(failure),

    (syncedIds) => Right(syncedIds),
  );
}
@override
Future<Either<Failure, List<String>>> deleteTransactions(
  List<String> ids,
) async {

  final result = await remoteDataSource.deleteTransactions(ids);

  return result.fold(

    (failure) => Left(failure),

    (deletedIds) => Right(deletedIds),
  );
}
}