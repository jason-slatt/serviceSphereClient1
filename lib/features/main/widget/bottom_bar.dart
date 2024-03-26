import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:badges/badges.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/main/screens/appointment_screen.dart';


class BottomBar extends StatefulWidget {
  static const String routName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const Center(child : Text('Account page page')),


  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar:FFNavigationBar(
        theme: FFNavigationBarTheme(
          barHeight: 70,
          barBackgroundColor: Colors.white,
          //selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: GlobalVariables.secondaryColor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: _page,
        onSelectTab: (index) {
          setState(() {
            _page = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.calendar_today,
            label: 'appointment',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
