import 'package:flutter/material.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../../style/custom_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(64, 120, 64, 64),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Login.',
                style: CustomStyle.getStyle(
                    Colors.black, FontSizeEnum.title, FontWeight.bold),
              ),
              AuthTextField(
                textEditingController: emailController,
                placeholder: 'Password',
              )
            ],
          ),
        ),
      )),
    );
  }
}
