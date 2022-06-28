import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/home/customer/services_list_selection_page.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../controller/user_controller.dart';
import '../model/service_model.dart';
import '../style/custom_style.dart';

class DialogHelper {
  static Future updateProfilePhone(BuildContext context, String title,
      String placeHolder, UserModel userModel) {
    final ctrl = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: AuthTextField(
              textEditingController: ctrl,
              placeholder: placeHolder,
            ),
            actions: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: CustomStyle.primarycolor,
                      side: const BorderSide(color: CustomStyle.primarycolor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  userModel.phoneNumber = ctrl.text;
                  await UserController(userModel.id).update(userModel);
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, primary: CustomStyle.primarycolor),
              )
            ],
          );
        });
  }

  static Future getAllServices(
      BuildContext context, String title, String desc, List<Service> services) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Services'),
              ListServices(services: services)
            ]),
            actions: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: CustomStyle.primarycolor,
                      side: const BorderSide(color: CustomStyle.primarycolor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, primary: CustomStyle.primarycolor),
              )
            ],
          );
        });
  }

  static Future updateProfileName(BuildContext context, String title,
      String placeHolder, UserModel userModel) {
    final ctrl = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: AuthTextField(
              textEditingController: ctrl,
              placeholder: placeHolder,
            ),
            actions: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: CustomStyle.primarycolor,
                      side: const BorderSide(color: CustomStyle.primarycolor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  userModel.name = ctrl.text;
                  await UserController(userModel.id).update(userModel);
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, primary: CustomStyle.primarycolor),
              )
            ],
          );
        });
  }

  static Future updatePassword(
      BuildContext context, String title, String placeHolder, User user) {
    final ctrl = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: AuthTextField(
              textEditingController: ctrl,
              isObsecure: true,
              placeholder: placeHolder,
            ),
            actions: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: CustomStyle.primarycolor,
                      side: const BorderSide(color: CustomStyle.primarycolor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  await user.updatePassword(ctrl.text).then((value) {
                    Navigator.of(context).pop();
                    DialogHelper.dialogWithOutActionWarning(
                        context, 'Succesfully update password');
                  }).catchError((e) {
                    Navigator.of(context).pop();
                    DialogHelper.dialogWithOutActionWarning(
                        context, e.toString());
                  });
                },
                child: const Text('Okay'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, primary: CustomStyle.primarycolor),
              )
            ],
          );
        });
  }

  static Future dialogWithAction(
      BuildContext context, String title, String desc,
      {required void Function() onPressed}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: CustomStyle.primarycolor,
                      side: const BorderSide(color: CustomStyle.primarycolor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Okay'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, primary: CustomStyle.primarycolor),
              )
            ],
          );
        });
  }

  static Future dialogWithOutActionWarning(
    BuildContext context,
    String title,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: CustomStyle.primarycolor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'))
            ],
          );
        });
  }

  static Future dialogUpdateBooking(
      BuildContext context, String title, String desc, List<String> list,
      {required BookingController bookingController,
      required UserModel customer,
      required Booking booking}) {
    return showDialog(
        context: context,
        builder: (context) {
          var rootProvider = context.read<RootProvider>();
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(desc),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: list
                      .map((e) => Column(
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    booking.status == e
                                        ? const SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Icon(FontAwesomeIcons.check))
                                        : Container(),
                                    Text(e),
                                  ],
                                ),
                                onTap: booking.status == e
                                    ? null
                                    : () async {
                                        booking.status = e;
                                        await bookingController
                                            .update(booking, rootProvider)
                                            .then((value) {
                                          logSuccess(
                                              'Customer : ${customer.pushToken}');
                                        }).catchError((e) {
                                          logError(
                                              'Error update status ${e.toString()}');
                                          DialogHelper
                                              .dialogWithOutActionWarning(
                                                  context,
                                                  'Fail to update status ');
                                        });
                                        Navigator.of(context).pop();
                                      },
                              ),
                              e == list.last
                                  ? Container()
                                  : const Divider(
                                      color: CustomStyle.secondaryColor,
                                      thickness: 1,
                                    ),
                            ],
                          ))
                      .toList(),
                )
              ],
            ),
            // actions: [
            //   OutlinedButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: const Text('Cancel')),
            //   ElevatedButton(onPressed: onPressed, child: const Text('Okay'))
            // ],
          );
        });
  }
}
