import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';

import '../style/custom_style.dart';

class DialogHelper {
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(onPressed: onPressed, child: const Text('Okay'))
            ],
          );
        });
  }

  static Future dialogUpdateBooking(
      BuildContext context, String title, String desc, List<String> list,
      {required BookingController bookingController,
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
                                        await bookingController.update(
                                            booking, rootProvider);
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
