import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String note;
  final String type;
  final String category;
  final String timestamp;

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.note,
    required this.type,
    required this.category,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        note,
        type,
        category,
        timestamp,
      ];
}