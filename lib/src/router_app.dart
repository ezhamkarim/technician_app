import 'package:flutter/material.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/view/auth/landing_page.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/auth/register_page.dart';
import 'package:technician_app/src/view/home/admin/services_create_page.dart';
import 'package:technician_app/src/view/home/admin/services_list_page.dart';
import 'package:technician_app/src/view/home/booking_description_page.dart';
import 'package:technician_app/src/view/home/customer/booking_create_page.dart';
import 'package:technician_app/src/view/home/customer/services_list_selection_page.dart';
import 'package:technician_app/src/view/home/customer/technician_list_page.dart';
import 'package:technician_app/src/view/home/index_page.dart';
import 'package:technician_app/src/view/home/technician/block_appointment_page.dart';
import 'package:technician_app/src/view/home/technician/feedback_list_page.dart';
import 'package:technician_app/src/view/home/technician/report_list_page.dart';

import 'model/user_model.dart';
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
            return const IndexPage();
          case BookingCreatePage.routeName:
            return const BookingCreatePage();
          case TechnicianListPage.routeName:
            return const TechnicianListPage();
          case ServiceListPageSelection.routeName:
            return const ServiceListPageSelection();
          case ServiceListPage.routeName:
            return const ServiceListPage();
          case BlockAppointmentPage.routeName:
            return const BlockAppointmentPage();
          case BookingDescriptionPage.routeName:
            Booking? booking;
            Role role;

            var arg = routeSettings.arguments as Map<String, dynamic>;

            booking = arg['booking'];
            role = arg['role'];

            return BookingDescriptionPage(
              booking: booking!,
              role: role,
            );
          case ServicesCreatePage.routeName:
            Service? service;
            if (routeSettings.arguments != null) {
              service = routeSettings.arguments as Service;
            }
            return ServicesCreatePage(
              service: service,
            );
          case FeedbackListPage.routeName:
            return const FeedbackListPage();
          case ReportListPage.routeName:
            return const ReportListPage();
          default:
            return ExceptionView(routeName: routeSettings.name!);
        }
      },
    );
  }
}
