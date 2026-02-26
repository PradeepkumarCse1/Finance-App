import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  /// ✅ UUID Generator (MANDATORY FOR CHALLENGE)
  final uuid = const Uuid();

  /// ✅ ALWAYS USE credit / debit internally
  String type = "debit";

  String? selectedCategoryId;

  /// ✅ LOCAL CATEGORY LIST (TEMP UI)
  final List<Map<String, String>> categories = [
    {"id": "1", "name": "Food"},
    {"id": "2", "name": "Bills"},
    {"id": "3", "name": "Transport"},
    {"id": "4", "name": "Shopping"},
  ];

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// ✅ TYPE SWITCH
            Row(
              children: [
                _buildTypeButton("debit", "Expense"),
                const SizedBox(width: 10),
                _buildTypeButton("credit", "Income"),
              ],
            ),

            const SizedBox(height: 20),

            /// ✅ TITLE
            _buildInput(titleController, "Title"),

            const SizedBox(height: 12),

            /// ✅ AMOUNT
            _buildInput(
              amountController,
              "Amount (₹)",
              isNumber: true,
            ),

            const SizedBox(height: 20),

            /// ✅ CATEGORY LABEL
            const Text(
              "CATEGORY",
              style: TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 10),

            /// ✅ LOCAL CATEGORY CHIPS
            Wrap(
              spacing: 8,
              children: categories.map((cat) {
                final isSelected = selectedCategoryId == cat["id"];

                return ChoiceChip(
                  label: Text(cat["name"]!),
                  selected: isSelected,
                  selectedColor: const Color(0xFF031AE8),
                  backgroundColor: Colors.grey.shade900,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedCategoryId = cat["id"];
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// ✅ SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF031AE8),
                ),
                child: const Text("Save"),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// ✅ SAVE LOGIC (UUID + FLAGS 😎🔥)
  void _saveTransaction() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || selectedCategoryId == null) {
      return;
    }

    final transaction = TransactionEntity(
      id: uuid.v4(),   // ✅ REAL UUID
      amount: amount,
      note: title,
      type: type,
      categoryId: selectedCategoryId!,
      categoryName: _getCategoryName(selectedCategoryId!),
      timestamp: DateTime.now().toIso8601String(),

      /// ✅ SYNC ENGINE FLAGS (MANDATORY)
      isSynced: false,
      isDeleted: false,
    );

    context.read<TransactionBloc>().add(
          AddTransactionEvent(transaction),
        );

    Navigator.pop(context);
  }

  /// ✅ CATEGORY NAME RESOLVER 🔥
  String _getCategoryName(String id) {
    return categories
        .firstWhere((c) => c["id"] == id)["name"]!;
  }

  /// ✅ TYPE BUTTON
  Widget _buildTypeButton(String value, String label) {
    final isSelected = type == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => type = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ INPUT FIELD
  Widget _buildInput(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.grey.shade900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}