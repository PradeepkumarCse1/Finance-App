import 'package:application/common/app_button.dart';
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        /// ✅ SUCCESS → OTP SENT
        if (state.status == AuthStatus.otpSent) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerifyOtpPage()),
          );
        }

        /// ✅ FAILURE → ERROR
        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "Something went wrong"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.08),

                /// Title
                Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: height * 0.01),

                /// Subtitle
                Text(
                  "Log In Using Phone & OTP",
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: const Color.fromARGB(143, 255, 255, 255),
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Phone Input Box
                Container(
                  color: const Color.fromARGB(56, 117, 117, 117),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  height: height * 0.07,
                  child: Row(
                    children: [
                      Text(
                        "+91",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        height: height * 0.03,
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                            hintStyle: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Continue Button (ONLY THIS PART CHANGED)
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
                                  "Enter valid 10 digit phone number"),
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