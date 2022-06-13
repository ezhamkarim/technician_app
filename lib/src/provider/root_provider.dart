import 'package:flutter/material.dart';
import 'package:technician_app/src/enum/view_state.dart';
import 'package:technician_app/src/model/user_model.dart';

import '../model/service_model.dart';

class RootProvider with ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  UserModel? _technician;
  final List<Service> _services = [];

  set setState(ViewState viewState) {
    _viewState = viewState;

    notifyListeners();
  }

  set setTechnician(UserModel technician) {
    _technician = technician;
    notifyListeners();
  }

  set addService(Service service) {
    _services.add(service);
    notifyListeners();
  }

  set removeService(String id) {
    _services.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  ViewState get viewState => _viewState;

  UserModel? get technician => _technician;

  List<Service> get services => _services;
}
