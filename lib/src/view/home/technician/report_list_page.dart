import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/controller/pdf_controller.dart';
import 'package:technician_app/src/controller/pdf_paragraph_controller.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

import '../../../style/custom_style.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({Key? key}) : super(key: key);
  static const routeName = '/index/reports';

  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: StreamBuilder<List<Booking>>(
            stream: BookingController()
                .readForTechnician(rootProvider.userModel!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: CustomStyle.primarycolor,
                );
              } else {
                if (snapshot.hasData) {
                  var booking = snapshot.data!;
                  List<Booking> bookingInProgress = [];
                  List<Booking> bookingHistory = [];
                  try {
                    bookingInProgress = booking
                        .where(
                          (element) =>
                              element.status == 'IN PROGRESS' ||
                              element.status == 'BOOKED' ||
                              element.status == 'APPROVED',
                        )
                        .toList();
                    bookingHistory = booking
                        .where(
                          (element) => element.status == 'COMPLETED',
                        )
                        .toList();
                  } catch (e) {}
                  return Column(
                    children: [
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            'Reports.',
                            style: CustomStyle.getStyle(Colors.black,
                                FontSizeEnum.title, FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                                onPressed: () async {
                                  var date = DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now());
                                  final pdfFile =
                                      await PdfParagraphController.generate(
                                          'Report until $date ',
                                          bookingHistory);

                                  PdfController.openFile(pdfFile);
                                },
                                color: CustomStyle.primarycolor,
                                child: const Text('Generate Report')),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return Text(
                      'Error getting services has error ${snapshot.hasError} Error : ${snapshot.error}');
                }
              }
            }),
      )),
    );
  }
}
