import 'package:flutter/material.dart';
import 'package:technician_app/src/style/custom_style.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField(
      {Key? key,
      required this.textEditingController,
      this.isObsecure = false,
      this.placeholder})
      : super(key: key);
  final TextEditingController textEditingController;
  final bool isObsecure;
  final String? placeholder;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isObsecure,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(24),
          hintText: widget.placeholder,
          // hintStyle: CustomStyle.getStyle(color, fontSizeEnum, fontWeight),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: CustomStyle.secondaryColor, width: 2))),
    );
  }
}
