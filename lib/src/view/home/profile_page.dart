import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/home/about_us_page.dart';
import 'package:technician_app/src/view/home/contact_us_page.dart';
import 'package:technician_app/src/view/home/technician/block_appointment_page.dart';
import 'package:path/path.dart' as pathFile;
import '../../controller/user_controller.dart';
import '../../helper/general_helper.dart';
import '../../services/auth_services.dart';
import '../../style/custom_style.dart';
import '../auth/login_page.dart';
import '../widgets/upload_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loadingImage = true;
  String? path;
  Map dataToUpload = {'destination': null, 'file': null};
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
                            return adminProfile(rootProvider, userModel);
                          case Role.technician:
                            return technicianProfile(rootProvider, userModel);
                          case Role.customer:
                            return customerProfile(rootProvider, userModel);
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

  Widget technicianProfile(RootProvider rootProvider, UserModel userModel) {
    return Column(
      children: [
        UploadAvatar(
          profilePic: userModel.pictureLink,
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png'],
            );
            if (result != null) {
              //File file = File(result.files.single.path);
              PlatformFile platformFile = result.files.first;
              setState(() {
                path = platformFile.path!;
                dataToUpload['destination'] =
                    'profilePic/${pathFile.basename(path!)}';
                dataToUpload['file'] = File(path!);
              });
              logError('This is basename :$dataToUpload');

              await UserController(userModel.id)
                  .updateImage(userModel, dataToUpload);
            }
          },
        ),
        ListTile(
          title: const Text('Name'),
          subtitle: Text(userModel.name),
          onTap: () async {
            DialogHelper.updateProfileName(
                context, 'Update Name', 'Name', userModel);
          },
        ),
        ListTile(
          title: const Text('Email'),
          subtitle: Text(userModel.email),
          onTap: () async {},
        ),
        ListTile(
          title: const Text('Phone Number'),
          subtitle: Text(userModel.phoneNumber),
          onTap: () async {
            DialogHelper.updateProfilePhone(
                context, 'Update Phone', 'Phone', userModel);
          },
        ),
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
          title: const Text('About us'),
          onTap: () async {
            Navigator.of(context).pushNamed(AboutUsPage.routeName);
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
        ListTile(
          title: const Text('Contact us'),
          onTap: () async {
            Navigator.of(context).pushNamed(ContactUsPage.routeName);
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
        ListTile(
          title: const Text('Reset Password'),
          onTap: () async {
            DialogHelper.dialogWithAction(
                context, 'Warning', 'Are you sure want to reset password',
                onPressed: () async {
              await context
                  .read<AuthService>()
                  .sendResetPasswordLink(
                      email: userModel.email, rootProvider: rootProvider)
                  .then((value) {
                Navigator.of(context).pop();
                return DialogHelper.dialogWithOutActionWarning(
                    context, 'Succesfully sent!');
              }).catchError((e) {
                DialogHelper.dialogWithOutActionWarning(
                    context, 'Failed to sent');
              });
            });
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
                .signOut(rootProvider: rootProvider, userModel: userModel)
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

  Widget adminProfile(RootProvider rootProvider, UserModel userModel) {
    return Column(
      children: [
        UploadAvatar(
          profilePic: userModel.pictureLink,
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png'],
            );
            if (result != null) {
              //File file = File(result.files.single.path);
              PlatformFile platformFile = result.files.first;
              setState(() {
                path = platformFile.path!;
                dataToUpload['destination'] =
                    'profilePic/${pathFile.basename(path!)}';
                dataToUpload['file'] = File(path!);
              });
              logError('This is basename :$dataToUpload');

              await UserController(userModel.id)
                  .updateImage(userModel, dataToUpload);
            }
          },
        ),
        ListTile(
          title: const Text('Name'),
          subtitle: Text(userModel.name),
          onTap: () async {
            DialogHelper.updateProfileName(
                context, 'Update Name', 'Name', userModel);
          },
        ),
        ListTile(
          title: const Text('Email'),
          subtitle: Text(userModel.email),
          onTap: () async {},
        ),
        ListTile(
          title: const Text('Phone Number'),
          subtitle: Text(userModel.phoneNumber),
          onTap: () async {
            DialogHelper.updateProfilePhone(
                context, 'Update Phone', 'Phone', userModel);
          },
        ),
        ListTile(
          title: const Text('About us'),
          onTap: () async {
            Navigator.of(context).pushNamed(AboutUsPage.routeName);
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
        ListTile(
          title: const Text('Contact us'),
          onTap: () async {
            Navigator.of(context).pushNamed(ContactUsPage.routeName);
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
                .signOut(rootProvider: rootProvider, userModel: userModel)
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

  Widget customerProfile(RootProvider rootProvider, UserModel userModel) {
    final firebaseUser = context.watch<User>();
    return Column(
      children: [
        UploadAvatar(
          profilePic: userModel.pictureLink,
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png'],
            );
            if (result != null) {
              //File file = File(result.files.single.path);
              PlatformFile platformFile = result.files.first;
              setState(() {
                path = platformFile.path!;
                dataToUpload['destination'] =
                    'profilePic/${pathFile.basename(path!)}';
                dataToUpload['file'] = File(path!);
              });
              logError('This is basename :$dataToUpload');

              await UserController(userModel.id)
                  .updateImage(userModel, dataToUpload);
            }
          },
        ),
        ListTile(
          title: const Text('Name'),
          subtitle: Text(userModel.name),
          onTap: () async {
            DialogHelper.updateProfileName(
                context, 'Update Name', 'Name', userModel);
          },
        ),
        ListTile(
          title: const Text('Email'),
          subtitle: Text(userModel.email),
          onTap: () async {},
        ),
        ListTile(
          title: const Text('Phone Number'),
          subtitle: Text(userModel.phoneNumber),
          onTap: () async {
            DialogHelper.updateProfilePhone(
                context, 'Update Phone', 'Phone', userModel);
          },
        ),
        ListTile(
          title: const Text('About us'),
          onTap: () async {
            Navigator.of(context).pushNamed(AboutUsPage.routeName);
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
        ListTile(
          title: const Text('Contact us'),
          onTap: () async {
            Navigator.of(context).pushNamed(ContactUsPage.routeName);
          },
        ),
        const Divider(
          color: CustomStyle.secondaryColor,
          thickness: 1,
        ),
        ListTile(
          title: const Text('Reset Password'),
          onTap: () async {
            DialogHelper.updatePassword(
                context, 'Nofication', 'Password', firebaseUser);
            // DialogHelper.dialogWithAction(
            //     context, 'Warning', 'Are you sure want to reset password',
            //     onPressed: () async {
            //   await context
            //       .read<AuthService>()
            //       .sendResetPasswordLink(
            //           email: userModel.email, rootProvider: rootProvider)
            //       .then((value) {
            //     Navigator.of(context).pop();
            //     return DialogHelper.dialogWithOutActionWarning(
            //         context, 'Succesfully sent!');
            //   }).catchError((e) {
            //     DialogHelper.dialogWithOutActionWarning(
            //         context, 'Failed to sent');
            //   });
            // });
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
                .signOut(rootProvider: rootProvider, userModel: userModel)
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
