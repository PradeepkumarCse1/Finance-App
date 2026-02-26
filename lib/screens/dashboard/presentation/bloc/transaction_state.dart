import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:equatable/equatable.dart';

enum TransactionStatus {
  initial,
  loading,
  loaded,
  syncing,
  success,
  error,
}


class TransactionState extends Equatable {

  final TransactionStatus status;
  final List<TransactionEntity> transactions;
  final double totalIncome;
  final double totalExpense;
  final String? errorMessage;

  const TransactionState({
    this.status = TransactionStatus.initial,
    this.transactions = const [],
    this.totalIncome = 0,
    this.totalExpense = 0,
    this.errorMessage,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    List<TransactionEntity>? transactions,
    double? totalIncome,
    double? totalExpense,
    String? errorMessage,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        totalIncome,
        totalExpense,
        errorMessage,
      ];
}