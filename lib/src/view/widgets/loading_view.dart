import 'package:flutter/material.dart';
import 'package:technician_app/src/style/custom_style.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          color: CustomStyle.primarycolor,
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
