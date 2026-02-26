import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {

  final String id;
  final double amount;
  final String note;
  final String type;

  final String categoryId;     // ✅ RELATIONAL FK
  final String categoryName;   // ✅ UI DISPLAY

  final String timestamp;

  final bool isSynced;   // ✅ Sync Engine
  final bool isDeleted;  // ✅ Soft Delete

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.note,
    required this.type,
    required this.categoryId,
    required this.categoryName,
    required this.timestamp,
    this.isSynced = false,
    this.isDeleted = false,
  });

  /// ✅ VERY IMPORTANT FOR THIS CHALLENGE 😎🔥
  TransactionEntity copyWith({
    String? id,
    double? amount,
    String? note,
    String? type,
    String? categoryId,
    String? categoryName,
    String? timestamp,
    bool? isSynced,
    bool? isDeleted,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        note,
        type,
        categoryId,
        categoryName,
        timestamp,
        isSynced,
        isDeleted,
      ];
}