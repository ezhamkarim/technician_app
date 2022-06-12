import 'package:flutter/material.dart';
import 'package:technician_app/src/helper/size_helper.dart';
import 'package:technician_app/src/view/auth/register_page.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
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
          child: Container(
        height: SizeHelper(context).scaledHeight(),
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login.',
                style: CustomStyle.getStyle(
                    Colors.black, FontSizeEnum.title, FontWeight.bold),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextField(
                      textEditingController: emailController,
                      placeholder: 'Email',
                    ),
                    const SizedBox(height: 48),
                    AuthTextField(
                      textEditingController: pwController,
                      placeholder: 'Password',
                      isObsecure: true,
                    ),
                    Row(
                      children: [
                        const Text('Dont have account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterPage.routeName);
                            },
                            child: Text(
                              'Register',
                              style: CustomStyle.getStyle(
                                  CustomStyle.primarycolor,
                                  FontSizeEnum.content2,
                                  FontWeight.normal),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AuthButton(
                        onPressed: () {},
                        color: CustomStyle.primarycolor,
                        child: Text(
                          'Login',
                          style: CustomStyle.getStyle(Colors.white,
                              FontSizeEnum.title2, FontWeight.w500),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
