import 'package:flutter/material.dart';

class SizeHelper {
  final BuildContext _ctxt;

  SizeHelper(this._ctxt);

  double scaledWidth({double? widthScale}) {
    widthScale ??= 1;
    return MediaQuery.of(_ctxt).size.width * widthScale;
  }

  double topSafeArea() {
    return MediaQuery.of(_ctxt).padding.top;
  }

  double bottomNavBar() {
    return MediaQuery.of(_ctxt).padding.bottom;
  }

  double scaledHeight({double? heightScale}) {
    heightScale ??= 1;
    return MediaQuery.of(_ctxt).size.height * heightScale;
  }
}
