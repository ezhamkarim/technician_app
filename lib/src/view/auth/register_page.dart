import 'package:flutter/material.dart';
import 'package:technician_app/src/model/roles_model.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

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
  Roles roleSelected = Roles(name: 'Customer');
  List<Roles> roles = [
    Roles(name: 'Customer'),
    Roles(name: 'Technician'),
    Roles(name: 'Admin')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            // height: SizeHelper(context).scaledHeight(),
            padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Register.',
                      style: CustomStyle.getStyle(
                          Colors.black, FontSizeEnum.title, FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  textEditingController: nameController,
                  placeholder: 'Name',
                ),
                const SizedBox(height: 48),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                      value: roleSelected.name,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: CustomStyle.secondaryColor, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: CustomStyle.primarycolor, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2))),
                      items: roles
                          .map((e) => DropdownMenuItem(
                              value: e.name, child: Text(e.name)))
                          .toList(),
                      onChanged: (role) {}),
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  textEditingController: emailController,
                  placeholder: 'Email',
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  textEditingController: phoneNoController,
                  placeholder: 'Name',
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  textEditingController: pwController,
                  placeholder: 'Password',
                  isObsecure: true,
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  textEditingController: rePwController,
                  placeholder: 'Confirm Password',
                  isObsecure: true,
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: AuthButton(
                          onPressed: () {},
                          color: CustomStyle.primarycolor,
                          child: Text(
                            'Register',
                            style: CustomStyle.getStyle(Colors.white,
                                FontSizeEnum.title2, FontWeight.w500),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
