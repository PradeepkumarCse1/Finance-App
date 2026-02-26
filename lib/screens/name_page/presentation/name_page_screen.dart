import 'package:application/common/app_button.dart';
import 'package:application/screens/name_page/presentation/bloc/name_bloc.dart';
import 'package:application/screens/name_page/presentation/bloc/name_event.dart';
import 'package:application/screens/name_page/presentation/bloc/name_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return BlocProvider(
      create: (_) => NameBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: BlocListener<NameBloc, NameState>(
              listener: (context, state) {
                if (state.status == NameStatus.success) {
                  // ✅ CALL API OR NAVIGATE
                  print("Call API");
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  const Text(
                    "👋 What should we call you?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "This name stays only on your device.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// TEXT FIELD
                  BlocBuilder<NameBloc, NameState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: state.status == NameStatus.invalid
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    onChanged: (value) {
                                      context
                                          .read<NameBloc>()
                                          .add(NameChanged(value));
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),

                                /// ✅ Tick when valid
                                if (state.status == NameStatus.valid)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                              ],
                            ),
                          ),

                          /// ✅ Error Message
                          if (state.status == NameStatus.invalid)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, left: 4),
                              child: Text(
                                state.errorMessage ?? '',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  /// Continue Button
                  BlocBuilder<NameBloc, NameState>(
                    builder: (context, state) {
                      return AppButton(
                        text: "Continue",
                        isLoading:
                            state.status == NameStatus.submitting,
                        onPressed: () {
                          context
                              .read<NameBloc>()
                              .add(NameSubmitted());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}