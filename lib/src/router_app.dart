import 'package:flutter/material.dart';
import 'package:technician_app/src/view/auth/landing_page.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/auth/register_page.dart';

import 'view/exception_view.dart';

class RouterApp {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          // case AuthWrapper.routeName:
          //   return const AuthWrapper();
          case LandingPage.routeName:
            return const LandingPage();
          case LoginPage.routeName:
            return const LoginPage();
          case RegisterPage.routeName:
            return const RegisterPage();
          default:
            return ExceptionView(routeName: routeSettings.name!);
        }
      },
    );
  }
}
