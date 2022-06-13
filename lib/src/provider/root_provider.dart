import 'package:flutter/material.dart';
import 'package:technician_app/src/enum/view_state.dart';
import 'package:technician_app/src/model/user_model.dart';

import '../model/service_model.dart';

class RootProvider with ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  UserModel? _technician;
  List<Service> _services = [];
  double _total = 0;
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
    _total = _services.fold<double>(
        0, (previousValue, element) => previousValue + element.price);
    notifyListeners();
  }

  set removeService(String id) {
    _services.removeWhere((element) => element.id == id);
    _total = _services.fold<double>(
        0, (previousValue, element) => previousValue + element.price);
    notifyListeners();
  }

  void resetNotifier() {
    _technician = null;
    _services = [];
    _total = 0;
    notifyListeners();
  }

  double get total => _total;
  ViewState get viewState => _viewState;

  UserModel? get technician => _technician;

  List<Service> get services => _services;
}
