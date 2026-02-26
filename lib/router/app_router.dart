import 'package:application/features/category_listing/presentation/page/category_listing_page.dart';
import 'package:application/screens/dashboard/dashboard_screen.dart';
import 'package:application/screens/login/presentation/screens/auth_page.dart';
import 'package:application/screens/login/presentation/screens/verify_otp_page.dart';
import 'package:application/screens/name_page/presentation/name_page_screen.dart';
import 'package:application/screens/profile/profile_page.dart';
import 'package:application/screens/splash_screen/splash_screen.dart';
import 'package:application/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:application/router/routes.dart';

import 'package:application/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.splashScreen:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => PhoneLoginPage());
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) =>  FinanceDashboard(),
        );
        case AppRoutes.verify:
        return MaterialPageRoute(
          builder: (_) =>  NamePage(),
        );
       case AppRoutes.profilePage:
        return MaterialPageRoute(
          builder: (_) =>  CategoryScreen(),
        );

        return MaterialPageRoute(builder: (_) => FinanceDashboard());
      case AppRoutes.verify:
        return MaterialPageRoute(builder: (_) => VerifyOtpPage());
       case AppRoutes.createProfile:
        return MaterialPageRoute(builder: (_) => NamePage());
       case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => CategoryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
