import 'package:flutter/material.dart';

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
            // Title
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

            // Transaction List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  TransactionCard(
                    title: "Grocery Store",
                    category: "Food",
                    date: "12th Dec 2026",
                    amount: -36345,
                  ),
                  TransactionCard(
                    title: "Electricity Bill",
                    category: "Bills",
                    date: "12th Dec 2026",
                    amount: 379,
                  ),
                  TransactionCard(
                    title: "Fruits",
                    category: "Food",
                    date: "12th Dec 2026",
                    amount: 379,
                  ),
                  TransactionCard(
                    title: "Water Bill",
                    category: "Bills",
                    date: "12th Dec 2026",
                    amount: -36345,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Bottom Navigation
            // const CustomBottomBar(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final double amount;

  const TransactionCard({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome = amount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Left Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white70,
            ),
          ),

          const SizedBox(width: 14),

          // Title & Category
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Date & Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${isIncome ? "+" : "-"}₹${amount.abs().toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          const Icon(Icons.delete, color: Colors.red),
        ],
      ),
    );
  }
}
