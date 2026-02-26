// import 'package:application/screens/dashboard/domain/entity/transaction_entity.dart';
// import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
// import 'package:application/screens/dashboard/presentation/bloc/transaction_event.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/transaction_bloc.dart';
// import '../bloc/transaction_event.dart';
// import '../bloc/transaction_state.dart';

// class AddTransactionSheet extends StatefulWidget {
//   const AddTransactionSheet({super.key});

//   @override
//   State<AddTransactionSheet> createState() => _AddTransactionSheetState();
// }

// class _AddTransactionSheetState extends State<AddTransactionSheet> {

//   final titleController = TextEditingController();
//   final amountController = TextEditingController();

//   String type = "expense";
//   String? selectedCategoryId;

//   @override
//   void initState() {
//     super.initState();

//     /// ✅ LOAD CATEGORIES WHEN SHEET OPENS
//     // context.read<TransactionBloc>().add(LoadCategoriesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {

//     final state = context.watch<TransactionBloc>().state;

//     final bottomInset = MediaQuery.of(context).viewInsets.bottom;

//     return Padding(
//       padding: EdgeInsets.only(bottom: bottomInset),

//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),

//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             /// ✅ HEADER
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Add Transaction",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: const Text("Close", style: TextStyle(color: Colors.white54)),
//                 )
//               ],
//             ),

//             const SizedBox(height: 20),

//             /// ✅ TYPE SWITCH
//             Row(
//               children: [
//                 _buildTypeButton("expense"),
//                 const SizedBox(width: 10),
//                 _buildTypeButton("credit"),
//               ],
//             ),

//             const SizedBox(height: 20),

//             /// ✅ TITLE
//             _buildInput(titleController, "Title"),

//             const SizedBox(height: 12),

//             /// ✅ AMOUNT
//             _buildInput(amountController, "Amount (₹)", isNumber: true),

//             const SizedBox(height: 20),

//             /// ✅ CATEGORIES
//             const Text("CATEGORY", style: TextStyle(color: Colors.white54)),

//             const SizedBox(height: 10),

//             if (state.categoriesLoading)
//               const Center(child: CircularProgressIndicator()),

//             if (!state.categoriesLoading)
//               Wrap(
//                 spacing: 8,
//                 children: state.categories.map((cat) {

//                   final isSelected = selectedCategoryId == cat.id;

//                   return ChoiceChip(
//                     label: Text(cat.name),
//                     selected: isSelected,
//                     onSelected: (_) {
//                       setState(() {
//                         selectedCategoryId = cat.id;
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),

//             const SizedBox(height: 20),

//             /// ✅ SAVE BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                onPressed: () {

//   final title = titleController.text.trim();
//   final amount = double.tryParse(amountController.text);

//   if (title.isEmpty || amount == null || selectedCategoryId == null) {
//     return;
//   }

//   final transaction = TransactionEntity(
//     id: DateTime.now().millisecondsSinceEpoch.toString(), // temp local id
//     amount: amount,
//     note: title,
//     type: type, // "credit" / "expense"
//     category: selectedCategoryId??"",
//     timestamp: DateTime.now().toString(),
//   );

//   context.read<TransactionBloc>().add(
//     AddTransactionEvent(transaction),
//   );

//   Navigator.pop(context);
// },                child: const Text("Save"),
//               ),
//             ),

//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTypeButton(String value) {

//     final isSelected = type == value;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() => type = value);
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.green : Colors.grey.shade900,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Center(
//             child: Text(
//               value.toUpperCase(),
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInput(TextEditingController controller, String hint,
//       {bool isNumber = false}) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.white38),
//         filled: true,
//         fillColor: Colors.grey.shade900,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }