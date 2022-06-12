import 'package:flutter/material.dart';
import 'package:technician_app/src/style/custom_style.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: CustomStyle.primarycolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.child,
      ),
    );
  }
}
