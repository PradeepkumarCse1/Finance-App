import 'package:application/common/app_button.dart';
import 'package:application/common/constant.dart';
import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';
import 'package:application/screens/login/presentation/bloc/auth_event.dart';
import 'package:application/screens/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_otp_page.dart';

class PhoneLoginPage extends StatelessWidget {
  PhoneLoginPage({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerifyOtpPage()),
          );
        }

        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "Something went wrong"),
              backgroundColor: AppPalette.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppPalette.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingConst.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 60),

                /// Title
                const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: AppFontSize.display,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white,
                  ),
                ),

                const SizedBox(height: SpacingConst.small),

                /// Subtitle
                const Text(
                  "Log In Using Phone & OTP",
                  style: TextStyle(
                    fontSize: AppFontSize.md,
                    color: AppPalette.grey,
                  ),
                ),

                const SizedBox(height: 40),

                /// Phone Input Box
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingConst.medium,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.lightGrey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "+91",
                        style: TextStyle(
                          fontSize: AppFontSize.lg,
                          fontWeight: FontWeight.w500,
                          color: AppPalette.white,
                        ),
                      ),
                      const SizedBox(width: SpacingConst.small),
                      Container(
                        height: 24,
                        width: 1,
                        color: AppPalette.grey,
                      ),
                      const SizedBox(width: SpacingConst.medium),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: const TextStyle(
                            fontSize: AppFontSize.lg,
                            color: AppPalette.white,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                            hintStyle: TextStyle(
                              fontSize: AppFontSize.md,
                              color: AppPalette.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: SpacingConst.large),

                /// Continue Button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                      text: "Continue",
                      isLoading:
                          state.status == AuthStatus.loading,
                      onPressed: () {
                        final phone = phoneController.text.trim();

                        if (phone.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Enter valid 10 digit phone number",
                              ),
                            ),
                          );
                          return;
                        }

                        final fullPhone = "+91$phone";

                        context
                            .read<AuthBloc>()
                            .add(SendOtpEvent(fullPhone));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}