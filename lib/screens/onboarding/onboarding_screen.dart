import 'package:application/common/app_button.dart';
import 'package:application/common/constant.dart';
import 'package:application/screens/login/presentation/screens/auth_page.dart';
import 'package:application/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:application/screens/onboarding/bloc/onboarding_event.dart';
import 'package:application/screens/onboarding/bloc/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final slider.CarouselSliderController _controller =
      slider.CarouselSliderController();

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onboarding.png",
      "title": "Privacy by Default, With Zero Ads or Hidden Tracking",
      "subtitle": "No ads. No trackers. No third-party analytics.",
    },
    {
      "image": "assets/images/onboarding.png",
      "title": "Insights That Help You Spend Better Without Complexity",
      "subtitle": "See category-wise spending, recent activity.",
    },
    {
      "image": "assets/images/onboarding.png",
      "title": "Local-First Tracking That Stays Fully On Your Device",
      "subtitle": "Your finances stay on your phone.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        backgroundColor: AppPalette.black,
        body: SafeArea(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final currentPage = state.currentPage;

              return Stack(
                children: [
                  /// -------- BACKGROUND CAROUSEL --------
                  slider.CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: pages.length,
                    options: slider.CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        context.read<OnboardingBloc>().add(
                          PageChangedEvent(index),
                        );
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            pages[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                          Container(color: AppPalette.black.withOpacity(0.6)),
                        ],
                      );
                    },
                  ),

                  /// -------- CONTENT LAYER --------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingConst.large,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: SpacingConst.large),

                        /// Skip Button
                        if(currentPage != pages.length - 1)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneLoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "SKIP",
                              style: TextStyle(
                                color: AppPalette.white,
                                fontSize: AppFontSize.lg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// -------- FULL WIDTH INDICATOR --------
                        Row(
                          children: List.generate(
                            pages.length,
                            (index) => Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: SpacingConst.extraSmall,
                                ),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: currentPage >= index
                                      ? AppPalette.white
                                      : AppPalette.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: SpacingConst.large),

                        /// Title
                        Text(
                          pages[currentPage]["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppPalette.white,
                            fontSize: AppFontSize.xl,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: SpacingConst.small),

                        /// Subtitle
                        Text(
                          pages[currentPage]["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppPalette.grey,
                            fontSize: AppFontSize.md,
                          ),
                        ),

                        /// 🔥 Reduced space here (removed large gap)
                        const SizedBox(height: SpacingConst.large),

                        /// Buttons Row
                        Row(
                          children: [
                            if (currentPage > 0)
                              IconButton(
                                onPressed: () {
                                  context.read<OnboardingBloc>().add(
                                    PreviousPageEvent(),
                                  );
                                  _controller.previousPage();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppPalette.white,
                                ),
                              ),

                            if (currentPage > 0)
                              const SizedBox(width: SpacingConst.medium),

                            Expanded(
                              child: AppButton(
                                text: currentPage == pages.length - 1
                                    ? "Get Started"
                                    : "Next",
                                onPressed: () {
                                  if (currentPage == pages.length - 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PhoneLoginPage(),
                                      ),
                                    );
                                  } else {
                                    context.read<OnboardingBloc>().add(
                                      NextPageEvent(),
                                    );
                                    _controller.nextPage();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: SpacingConst.large),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
