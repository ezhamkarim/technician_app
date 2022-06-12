import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/auth_services.dart';
import 'package:technician_app/src/style/custom_style.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('HomePage'),
            AuthButton(
                onPressed: () async {
                  await context
                      .read<AuthService>()
                      .signOut(
                        rootProvider: rootProvider,
                      )
                      .then((value) => Navigator.of(context)
                          .pushNamedAndRemoveUntil(LoginPage.routeName,
                              ModalRoute.withName(LoginPage.routeName)));
                },
                color: CustomStyle.primarycolor,
                child: const Text('Logout'))
          ],
        ),
      )),
    );
  }
}
