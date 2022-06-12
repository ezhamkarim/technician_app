import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technician_app/src/style/custom_style.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(64, 120, 64, 64),
        child: Column(
          children: [
            Text(
              'Technician Appointment System',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.title, FontWeight.bold),
            ),
            Expanded(child: SvgPicture.asset('assets/images/home_pic.svg')),
            AuthButton(
                onPressed: () {
                  // TODO: set the app first time usage in the
                },
                color: CustomStyle.primarycolor,
                child: const Text('Get Started'))
          ],
        ),
      ),
    );
  }
}
