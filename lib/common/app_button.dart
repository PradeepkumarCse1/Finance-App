import 'package:application/common/constant.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingConst.medium,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Button Text
            Text(
              text,
              style: const TextStyle(
                fontSize: AppFontSize.lg,
                fontWeight: FontWeight.w600,
                color: AppPalette.white,
              ),
            ),

            /// Loader (right side)
            if (isLoading)
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppPalette.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}