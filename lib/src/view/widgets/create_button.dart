import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technician_app/src/style/custom_style.dart';

class CreateButton extends StatefulWidget {
  const CreateButton({Key? key, required this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  State<CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: IconButton(
        onPressed: widget.onPressed,
        //disabledColor: Colors.red,
        icon: const FaIcon(
          FontAwesomeIcons.plus,
          color: CustomStyle.primarycolor,
        ),
        color: CustomStyle.primarycolor,
      ),
    );
  }
}
