import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/controller/feedback_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/feedback_model.dart' as feedback;
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../../../model/booking_model.dart';
import '../../../style/custom_style.dart';

class FeedbackCreatePage extends StatefulWidget {
  const FeedbackCreatePage({Key? key, required this.booking}) : super(key: key);
  static const routeName = '/index/booking/feedback';
  final Booking booking;
  @override
  State<FeedbackCreatePage> createState() => _FeedbackCreatePageState();
}

class _FeedbackCreatePageState extends State<FeedbackCreatePage> {
  List<bool> booleans = [true, false];
  final commentController = TextEditingController();
  final feedbackController = FeedbackController();
  final bookingCtrl = BookingController();
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
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
                    'Feedback.',
                    style: CustomStyle.getStyle(
                        Colors.black, FontSizeEnum.title, FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      booleans[1] = !booleans[1];
                      booleans[0] = !booleans[0];
                    });
                  },
                  child: Card(
                    color: booleans[0] == true
                        ? CustomStyle.primarycolor
                        : CustomStyle.secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Good',
                        style: CustomStyle.getStyle(Colors.white,
                            FontSizeEnum.content, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      booleans[1] = !booleans[1];
                      booleans[0] = !booleans[0];
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    color: booleans[1] == true
                        ? CustomStyle.primarycolor
                        : CustomStyle.secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Bad',
                        style: CustomStyle.getStyle(Colors.white,
                            FontSizeEnum.content, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            AuthTextField(
              textEditingController: commentController,
              placeholder: 'Comment',
            ),
            const SizedBox(
              height: 56,
            ),
            Row(
              children: [
                Expanded(
                  child: AuthButton(
                      onPressed: () async {
                        int rating = 0;
                        if (booleans[1]) {
                          rating = 1;
                        }
                        var feedbackObj = feedback.Feedback(
                            id: '',
                            comment: commentController.text,
                            rating: rating,
                            technicianId: widget.booking.technicianId,
                            userId: widget.booking.customerId,
                            dateTime: widget.booking.dateTime,
                            bookingId: widget.booking.id);
                        logSuccess('Feedback obj : ${feedbackObj.toMap()}');
                        await feedbackController.create(feedbackObj);
                        widget.booking.isFeedback = true;
                        await bookingCtrl.update(widget.booking, rootProvider);
                        Navigator.of(context).pop();
                      },
                      color: CustomStyle.primarycolor,
                      child: Text(
                        'Submit',
                        style: CustomStyle.getStyle(Colors.white,
                            FontSizeEnum.content, FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
