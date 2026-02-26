import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_event.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_state.dart';
import 'package:application/screens/dashboard/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {

                  if (state.status == TransactionStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Builder(
  builder: (context) {

    /// ✅ FILTER FIRST (VERY IMPORTANT)
    final visibleTransactions = state.transactions
        .where((t) => !t.isDeleted)
        .toList();

    if (visibleTransactions.isEmpty) {
      return const Center(
        child: Text(
          "No Transactions Found",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: visibleTransactions.length,
      itemBuilder: (context, index) {

        final txn = visibleTransactions[index];

        return TransactionCardWidget(
          transaction: txn,

          /// ✅ DELETE EVENT
          onDelete: () {
            context.read<TransactionBloc>().add(
              DeleteTransactionEvent(txn.id),
            );
          },
        );
      },
    );
  },
);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}