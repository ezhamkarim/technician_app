import 'package:flutter/material.dart';
import 'package:technician_app/src/style/custom_style.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget child;
  final void Function()? onTap;
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        color: CustomStyle.primarycolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.child,
        ),
      ),
    );
  }
}

class CustomOutlinedCard extends StatefulWidget {
  const CustomOutlinedCard({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget child;
  final void Function()? onTap;
  @override
  State<CustomOutlinedCard> createState() => _CustomOutlinedCardState();
}

class _CustomOutlinedCardState extends State<CustomOutlinedCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 0,

        //margin: const EdgeInsets.all(8),

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            side: BorderSide(
              color: CustomStyle.primarycolor,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.child,
        ),
      ),
    );
  }
}
