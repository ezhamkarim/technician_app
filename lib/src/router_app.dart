import 'package:flutter/material.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/view/auth/landing_page.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/auth/register_page.dart';
import 'package:technician_app/src/view/home/about_us_page.dart';
import 'package:technician_app/src/view/home/admin/services_create_page.dart';
import 'package:technician_app/src/view/home/admin/services_list_page.dart';
import 'package:technician_app/src/view/home/admin/technician_report_page.dart';
import 'package:technician_app/src/view/home/booking_description_page.dart';
import 'package:technician_app/src/view/home/chat_page.dart';
import 'package:technician_app/src/view/home/contact_us_page.dart';
import 'package:technician_app/src/view/home/customer/booking_create_page.dart';
import 'package:technician_app/src/view/home/customer/feedback_create_page.dart';
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
          case TechnicianReportPage.routeName:
            return const TechnicianReportPage();
          case ServiceListPageSelection.routeName:
            var data = routeSettings.arguments as Map<String, dynamic>?;
            bool isFromRequest = false;
            Booking? booking;
            if (data != null) {
              isFromRequest = data['fromRequest'];

              booking = data['booking'];
            }

            return ServiceListPageSelection(
              fromRequest: isFromRequest,
              booking: booking,
            );
          case ServiceListPage.routeName:
            return const ServiceListPage();
          case BlockAppointmentPage.routeName:
            return const BlockAppointmentPage();
          case ChatPage.routeName:
            var arguments = routeSettings.arguments as ChatPageArguments;

            return ChatPage(arguments: arguments);
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
          case FeedbackListPage.routeName:
            bool fromAdmin = false;
            if (routeSettings.arguments != null) {
              fromAdmin = routeSettings.arguments as bool;
            }
            return FeedbackListPage(
              fromAdmin: fromAdmin,
            );

          case FeedbackCreatePage.routeName:
            Booking? booking;
            if (routeSettings.arguments != null) {
              booking = routeSettings.arguments as Booking;
            }
            return FeedbackCreatePage(
              booking: booking!,
            );
          case ServicesCreatePage.routeName:
            Service? service;
            if (routeSettings.arguments != null) {
              service = routeSettings.arguments as Service;
            }
            return ServicesCreatePage(
              service: service,
            );
          case ReportListPage.routeName:
            UserModel? userModel;
            if (routeSettings.arguments != null) {
              userModel = routeSettings.arguments as UserModel;
            }
            return ReportListPage(
              technician: userModel,
            );
          case AboutUsPage.routeName:
            return const AboutUsPage();
          case ContactUsPage.routeName:
            return const ContactUsPage();
          default:
            return ExceptionView(routeName: routeSettings.name!);
        }
      },
    );
  }
}
