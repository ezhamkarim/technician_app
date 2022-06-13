import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/services/auth_services.dart';
import 'package:technician_app/src/view/widgets/create_button.dart';

import '../../controller/user_controller.dart';
import '../../helper/general_helper.dart';
import '../../helper/size_helper.dart';
import '../../model/user_model.dart';
import '../../provider/root_provider.dart';
import '../../style/custom_style.dart';
import '../auth/login_page.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_card.dart';
import 'customer/booking_create_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    var firebaseUser = context.watch<User>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(children: [
          StreamBuilder<UserModel>(
              stream: UserController(firebaseUser.uid).read(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userModel = snapshot.data!;
                  var role = GeneralHelper.getRole(userModel.role);
                  switch (role) {
                    case Role.technician:
                      return buildTechnicianBooking();
                    case Role.customer:
                      return buildCustomerBooking();
                    default:
                      return Column(
                        children: [
                          Text('HomePage ${userModel.name} '),
                          AuthButton(
                              onPressed: () async {
                                await context
                                    .read<AuthService>()
                                    .signOut(
                                      rootProvider: rootProvider,
                                    )
                                    .then((value) => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            LoginPage.routeName,
                                            ModalRoute.withName(
                                                LoginPage.routeName)));
                              },
                              color: CustomStyle.primarycolor,
                              child: const Text('Logout'))
                        ],
                      );
                  }
                } else {
                  return Text('Error ${snapshot.error}');
                }
              })
        ]),
      ),
    );
  }

  Widget buildTechnicianBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking.',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title, FontWeight.w900),
        ),
        const SizedBox(
          height: 42,
        ),
        Text(
          'In Progress',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              SizedBox(
                  width: SizeHelper(context).scaledWidth() - 64,
                  child: const CustomCard(child: Text('Hello'))),
              SizedBox(
                  width: SizeHelper(context).scaledWidth() - 64,
                  child: const CustomCard(child: Text('Hello'))),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'History',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Feedbacks'),
                  FaIcon(FontAwesomeIcons.chevronRight)
                ],
              ),
            ),
            CustomCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Feedbacks'),
                  FaIcon(FontAwesomeIcons.chevronRight)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCustomerBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Booking.',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.title, FontWeight.w900),
            ),
            CreateButton(onPressed: () {
              Navigator.of(context).pushNamed(BookingCreatePage.routeName);
            })
          ],
        ),
        const SizedBox(
          height: 42,
        ),
        Text(
          'History',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              SizedBox(
                  width: SizeHelper(context).scaledWidth() - 64,
                  child: const CustomCard(child: Text('Hello'))),
              SizedBox(
                  width: SizeHelper(context).scaledWidth() - 64,
                  child: const CustomCard(child: Text('Hello'))),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'History',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        ListView(
          shrinkWrap: true,
          children: const [
            CustomCard(child: Text('Hello')),
            CustomCard(child: Text('Hello')),
          ],
        ),
      ],
    );
  }
}
