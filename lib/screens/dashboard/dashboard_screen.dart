import 'package:application/screens/dashboard/add_transaction_sheet.dart';
import 'package:application/screens/dashboard/presentation/bloc/navigation_bloc.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_event.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_state.dart';
import 'package:application/screens/dashboard/transaction_card.dart';
import 'package:application/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application/screens/tranction_history/trancation_history_screen.dart';

class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
  @override
  void initState() {
    super.initState();

    /// 🔥 TRIGGER API CALL HERE
    context.read<TransactionBloc>().add(LoadTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardHomeContent(),
       TransactionsScreen(),
      ProfilePage(),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,

        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, index) {
            return IndexedStack(index: index, children: pages);
          },
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(40),
            ),
            child: BlocBuilder<NavigationCubit, int>(
              builder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavIcon(
                      context,
                      icon: Icons.pie_chart,
                      active: index == 0,
                      onTap: () { context.read<NavigationCubit>().changeTab(0);
                          context.read<TransactionBloc>().add(LoadTransactionsEvent());

               } ),
                    _buildNavIcon(
                      context,
                      icon: Icons.sync_alt,
                      active: index == 1,
                      onTap: () {
                        /// ✅ Change tab
                        context.read<NavigationCubit>().changeTab(1);

                        /// ✅ Trigger sync
                        context.read<TransactionBloc>().add(
                          SyncTransactionsEvent(),
                        );
                                                  // context.read<TransactionBloc>().add(LoadTransactionsEvent());

                      },
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.person_outline,
                      active: index == 2,
                      onTap: () => context.read<NavigationCubit>().changeTab(2),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // ✅ IMPORTANT (keyboard safe)
              backgroundColor: Colors.transparent,
              builder: (_) => const AddTransactionSheet(),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context, {
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: active ? const Color(0xFF3F51B5) : Colors.transparent,
        child: Icon(icon, color: active ? Colors.white : Colors.white54),
      ),
    );
  }
}

class DashboardHomeContent extends StatelessWidget {
  const DashboardHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            final income = state.totalIncome;
            final expense = state.totalExpense;
final recentTransactions = state.transactions
    .where((t) => !t.isDeleted)
    .take(10)
    .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                /// ✅ Greeting
                Text(
                  "Welcome, User!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: height * 0.025),

                /// ✅ Income / Expense Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        title: "Total Income",
                        amount: income,
                        color: Colors.green,
                      ),
                    ),

                    SizedBox(width: width * 0.03),

                    Expanded(
                      child: _buildSummaryCard(
                        title: "Total Expense",
                        amount: expense,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.03),

                /// ✅ Monthly Limit Card
                _buildLimitCard(width),

                SizedBox(height: height * 0.03),

                /// ✅ Recent Transactions Header
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: height * 0.015),

                /// ✅ Transactions List
                Expanded(
                  child: ListView.builder(
                    itemCount: recentTransactions.length,
                    itemBuilder: (context, index) {
                      final txn = recentTransactions[index];

                      return TransactionCardWidget(
                        transaction: txn,
                        onDelete: () {
                          context.read<TransactionBloc>().add(
                            DeleteTransactionEvent(txn.id),
                          );
                        },
                      ); // ✅ REUSED
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ✅ SUMMARY CARD

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),

          const SizedBox(height: 6),

          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ LIMIT CARD

  Widget _buildLimitCard(double width) {
    const limit = 1000.0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MONTHLY LIMIT",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),

          const SizedBox(height: 10),

          const Text(
            "₹734 / ₹1000",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.73,
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "27% Remaining",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ✅ TRANSACTION TILE

  Widget _buildTransactionTile(txn, double width) {
    final isCredit = txn.type.toLowerCase() == "credit";
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white10,
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white70,
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.note,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),

                const SizedBox(height: 2),

                Text(
                  txn.categoryName,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          Text(
            "${isCredit ? '+' : '-'} ₹${txn.amount}",
            style: TextStyle(
              color: isCredit ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
