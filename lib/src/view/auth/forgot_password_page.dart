import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog_helper.dart';
import '../../helper/log_helper.dart';
import '../../provider/root_provider.dart';
import '../../services/auth_services.dart';
import '../../style/custom_style.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const routeName = '/forgot-password';
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
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
                    'Forgot Password.',
                    style: CustomStyle.getStyle(
                        Colors.black, FontSizeEnum.title, FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              AuthTextField(
                textEditingController: emailController,
                placeholder: 'Email',
              ),
              Row(
                children: [
                  Expanded(
                    child: AuthButton(
                        viewState: rootProvider.viewState,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context
                                .read<AuthService>()
                                .sendResetPasswordLink(
                                    email: emailController.text,
                                    rootProvider: rootProvider)
                                .then((value) =>
                                    DialogHelper.dialogWithOutActionWarning(
                                        context,
                                        'Reset link sent to email ${emailController.text}'))
                                .catchError((e) {
                              logError('Error login :${e.toString()}');
                              DialogHelper.dialogWithOutActionWarning(
                                  context, e.toString());
                            });
                          }
                        },
                        color: CustomStyle.primarycolor,
                        child: Text(
                          'Reset Password',
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
