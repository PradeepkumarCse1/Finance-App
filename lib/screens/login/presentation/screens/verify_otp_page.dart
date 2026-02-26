import 'package:application/common/app_button.dart';
import 'package:application/common/constant.dart';
import 'package:application/core/service_locator.dart';
import 'package:application/router/routes.dart';
import 'package:application/screens/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../cubit/otp_timer_cubit.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {

  String _enteredOtp = "";

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final defaultPinTheme = PinTheme(
      width: 55,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<OtpTimerCubit>()..startTimer()),
      ],

      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.status != current.status,

        listener: (context, state) {

          if (state.status == AuthStatus.authenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }

          if (state.status == AuthStatus.newUser) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.createProfile);
          }

          if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Error"),
              ),
            );
          }
        },

        child: Scaffold(
          backgroundColor: AppPalette.black,

          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: height * 0.04),

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),

                  SizedBox(height: height * 0.02),

                  Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: height * 0.01),

                  Text(
                    "Enter the 6-Digit code",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.grey.shade400,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Change Number",
                      style: TextStyle(
                        fontSize: width * 0.038,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.05),

                  /// ✅ PINPUT 🔥
                  Center(
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue),
                        ),
                      ),

                      onChanged: (value) {
                        _enteredOtp = value;
                      },
                    ),
                  ),

                  SizedBox(height: height * 0.06),

                  SizedBox(
                    width: double.infinity,
                    height: height * 0.065,

                    child: ElevatedButton(
                      onPressed: () {

                        if (_enteredOtp.length == 6) {
                          context.read<AuthBloc>().add(
                                VerifyOtpEvent(_enteredOtp),
                              );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF031AE8),
                      ),

                      child: Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  /// ✅ RESEND TIMER 🔥
                  Center(
                    child: BlocBuilder<OtpTimerCubit, int>(
                      builder: (context, seconds) {

                        final canResend = seconds == 0;

                        return GestureDetector(
                          onTap: canResend
                              ? () {

                                  final phone =
                                      context.read<AuthBloc>().phone;

                                  if (phone != null) {
                                    context.read<AuthBloc>().add(
                                          ResendOtpEvent(phone),
                                        );
                                  }

                                  context.read<OtpTimerCubit>().resetTimer();
                                }
                              : null,

                          child: Text(
                            canResend
                                ? "Resend OTP"
                                : "Resend OTP in ${seconds}s",

                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: canResend
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
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