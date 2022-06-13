import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technician_app/src/view/home/booking_page.dart';
import 'package:technician_app/src/view/home/home_page.dart';
import 'package:technician_app/src/view/home/profile_page.dart';

import '../../style/custom_style.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);
  static const routeName = '/index';
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;
  List<Widget> screens = const [HomePage(), BookingPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme:
              const IconThemeData(color: CustomStyle.primarycolor),
          unselectedIconTheme:
              const IconThemeData(color: CustomStyle.secondaryColor),
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.book), label: 'Book'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.circleUser), label: 'Profile')
          ]),
    );
  }
}
