import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/roles_model.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/auth_services.dart';
import 'package:technician_app/src/services/firebase_messaging_service.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../../style/custom_style.dart';
import '../home/index_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();
  final rePwController = TextEditingController();
  final phoneNoController = TextEditingController();
  Roles roleSelected = Roles(name: 'Customer');
  List<Roles> roles = [
    Roles(name: 'Customer'),
    Roles(name: 'Technician'),
    // Roles(name: 'Admin')
  ];
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            // height: SizeHelper(context).scaledHeight(),
            padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
            child: Form(
              key: formKey,
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
                                    color: CustomStyle.secondaryColor,
                                    width: 2)),
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
                        onChanged: (role) {
                          roleSelected.name = role!;
                        }),
                  ),
                  const SizedBox(height: 48),
                  AuthTextField(
                    textEditingController: emailController,
                    placeholder: 'Email',
                  ),
                  const SizedBox(height: 48),
                  AuthTextField(
                    textEditingController: phoneNoController,
                    placeholder: 'Phone No',
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
                            viewState: rootProvider.viewState,
                            onPressed: () async {
                              if (pwController.text != rePwController.text) {
                                DialogHelper.dialogWithOutActionWarning(
                                    context, 'Password not match');
                                return;
                              }
                              if (formKey.currentState!.validate()) {
                                try {
                                  var userModel = UserModel(
                                      pushToken: await FirebaseMessagingService
                                              .getFirebaseToken ??
                                          '',
                                      id: '',
                                      chatWith: '',
                                      name: nameController.text,
                                      role: roleSelected.name,
                                      phoneNumber: phoneNoController.text,
                                      email: emailController.text);
                                  await context.read<AuthService>().signUp(
                                      email: emailController.text,
                                      password: pwController.text,
                                      rootProvider: rootProvider,
                                      userModel: userModel);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      IndexPage.routeName,
                                      ModalRoute.withName(IndexPage.routeName));
                                } catch (e) {
                                  logError('Error login $e');
                                  DialogHelper.dialogWithOutActionWarning(
                                      context, e.toString());
                                }
                              }
                            },
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
      ),
    );
  }
}
