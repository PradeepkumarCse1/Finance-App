import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:application/screens/dashboard/domain/usecase/delete_transactions_usecase.dart';
import 'package:application/screens/dashboard/domain/usecase/get_transactions_usecase.dart';
import 'package:application/screens/dashboard/domain/usecase/sync_transactions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {

  final GetTransactionsUseCase getTransactionsUseCase;
  final SyncTransactionsUseCase syncTransactionsUseCase;
  final DeleteTransactionsUseCase deleteTransactionsUseCase;

  TransactionBloc({
    required this.getTransactionsUseCase,
    required this.syncTransactionsUseCase,
    required this.deleteTransactionsUseCase,
  }) : super(const TransactionState()) {

    /// ✅ LOAD TRANSACTIONS
    on<LoadTransactionsEvent>((event, emit) async {

      emit(state.copyWith(status: TransactionStatus.loading));

      final result = await getTransactionsUseCase();

      result.fold(

        /// ❌ FAILURE
        (failure) {
          emit(
            state.copyWith(
              status: TransactionStatus.error,
              errorMessage: failure.message,
            ),
          );
        },

        /// ✅ SUCCESS
        (transactions) {

          final income = _calculateIncome(transactions);
          final expense = _calculateExpense(transactions);

          emit(
            state.copyWith(
              status: TransactionStatus.loaded,
              transactions: transactions,
              totalIncome: income,
              totalExpense: expense,
            ),
          );
        },
      );
    });

    /// ✅ ADD TRANSACTION (Instant UI)
    on<AddTransactionEvent>((event, emit) {

      final updatedList = List<TransactionEntity>.from(state.transactions)
        ..insert(0, event.transaction);

      emit(
        state.copyWith(
          transactions: updatedList,
          totalIncome: _calculateIncome(updatedList),
          totalExpense: _calculateExpense(updatedList),
        ),
      );
    });

    /// ✅ SOFT DELETE (Instant UI)
    on<DeleteTransactionEvent>((event, emit) {

      final updatedList =
          state.transactions.where((t) => t.id != event.id).toList();

      emit(
        state.copyWith(
          transactions: updatedList,
          totalIncome: _calculateIncome(updatedList),
          totalExpense: _calculateExpense(updatedList),
        ),
      );
    });

    /// ✅ SYNC WORKFLOW
    on<SyncTransactionsEvent>((event, emit) async {

      emit(state.copyWith(status: TransactionStatus.syncing));

      final result =
          await syncTransactionsUseCase(state.transactions);

      result.fold(

        /// ❌ FAILURE
        (failure) {
          emit(
            state.copyWith(
              status: TransactionStatus.error,
              errorMessage: failure.message,
            ),
          );
        },

        /// ✅ SUCCESS
        (_) {
          emit(state.copyWith(status: TransactionStatus.success));
        },
      );
    });
  }

  // ✅ HELPERS

  double _calculateIncome(List<TransactionEntity> list) {
    return list
        .where((t) => t.type.toLowerCase() == "credit")
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double _calculateExpense(List<TransactionEntity> list) {
    return list
        .where((t) => t.type.toLowerCase() == "debit")
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}