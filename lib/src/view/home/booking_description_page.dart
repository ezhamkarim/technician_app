import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';
import 'package:technician_app/src/helper/general_helper.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/custom_card.dart';

import '../../model/user_model.dart';
import '../../style/custom_style.dart';

class BookingDescriptionPage extends StatefulWidget {
  const BookingDescriptionPage(
      {Key? key, required this.booking, required this.role})
      : super(key: key);
  static const routeName = '/index/booking-desc';
  final Booking booking;
  final Role role;
  @override
  State<BookingDescriptionPage> createState() => _BookingDescriptionPageState();
}

class _BookingDescriptionPageState extends State<BookingDescriptionPage> {
  final bookingController = BookingController();
  List<String> status = ['BOOKED', 'APPROVED', 'IN PROGRESS', 'COMPLETED'];
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 24,
                      ),
                      Text(DateFormat('dd/MM/yyyy').format(booking.dateTime)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Estimated Time',
                                style: CustomStyle.getStyle(Colors.black,
                                    FontSizeEnum.content, FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(GeneralHelper.calculateTimeDifferenceBetween(
                                  startDate: booking.dateTime,
                                  endDate: booking.estimateTime))
                            ],
                          ),
                          booking.status == 'COMPLETED'
                              ? Container()
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: CustomStyle.primarycolor,
                                    side: const BorderSide(
                                        width: 1.0,
                                        color: CustomStyle.primarycolor),
                                  ),
                                  onPressed: () async {
                                    var datePicked = await showDatePicker(
                                        context: context,
                                        initialDate: booking.estimateTime,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2023, 1, 1));

                                    if (datePicked == null) return;
                                    booking.estimateTime = datePicked;
                                    await bookingController.update(
                                        booking, rootProvider);
                                  },
                                  child: const Text('Update'))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Status',
                            style: CustomStyle.getStyle(Colors.black,
                                FontSizeEnum.content, FontWeight.bold),
                          ),
                          CustomCard(
                              child: Row(
                            children: [
                              Text(booking.status,
                                  style: CustomStyle.getStyle(Colors.white,
                                      FontSizeEnum.content, FontWeight.bold))
                            ],
                          )),
                          booking.status == 'COMPLETED'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        primary: CustomStyle.primarycolor,
                                        side: const BorderSide(
                                            width: 1.0,
                                            color: CustomStyle.primarycolor),
                                      ),
                                      onPressed: () async {
                                        DialogHelper.dialogUpdateBooking(
                                            context,
                                            'Update Booking',
                                            '',
                                            status,
                                            booking: booking,
                                            bookingController:
                                                bookingController);
                                        // var datePicked = await showDatePicker(
                                        //     context: context,
                                        //     initialDate: booking.estimateTime,
                                        //     firstDate: DateTime.now(),
                                        //     lastDate: DateTime(2023, 1, 1));

                                        // if (datePicked == null) return;
                                        // booking.estimateTime = datePicked;
                                        // await bookingController.update(
                                        //     booking, rootProvider);
                                      },
                                      child: const Text('Update Status')),
                                )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.role == Role.technician
                                  ? 'Customer'
                                  : 'Technician',
                              style: CustomStyle.getStyle(Colors.black,
                                  FontSizeEnum.content, FontWeight.bold),
                            ),
                            CustomCard(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(booking.customerName,
                                    style: CustomStyle.getStyle(Colors.white,
                                        FontSizeEnum.content, FontWeight.bold)),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                          FontAwesomeIcons.phone,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const FaIcon(
                                          FontAwesomeIcons.solidMessage,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            )),
                          ]),
                      const SizedBox(
                        height: 18,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Request',
                              style: CustomStyle.getStyle(Colors.black,
                                  FontSizeEnum.content, FontWeight.bold),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: booking.services.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(booking.services[i].name),
                                        const Icon(
                                            FontAwesomeIcons.chevronRight)
                                      ],
                                    ),
                                    onTap: () async {},
                                  );
                                }),
                          ]),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:RM${booking.total.toString()}',
                            style: CustomStyle.getStyle(Colors.black,
                                FontSizeEnum.content, FontWeight.bold),
                          ),
                          AuthButton(
                              viewState: rootProvider.viewState,
                              onPressed: () {},
                              color: CustomStyle.primarycolor,
                              child: const Text('New Info')),
                        ],
                      )
                    ],
                  );
                } else {
                  return Text(
                      'Error getting services has error ${snapshot.hasError}, Error : ${snapshot.error}');
                }
              }
            }),
      )),
    );
  }
}
