import 'package:flutter/material.dart';
import 'package:technician_app/src/enum/view_state.dart';

class RootProvider with ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  set setState(ViewState viewState) {
    _viewState = viewState;

    notifyListeners();
  }

  ViewState get viewState => _viewState;
}
