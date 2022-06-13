import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/provider/root_provider.dart';

import '../../services/auth_services.dart';
import '../../style/custom_style.dart';
import '../auth/login_page.dart';
import '../widgets/auth_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
    return Container(
      child: Column(
        children: [
          const Text('Profile Screen'),
          AuthButton(
              viewState: rootProvider.viewState,
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
    );
  }
}
