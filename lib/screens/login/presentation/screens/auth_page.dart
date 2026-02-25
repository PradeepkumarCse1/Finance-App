import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';
import 'package:application/screens/login/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneLoginPage extends StatelessWidget {
  PhoneLoginPage({super.key});

  final TextEditingController phoneController = TextEditingController();

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
                    /// +91 Prefix
                    Text(
                      "+91",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: width * 0.02),

                    /// Divider
                    Container(
                      height: height * 0.03,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),

                    SizedBox(width: width * 0.03),

                    /// Phone Field
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

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    final phone = phoneController.text.trim();
                    if (phone.length == 10) {
                      final fullPhone = "+91$phone";

                      // Dispatch the event to your BLoC
                      context.read<AuthBloc>().add(SendOtpEvent(fullPhone));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enter valid 10 digit phone number"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 26, 232),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.white,
                    ),
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