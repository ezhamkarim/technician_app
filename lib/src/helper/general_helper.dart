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
}
