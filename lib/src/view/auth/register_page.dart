import 'package:flutter/material.dart';
import 'package:technician_app/src/helper/size_helper.dart';

import '../../style/custom_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();
  final rePwController = TextEditingController();
  final phoneNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeHelper(context).scaledHeight(),
        padding: const EdgeInsets.fromLTRB(64, 120, 64, 64),
        child: Column(
          children: [
            Text(
              'Register.',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.title, FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
