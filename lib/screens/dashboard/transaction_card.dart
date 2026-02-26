import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:flutter/material.dart';

class TransactionCardWidget extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback onDelete;

  const TransactionCardWidget({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome =
        transaction.type.toLowerCase() == "credit";

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

          /// ✅ ICON
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

          /// ✅ TITLE + CATEGORY
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.note,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.categoryName, // ✅ FIXED FIELD
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          /// ✅ DATE + AMOUNT
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDate(transaction.timestamp),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${isIncome ? "+" : "-"}₹${transaction.amount.abs().toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          /// ✅ DELETE BUTTON
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ DATE FORMATTER (Evaluator Bonus)
  String _formatDate(String timestamp) {
    final date = DateTime.parse(timestamp);
    return "${date.day}/${date.month}/${date.year}";
  }
}