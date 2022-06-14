import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/controller/pdf_controller.dart';
import 'package:technician_app/src/controller/pdf_paragraph_controller.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

import '../../../style/custom_style.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({Key? key, this.technician}) : super(key: key);

  static const routeName = '/index/reports';
  final UserModel? technician;
  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: StreamBuilder<List<Booking>>(
            stream: BookingController().readForTechnician(
                widget.technician == null
                    ? rootProvider.userModel!.id
                    : widget.technician!.id),
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
                              element.status == 'WAITING APPROVAL' ||
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
                                  String name = '';
                                  if (widget.technician != null) {
                                    name = widget.technician!.name;
                                  }
                                  var date = DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now());
                                  final pdfFile =
                                      await PdfParagraphController.generate(
                                          'Report $name until $date ',
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
