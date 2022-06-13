import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/feedback_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/feedback_model.dart' as feedback;

import '../../../style/custom_style.dart';

class FeedbackListPage extends StatefulWidget {
  static const routeName = '/index/feedback';
  const FeedbackListPage({Key? key}) : super(key: key);

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final feedbackController = FeedbackController();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    logInfo('User Id : ${firebaseUser.uid}');
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Feedbacks.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            StreamBuilder<List<feedback.Feedback>>(
                stream: feedbackController.read(query: firebaseUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var feedbacks = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: feedbacks.length,
                          itemBuilder: (context, i) {
                            return Row(
                              children: [Text(feedbacks[i].comment)],
                            );
                          });
                    } else {
                      return Text(
                          'Error getting feedback has error ${snapshot.hasError}. Error ${snapshot.error}');
                    }
                  }
                })
          ],
        ),
      )),
    );
  }
}
