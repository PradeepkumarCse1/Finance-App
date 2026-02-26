import 'package:flutter/material.dart';
import 'package:application/common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application/screens/login/presentation/screens/auth_page.dart';

class LogoutDialog {
  /// Call this function to show logout popup
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppPalette.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpacingConst.medium),
        ),
        title: const Text(
          "Logout",
          style: TextStyle(
            color: AppPalette.white,
            fontSize: AppFontSize.xl,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            color: AppPalette.white,
            fontSize: AppFontSize.md,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close popup
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: AppPalette.grey,
                fontSize: AppFontSize.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Clear SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              // Navigate to Login Page and remove all previous routes
              Navigator.of(ctx).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) =>  PhoneLoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: AppPalette.error,
                fontSize: AppFontSize.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}