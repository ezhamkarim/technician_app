import 'package:flutter/material.dart';

import '../../style/custom_style.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);
  static const routeName = '/index/about-us';
  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
                  'About Us.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Image.asset('assets/images/logo_panjang.jpg'),
            const SizedBox(
              height: 48,
            ),
            const Text(
              'Aplikasi SVCenter ini dapat memudahkan para pelanggan yang berkeperluan dalam penyelenggaraan komputer untuk membuat tempahan. Aplikasi ini juga dapat memudahkan pekerja dalam menguruskan masa dalam membuat penyelenggaraan dengan masa yang tersusun. Aplikasi ini menjadikan jalan kerja bagi pekerja serta pelanggan dengan lebih teratur dan mudah',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      )),
    );
  }
}
// 