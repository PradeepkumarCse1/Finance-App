import 'dart:async';
import 'package:flutter/material.dart';
import 'package:application/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.onboarding,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: screenWidth * 0.35,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}