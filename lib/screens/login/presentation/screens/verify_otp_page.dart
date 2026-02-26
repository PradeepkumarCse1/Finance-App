import 'package:application/common/app_button.dart';
import 'package:application/common/constant.dart';
import 'package:application/screens/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  String get enteredOtp => controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingConst.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 30),

              /// Back Button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppPalette.white,
                ),
              ),

              const SizedBox(height: SpacingConst.small),

              /// Title
              const Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: AppFontSize.display,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.white,
                ),
              ),

              const SizedBox(height: SpacingConst.extraSmall),

              /// Subtitle
              const Text(
                "Enter the 6-Digit code",
                style: TextStyle(
                  fontSize: AppFontSize.md,
                  color: AppPalette.grey,
                ),
              ),

              const SizedBox(height: SpacingConst.small),

              /// Change Number
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Change Number",
                  style: TextStyle(
                    fontSize: AppFontSize.sm,
                    color: AppPalette.primaryBlue,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: AppFontSize.xl,
                        color: AppPalette.white,
                        fontWeight: FontWeight.bold,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            AppPalette.lightGrey.withOpacity(0.15),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          focusNodes[index + 1]
                              .requestFocus();
                        }

                        if (value.isEmpty && index > 0) {
                          focusNodes[index - 1]
                              .requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 50),

              /// Verify Button
              SizedBox(
                height: 56,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                      text: "Verify",
                      onPressed: () {
                        if (enteredOtp.length == 6) {
                          context.read<AuthBloc>().add(
                                VerifyOtpEvent(
                                  enteredOtp,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Resend Text
              const Center(
                child: Text(
                  "Resend OTP in 32s",
                  style: TextStyle(
                    fontSize: AppFontSize.sm,
                    color: AppPalette.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}