import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/feedback_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/feedback_model.dart' as feedback;

import '../../../style/custom_style.dart';

class FeedbackListPage extends StatefulWidget {
  static const routeName = '/index/feedback';
  const FeedbackListPage({Key? key, required this.fromAdmin}) : super(key: key);
  final bool fromAdmin;
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
                stream: widget.fromAdmin
                    ? feedbackController.readAll()
                    : feedbackController.read(query: firebaseUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var feedbacks = snapshot.data!;
                      return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: feedbacks.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(feedbacks[i].comment)),
                                      feedbacks[i].rating == 0
                                          ? const FaIcon(
                                              FontAwesomeIcons.thumbsUp,
                                              color: CustomStyle.primarycolor,
                                            )
                                          : const FaIcon(
                                              FontAwesomeIcons.thumbsDown,
                                              color: CustomStyle.primarycolor,
                                            )
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(
                                    //     BlockAppointmentPage.routeName);
                                  },
                                ),
                                const Divider(
                                  color: CustomStyle.secondaryColor,
                                  thickness: 1,
                                ),
                              ],
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
