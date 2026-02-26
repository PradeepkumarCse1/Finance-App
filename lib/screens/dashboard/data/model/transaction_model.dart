import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
class TransactionModel extends TransactionEntity {

  const TransactionModel({
    required super.id,
    required super.amount,
    required super.note,
    required super.type,
    required super.categoryId,
    required super.categoryName,
    required super.timestamp,
    super.isSynced,
    super.isDeleted,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {

    return TransactionModel(

      ///  NEVER TRUST API 😎🔥
      id: json['id']?.toString() ?? "",

      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,

      note: json['note']?.toString() ?? "",

      type: json['type']?.toString() ?? "debit",

      ///  API RETURNS CATEGORY NAME (NOT ID)
      categoryId: "",   // handled locally via JOIN / mapping

      categoryName: json['category']?.toString() ?? "Unknown",

      timestamp: json['timestamp']?.toString() ?? "",

      ///  CLOUD DATA IS ALREADY SYNCED
      isSynced: true,

      isDeleted: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "note": note,
      "type": type,
      "category_id": categoryId,  
      "timestamp": timestamp,
    };
  }  TransactionEntity toEntity() {

    return TransactionEntity(
      id: id,
      amount: amount,
      note: note,
      type: type,
      categoryId: categoryId,
      categoryName: categoryName,
      timestamp: timestamp,
      isSynced: isSynced,
      isDeleted: isDeleted,
    );
  }
}