import 'package:flutter/material.dart';

import '../../enum/view_state.dart';

class AuthButton extends StatelessWidget {
  final Function() onPressed;
  final ViewState? viewState;
  final Color color;
  final Widget child;
  const AuthButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.child,
      this.viewState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: viewState == null
          ? child
          : viewState == ViewState.busy
              ? Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.all(2.0),
                  child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 4,
                    backgroundColor: Colors.white,
                  ),
                )
              : child,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(18),
          primary: color,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
