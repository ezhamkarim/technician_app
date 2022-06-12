import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool obscuring = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isObsecure ? obscuring : widget.isObsecure,
      validator: (string) {
        if (string == null || string.isEmpty) {
          return 'Sila masukkan aksara';
        }
        if (widget.isObsecure && string.length < 8) {
          return 'Sila masukkan kata laluan melebihi 8 aksara';
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: widget.isObsecure
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          obscuring = !obscuring;
                        });
                      },
                      icon: FaIcon(
                        obscuring
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: CustomStyle.secondaryColor,
                      )),
                )
              : null,
          contentPadding: const EdgeInsets.all(24),
          hintText: widget.placeholder,
          // hintStyle: CustomStyle.getStyle(color, fontSizeEnum, fontWeight),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: CustomStyle.secondaryColor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide:
                  BorderSide(color: CustomStyle.primarycolor, width: 2)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.red, width: 2))),
    );
  }
}
