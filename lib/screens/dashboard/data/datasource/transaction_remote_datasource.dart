
import 'package:application/core/failure/failure.dart';
import 'package:application/screens/dashboard/data/model/transaction_model.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionRemoteDataSource {

  Future<Either<Failure, List<TransactionModel>>> getTransactions();

  Future<Either<Failure, List<String>>> syncTransactions(
    List<TransactionModel> transactions,
  );

  Future<Either<Failure, List<String>>> deleteTransactions(
    List<String> ids,
  );
}