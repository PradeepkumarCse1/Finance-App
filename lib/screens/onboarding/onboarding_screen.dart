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
      "image": "assets/onboarding/on1.png",
      "title": "Privacy by Default, With Zero Ads or Hidden Tracking",
      "subtitle": "No ads. No trackers. No third-party analytics."
    },
    {
      "image": "assets/onboarding/on2.png",
      "title": "Insights That Help You Spend Better Without Complexity",
      "subtitle": "See category-wise spending, recent activity."
    },
    {
      "image": "assets/onboarding/on3.png",
      "title": "Local-First Tracking That Stays Fully On Your Device",
      "subtitle": "Your finances stay on your phone."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final currentPage = state.currentPage;

            return Stack(
              children: [

                /// ---------------- CAROUSEL ----------------
                slider.CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: pages.length,
                  options: slider.CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      context.read<OnboardingBloc>().add(PageChangedEvent(index));
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final page = pages[index];

                    return Stack(
                      fit: StackFit.expand,
                      children: [

                        /// Background Image
                        Image.asset(
                          page["image"]!,
                          fit: BoxFit.cover,
                        ),

                        /// Dark Overlay
                        Container(
                          color: Colors.black.withOpacity(0.6),
                        ),

                        /// Text Content
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 120, 20, 110),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                page["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                page["subtitle"]!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),

                /// ---------------- SKIP BUTTON ----------------
                Positioned(
                  top: 50,
                  right: 20,
                  child: TextButton(
                    onPressed: () {
                      _controller.animateToPage(pages.length - 1);
                      context
                          .read<OnboardingBloc>()
                          .add(PageChangedEvent(pages.length - 1));
                    },
                    child: const Text(
                      "SKIP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                /// ---------------- PAGE INDICATOR ----------------
                Positioned(
                  bottom: 230,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: MediaQuery.of(context).size.width / 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: currentPage >= index
                              ? Colors.white
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),

                /// ---------------- BACK + NEXT BUTTONS ----------------
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [

                      /// BACK BUTTON
                      if (currentPage > 0)
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white38),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            context.read<OnboardingBloc>().add(PreviousPageEvent());
                            _controller.previousPage();
                          },
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset("assert/images/back_button.png"),
                          ),
                        ),

                      if (currentPage > 0)
                        const SizedBox(width: 12),

                      /// NEXT / GET STARTED BUTTON
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 11, 43, 226),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            if (currentPage == pages.length - 1) {

                              /// ✅ NAVIGATE TO PHONE LOGIN PAGE
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhoneLoginPage(),
                                ),
                              );

                            } else {
                              context.read<OnboardingBloc>().add(NextPageEvent());
                              _controller.nextPage();
                            }
                          },
                          child: Text(
                            currentPage == pages.length - 1
                                ? "Get Started"
                                : "Next",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}