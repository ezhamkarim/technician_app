import 'package:flutter/material.dart';
import 'package:technician_app/src/enum/booking_status_enum.dart';

import '../model/user_model.dart';

class GeneralHelper {
  static Role getRole(String role) {
    switch (role) {
      case 'Technician':
        return Role.technician;
      case 'Admin':
        return Role.admin;
      case 'Customer':
        return Role.customer;
      default:
        return Role.technician;
    }
  }

  static BookingStatus getStatus(String status) {
    switch (status) {
      case 'WAITING APPROVAL':
        return BookingStatus.waitingApproval;
      case 'APPROVED':
        return BookingStatus.approved;
      case 'IN PROGRESS':
        return BookingStatus.inProgress;
      case 'COMPLETED':
        return BookingStatus.completed;
      default:
        return BookingStatus.waitingApproval;
    }
  }

  static Color getTrueColor(String status) {
    switch (status) {
      case 'WAITING APPROVAL':
        return Colors.red;
      case 'APPROVED':
        return Colors.yellow;
      case 'IN PROGRESS':
        return Colors.yellow;
      case 'COMPLETED':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  static String calculateTimeDifferenceBetween(
      {required DateTime startDate, required DateTime endDate}) {
    int seconds = endDate.difference(startDate).inSeconds;
    // if (seconds.isNegative) return 'Delayed';
    if (seconds < 60) {
      return '$seconds second';
    } else if (seconds >= 60 && seconds < 3600) {
      return '${endDate.difference(startDate).inMinutes.abs()} minute';
    } else if (seconds >= 3600 && seconds < 86400) {
      return '${endDate.difference(startDate).inHours} hour';
    } else {
      return '${endDate.difference(startDate).inDays} day';
    }
  }
}
