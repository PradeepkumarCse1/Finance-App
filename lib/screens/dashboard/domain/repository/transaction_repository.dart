import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionRepository {

  Future<Either<Failure, List<TransactionEntity>>> getTransactions();

  Future<Either<Failure, List<String>>> syncTransactions(
    List<TransactionEntity> transactions,
  );

  Future<Either<Failure, List<String>>> deleteTransactions(
    List<String> ids,
  );
}