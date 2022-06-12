import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technician_app/src/style/custom_style.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const routeName = '/landing';
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SvgPicture.asset('assets/images/home_pic.svg'),
            )),
            Row(
              children: [
                Expanded(
                  child: AuthButton(
                      onPressed: () {
                        // TODO: set the app first time usage in the

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginPage.routeName,
                            ModalRoute.withName(LoginPage.routeName));
                      },
                      color: CustomStyle.primarycolor,
                      child: Text(
                        'Get Started',
                        style: CustomStyle.getStyle(
                            Colors.white, FontSizeEnum.title2, FontWeight.w500),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
