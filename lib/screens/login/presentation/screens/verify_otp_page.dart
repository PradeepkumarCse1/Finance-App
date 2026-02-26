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

  String get enteredOtp =>
      controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: height * 0.04),

              /// Back Button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),

              SizedBox(height: height * 0.02),

              /// Title
              Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: height * 0.01),

              /// Subtitle
              Text(
                "Enter the 6-Digit code",
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.grey.shade400,
                ),
              ),

              SizedBox(height: height * 0.02),

              /// Change Number
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

              /// OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {

                  return SizedBox(
                    width: width * 0.12,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),

                      onChanged: (value) {

                        if (value.isNotEmpty && index < 5) {
                          focusNodes[index + 1].requestFocus();
                        }

                        if (value.isEmpty && index > 0) {
                          focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: height * 0.06),

              /// Verify Button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {

                    if (enteredOtp.length == 6) {
                      context.read<AuthBloc>().add(
                        VerifyOtpEvent(enteredOtp),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF031AE8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
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

              /// Resend Text
              Center(
                child: Text(
                  "Resend OTP in 32s",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey.shade500,
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