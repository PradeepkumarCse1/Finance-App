import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';


class TransactionModel extends TransactionEntity {

  const TransactionModel({
    required super.id,
    required super.amount,
    required super.note,
    required super.type,
    required super.category,
    required super.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {

    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      note: json['note'],
      type: json['type'],
      category: json['category'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "note": note,
      "type": type,
      "category_id": category,
      "timestamp": timestamp,
    };
  }
}