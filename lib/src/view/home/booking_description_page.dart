import 'package:flutter/material.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/model/booking_model.dart';

import '../../style/custom_style.dart';

class BookingDescriptionPage extends StatefulWidget {
  const BookingDescriptionPage({Key? key, required this.booking})
      : super(key: key);
  static const routeName = '/index/booking-desc';
  final Booking booking;
  @override
  State<BookingDescriptionPage> createState() => _BookingDescriptionPageState();
}

class _BookingDescriptionPageState extends State<BookingDescriptionPage> {
  final bookingController = BookingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: StreamBuilder<Booking>(
            stream: bookingController.readOne(widget.booking.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: CustomStyle.primarycolor,
                );
              } else {
                if (snapshot.hasData) {
                  var booking = snapshot.data!;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BackButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: Text(
                              booking.services[0].name,
                              style: CustomStyle.getStyle(Colors.black,
                                  FontSizeEnum.title, FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Text(
                      'Error getting services has error ${snapshot.hasError}');
                }
              }
            }),
      )),
    );
  }
}
