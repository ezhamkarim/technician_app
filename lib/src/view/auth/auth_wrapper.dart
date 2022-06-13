import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/view/auth/landing_page.dart';
import 'package:technician_app/src/view/home/index_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    logInfo('Firebase user : $firebaseUser');
    if (firebaseUser != null) {
      return const IndexPage();
    }
    return const LandingPage();
  }
}
