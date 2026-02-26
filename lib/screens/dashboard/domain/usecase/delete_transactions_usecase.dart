import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/domain/repository/transaction_repository.dart';
import 'package:dartz/dartz.dart';


class DeleteTransactionsUseCase {

  final TransactionRepository repository;

  DeleteTransactionsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(
    List<String> ids,
  ) {
    return repository.deleteTransactions(ids);
  }
}