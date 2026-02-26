import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:application/screens/dashboard/domain/repository/transaction_repository.dart';
import 'package:dartz/dartz.dart';


class SyncTransactionsUseCase {

  final TransactionRepository repository;

  SyncTransactionsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(
    List<TransactionEntity> transactions,
  ) {
    return repository.syncTransactions(transactions);
  }
}