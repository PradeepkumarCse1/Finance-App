
import 'package:application/screens/dashboard/data/model/transaction_model.dart';

abstract class TransactionRemoteDataSource {

  Future<List<TransactionModel>> getTransactions();

  Future<List<String>> syncTransactions(
    List<TransactionModel> transactions,
  );

  Future<List<String>> deleteTransactions(
    List<String> ids,
  );
}