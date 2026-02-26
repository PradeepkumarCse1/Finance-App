import 'package:application/screens/profile/log_out_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:application/common/constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingConst.medium,
            vertical: SpacingConst.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              const Text(
                "Profile & Settings",
                style: TextStyle(
                  color: AppPalette.white,
                  fontSize: AppFontSize.display,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Nickname Section
              _sectionTitle("NICKNAME"),
              const SizedBox(height: SpacingConst.small),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingConst.medium,
                  vertical: SpacingConst.medium,
                ),
                decoration: _cardDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Naazley",
                      style: TextStyle(
                        color: AppPalette.white,
                        fontSize: AppFontSize.xl,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(SpacingConst.extraSmall),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppPalette.white.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(SpacingConst.small),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppPalette.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Alert Limit Section
              _sectionTitle("ALERT LIMIT (₹)"),
              const SizedBox(height: SpacingConst.small),

              Container(
                padding: const EdgeInsets.all(SpacingConst.medium),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        /// TextField
                        Expanded(
                          child: SizedBox(
                            height: 50, // Fixed height for consistency
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: AppPalette.white,
                                fontSize: AppFontSize.lg,
                              ),
                              decoration: InputDecoration(
                                hintText: "Amount ( ₹ )",
                                hintStyle: const TextStyle(
                                  color: AppPalette.white,
                                  fontSize: AppFontSize.lg,
                                ),
                                filled: true,
                                fillColor: AppPalette.grey.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(SpacingConst.small),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: SpacingConst.medium,
                                  vertical: SpacingConst.small,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: SpacingConst.small),

                        /// Set Button
                        SizedBox(
                          height: 50, // Same height as TextField
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPalette.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SpacingConst.small),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpacingConst.large,
                              ),
                            ),
                            onPressed: () {
                              // Your set logic
                            },
                            child: const Text(
                              "Set",
                              style: TextStyle(
                                color: AppPalette.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSize.lg,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpacingConst.medium),
                    const Text(
                      "Current Limit: ₹1,000",
                      style: TextStyle(
                        color: AppPalette.white,
                        fontSize: AppFontSize.md,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Categories Section
              _sectionTitle("CATEGORIES"),
              const SizedBox(height: SpacingConst.small),

              Container(
                padding: const EdgeInsets.all(SpacingConst.medium),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    /// Add Category Row
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50, // Fixed height
                            child: TextField(
                              style: const TextStyle(
                                color: AppPalette.white,
                                fontSize: AppFontSize.lg,
                              ),
                              decoration: InputDecoration(
                                hintText: "New category Name",
                                hintStyle: const TextStyle(
                                  color: AppPalette.grey,
                                  fontSize: AppFontSize.lg,
                                ),
                                filled: true,
                                fillColor: AppPalette.grey.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(SpacingConst.small),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: SpacingConst.medium,
                                  vertical: SpacingConst.small,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: SpacingConst.small),

                        /// Add Button
                        SizedBox(
                          height: 50, // Same height as TextField
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPalette.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SpacingConst.small),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpacingConst.medium,
                              ),
                            ),
                            onPressed: () {
                              // Your add category logic
                            },
                            child: const Icon(Icons.add, color: AppPalette.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: SpacingConst.medium),
                    const Divider(color: AppPalette.white),
                    const SizedBox(height: SpacingConst.small),

                    _categoryTile("Food"),
                    _categoryTile("Bills"),
                    _categoryTile("Transport"),
                    _categoryTile("Shopping"),
                  ],
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Cloud Sync Section
              _sectionTitle("CLOUD SYNC"),
              const SizedBox(height: SpacingConst.small),

              Container(
                padding: const EdgeInsets.all(SpacingConst.medium),
                decoration: _cardDecoration(),
                child: Container(
                  padding: const EdgeInsets.all(SpacingConst.medium),
                  decoration: BoxDecoration(
                    color: AppPalette.primaryBlue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(SpacingConst.medium),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync To Cloud",
                            style: TextStyle(
                              color: AppPalette.white,
                              fontSize: AppFontSize.xl,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SpacingConst.extraSmall),
                          Text(
                            "Sync and update data to the backend",
                            style: TextStyle(
                              color: AppPalette.white,
                              fontSize: AppFontSize.sm,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.cloud_upload,
                        color: AppPalette.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: SpacingConst.large),

              /// Logout Button
              GestureDetector(
                onTap: () {
                  LogoutDialog.show(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: SpacingConst.medium,
                  ),
                  decoration: _cardDecoration(),
                  child: const Center(
                    child: Text(
                      "Log Out ⏻",
                      style: TextStyle(
                        color: AppPalette.error,
                        fontSize: AppFontSize.xl,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingConst.large),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppPalette.white,
        fontSize: AppFontSize.md,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppPalette.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(SpacingConst.medium),
      border: Border.all(
        color: AppPalette.white.withOpacity(0.05),
      ),
    );
  }

  Widget _categoryTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingConst.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppPalette.white,
              fontSize: AppFontSize.lg,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(SpacingConst.extraSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SpacingConst.small),
              border: Border.all(
                color: AppPalette.error.withOpacity(0.6),
              ),
            ),
            child: const Icon(Icons.delete, color: AppPalette.error, size: 18),
          ),
        ],
      ),
    );
  }
}