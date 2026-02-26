import 'package:application/screens/dashboard/data/model/transaction_model.dart';
import 'package:dio/dio.dart';
import 'transaction_remote_datasource.dart';

class TransactionRemoteDataSourceImpl
    implements TransactionRemoteDataSource {

  final Dio dio;

  TransactionRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TransactionModel>> getTransactions() async {

    final response = await dio.get('/transactions/');

    final List list = response.data['transactions'];

    return list.map((e) => TransactionModel.fromJson(e)).toList();
  }

  @override
  Future<List<String>> syncTransactions(
    List<TransactionModel> transactions,
  ) async {

    final response = await dio.post(
      '/transactions/add/',
      data: {
        "transactions": transactions.map((e) => {
              "id": e.id,
              "amount": e.amount,
              "note": e.note,
              "type": e.type,
              "category_id": e.category,
              "timestamp": e.timestamp,
            }).toList(),
      },
    );

    return List<String>.from(response.data['synced_ids']);
  }

  @override
  Future<List<String>> deleteTransactions(
    List<String> ids,
  ) async {

    final response = await dio.delete(
      '/transactions/delete/',
      data: { "ids": ids },
    );

    return List<String>.from(response.data['deleted_ids']);
  }
}