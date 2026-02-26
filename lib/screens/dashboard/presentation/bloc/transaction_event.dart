import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';

abstract class TransactionEvent {}

class LoadTransactionsEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  AddTransactionEvent(this.transaction);
}

class DeleteTransactionEvent extends TransactionEvent {
  final String id;

  DeleteTransactionEvent(this.id);
}

class SyncTransactionsEvent extends TransactionEvent {}