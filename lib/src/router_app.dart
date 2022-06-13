import 'package:flutter/material.dart';
import 'package:technician_app/src/view/auth/landing_page.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/auth/register_page.dart';
import 'package:technician_app/src/view/home/admin/services_create_page.dart';
import 'package:technician_app/src/view/home/admin/services_list_page.dart';
import 'package:technician_app/src/view/home/home_page.dart';
import 'package:technician_app/src/view/home/index_page.dart';

import 'view/auth/auth_wrapper.dart';
import 'view/exception_view.dart';

class RouterApp {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AuthWrapper.routeName:
            return const AuthWrapper();
          case LandingPage.routeName:
            return const LandingPage();
          case LoginPage.routeName:
            return const LoginPage();
          case RegisterPage.routeName:
            return const RegisterPage();
          case IndexPage.routeName:
            return const HomePage();
          case ServiceListPage.routeName:
            return const ServiceListPage();
          case ServicesCreatePage.routeName:
            return const ServicesCreatePage();
          default:
            return ExceptionView(routeName: routeSettings.name!);
        }
      },
    );
  }
}
