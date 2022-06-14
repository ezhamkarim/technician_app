import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/home/technician/block_appointment_page.dart';

import '../../controller/user_controller.dart';
import '../../helper/general_helper.dart';
import '../../services/auth_services.dart';
import '../../style/custom_style.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
    final firebaseUser = context.watch<User?>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile.',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.title, FontWeight.w900),
            ),
            const SizedBox(
              height: 42,
            ),
            firebaseUser == null
                ? Container()
                : StreamBuilder<UserModel>(
                    stream: UserController(firebaseUser.uid).read(rootProvider),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var userModel = snapshot.data!;
                        var role = GeneralHelper.getRole(userModel.role);
                        switch (role) {
                          case Role.admin:
                            return adminProfile(rootProvider);
                          case Role.technician:
                            return technicianProfile(rootProvider);
                          case Role.customer:
                            return customerProfile(rootProvider);
                          default:
                            return Container();
                        }
                      } else {
                        return Text('Error ${snapshot.error}');
                      }
                    }),
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
            // AuthButton(
            //     viewState: rootProvider.viewState,
            //     onPressed: () async {
            //       await context
            //           .read<AuthService>()
            //           .signOut(
            //             rootProvider: rootProvider,
            //           )
            //           .then((value) => Navigator.of(context)
            //               .pushNamedAndRemoveUntil(LoginPage.routeName,
            //                   ModalRoute.withName(LoginPage.routeName)));
            //     },
            //     color: CustomStyle.primarycolor,
            //     child: const Text('Logout'))
          ],
        ),
      ),
    );
  }

  Widget technicianProfile(RootProvider rootProvider) {
    return Column(
      children: [
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
        ListTile(
          title: const Text('Log out'),
          onTap: () async {
            await context
                .read<AuthService>()
                .signOut(
                  rootProvider: rootProvider,
                )
                .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginPage.routeName,
                    ModalRoute.withName(LoginPage.routeName)));
          },
        ),
      ],
    );
  }

  Widget adminProfile(RootProvider rootProvider) {
    return Column(
      children: [
        ListTile(
          title: const Text('Log out'),
          onTap: () async {
            await context
                .read<AuthService>()
                .signOut(
                  rootProvider: rootProvider,
                )
                .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginPage.routeName,
                    ModalRoute.withName(LoginPage.routeName)));
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
      ],
    );
  }

  Widget customerProfile(RootProvider rootProvider) {
    return Column(
      children: [
        ListTile(
          title: const Text('Log out'),
          onTap: () async {
            await context
                .read<AuthService>()
                .signOut(
                  rootProvider: rootProvider,
                )
                .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginPage.routeName,
                    ModalRoute.withName(LoginPage.routeName)));
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
      ],
    );
  }
}
