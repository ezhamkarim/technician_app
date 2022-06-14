import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/user_controller.dart';
import 'package:technician_app/src/helper/general_helper.dart';
import 'package:technician_app/src/helper/size_helper.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/auth_services.dart';
import 'package:technician_app/src/style/custom_style.dart';
import 'package:technician_app/src/view/auth/login_page.dart';
import 'package:technician_app/src/view/home/admin/services_list_page.dart';
import 'package:technician_app/src/view/home/admin/technician_report_page.dart';
import 'package:technician_app/src/view/home/technician/feedback_list_page.dart';
import 'package:technician_app/src/view/home/technician/report_list_page.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    var firebaseUser = context.watch<User>();
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
      child: StreamBuilder<UserModel>(
          stream: UserController(firebaseUser.uid).read(rootProvider),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userModel = snapshot.data!;
              var role = GeneralHelper.getRole(userModel.role);
              switch (role) {
                case Role.admin:
                  return buildAdminDashboard();
                case Role.technician:
                  return buildTechnicianDashboard();
                case Role.customer:
                  return buildCustomerDashboard();
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
          }),
    ));
  }

  Widget buildTechnicianDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Home.',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title, FontWeight.w900),
        ),
        const SizedBox(
          height: 42,
        ),
        // buildTechnicianTopPartial(),
        // buildTechnicianRecentBookings(),
        buildTechnicianFeedback(),
        buildReportFeedback()
        // ListView(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   children: [
        //     CustomCard(
        //         child: Text(
        //       '1. Create Booking',
        //       style: CustomStyle.getStyle(
        //           Colors.white, FontSizeEnum.title2, FontWeight.w400),
        //     ))
        //   ],
        // )
      ],
    );
  }

  Widget buildTechnicianTopPartial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Overview',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Text(
                  '2',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
                Text(
                  'New',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.content2, FontWeight.w400),
                )
              ]),
              Column(children: [
                Text(
                  '12',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
                Text(
                  'In Progress',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.content2, FontWeight.w400),
                )
              ]),
              Column(children: [
                Text(
                  '6',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
                Text(
                  'Completed',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.content2, FontWeight.w400),
                )
              ]),
              Column(children: [
                Text(
                  '1',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
                Text(
                  'Delay',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.content2, FontWeight.w400),
                )
              ]),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  Widget buildTechnicianRecentBookings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Overview',
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
      ],
    );
  }

  Widget buildTechnicianFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feedbacks',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Feedbacks',
                style: CustomStyle.getStyle(
                    Colors.white, FontSizeEnum.content, FontWeight.w400),
              ),
              const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white)
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(FeedbackListPage.routeName, arguments: false);
          },
        ),
      ],
    );
  }

  Widget buildReportFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reports',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title2, FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reports',
                style: CustomStyle.getStyle(
                    Colors.white, FontSizeEnum.content, FontWeight.w400),
              ),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ReportListPage.routeName);
          },
        ),
      ],
    );
  }

  Widget buildAdminDashboard() {
    var rootProvider = context.read<RootProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomCard(
            onTap: () {
              Navigator.of(context).pushNamed(ServiceListPage.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Services',
                  style: CustomStyle.getStyle(
                      Colors.white, FontSizeEnum.content, FontWeight.w400),
                ),
                const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white)
              ],
            )),
        CustomCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Feedbacks',
                style: CustomStyle.getStyle(
                    Colors.white, FontSizeEnum.content, FontWeight.w400),
              ),
              const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white)
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(FeedbackListPage.routeName, arguments: true);
          },
        ),
        CustomCard(
            onTap: () {
              Navigator.of(context).pushNamed(TechnicianReportPage.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report',
                  style: CustomStyle.getStyle(
                      Colors.white, FontSizeEnum.content, FontWeight.w400),
                ),
                const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white)
              ],
            )),
        // CustomCard(
        //   child: Text(
        //     'Logout',
        //     style: CustomStyle.getStyle(
        //         Colors.white, FontSizeEnum.title2, FontWeight.w400),
        //   ),
        //   onTap: () async {
        //     await context
        //         .read<AuthService>()
        //         .signOut(rootProvider: rootProvider)
        //         .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
        //             LoginPage.routeName,
        //             ModalRoute.withName(LoginPage.routeName)));
        //   },
        // )
      ],
    );
  }

  Widget buildCustomerDashboard() {
    var rootProvider = context.watch<RootProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Home.',
          style: CustomStyle.getStyle(
              Colors.black, FontSizeEnum.title, FontWeight.bold),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            CustomCard(
                child: Text(
              '1. Create Booking',
              style: CustomStyle.getStyle(
                  Colors.white, FontSizeEnum.title2, FontWeight.w400),
            )),
            CustomCard(
                child: Text(
              '2. Deliver to the store',
              style: CustomStyle.getStyle(
                  Colors.white, FontSizeEnum.title2, FontWeight.w400),
            )),
            CustomCard(
                child: Text(
              '3. Wait for service',
              style: CustomStyle.getStyle(
                  Colors.white, FontSizeEnum.title2, FontWeight.w400),
            )),
            CustomCard(
                child: Text(
              '4. Collect from store',
              style: CustomStyle.getStyle(
                  Colors.white, FontSizeEnum.title2, FontWeight.w400),
            )),
          ],
        )
      ],
    );
  }
}
