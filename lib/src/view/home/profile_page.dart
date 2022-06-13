import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/home/technician/block_appointment_page.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
          children: [
            const Text('Profile Screen'),
            ListTile(
              title: const Text('Appointment'),
              onTap: () {
                Navigator.of(context).pushNamed(BlockAppointmentPage.routeName);
              },
            ),
            const Divider(
              color: CustomStyle.secondaryColor,
              thickness: 1,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(BlockAppointmentPage.routeName);
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text('Appointment'),
            //         SizedBox(
            //           height: 8,
            //         ),
            //         Divider(
            //           color: CustomStyle.secondaryColor,
            //           thickness: 1,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
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
      ),
    );
  }
}
