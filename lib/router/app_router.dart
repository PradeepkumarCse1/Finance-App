import 'package:application/screens/dashboard/dashboard_screen.dart';
import 'package:application/screens/login/presentation/screens/auth_page.dart';
import 'package:application/screens/login/presentation/screens/verify_otp_page.dart';
import 'package:application/screens/name_page/presentation/name_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:application/router/routes.dart';

import 'package:application/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) =>  NamePage(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          // builder: (_) =>  PhoneLoginPage(),
           builder: (_) =>  NamePage(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) =>  NamePage(),
        );
        case AppRoutes.verify:
        return MaterialPageRoute(
          builder: (_) =>  NamePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}