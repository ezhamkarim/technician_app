import 'package:flutter/material.dart';

import '../../style/custom_style.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.content2, FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: CustomStyle.secondaryColor,
                color: Colors.white),
          ],
        ),
      ),
    );
  }
}
