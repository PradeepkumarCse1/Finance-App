import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:application/screens/dashboard/domain/repository/transaction_repository.dart';
import 'package:dartz/dartz.dart';


class GetTransactionsUseCase {

  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() {
    return repository.getTransactions();
  }
}