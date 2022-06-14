import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../style/custom_style.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);
  static const routeName = '/index/contact-us';
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Contact Us.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            const Text(
              'If there is any enquiry, please email or call us at:',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 48,
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: const Text('nazruladamcheah@gmail.com'),
              onTap: () async {
                launchUrl(Uri.parse(
                    'mailto:nazruladamcheah@gmail.com?subject=SVCente Enquiryr&body=I want try this more!'));
              },
            ),
            const Divider(
              color: CustomStyle.secondaryColor,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Phone'),
              subtitle: const Text('010-7059843'),
              onTap: () async {
                launchUrl(Uri.parse("tel://010-7059843"));
              },
            ),
            const Divider(
              color: CustomStyle.secondaryColor,
              thickness: 1,
            ),
          ],
        ),
      )),
    );
  }
}
// 