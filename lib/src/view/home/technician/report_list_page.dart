import 'package:flutter/material.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

import '../../../style/custom_style.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({Key? key}) : super(key: key);
  static const routeName = '/index/reports';
  @override
  Widget build(BuildContext context) {
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
                  'Reports.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            AuthButton(
                onPressed: () async {},
                color: CustomStyle.primarycolor,
                child: const Text('Generate Daily'))
          ],
        ),
      )),
    );
  }
}
