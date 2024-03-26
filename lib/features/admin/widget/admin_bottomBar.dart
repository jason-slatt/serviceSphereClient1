import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:badges/badges.dart';
import 'package:service_sphere/features/admin/screens/admin_screen.dart';
import 'package:service_sphere/features/admin/screens/post_sreen.dart';
import 'package:service_sphere/features/admin/screens/profile.dart';
import 'package:service_sphere/features/admin/screens/tools_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/main/screens/appointment_screen.dart';
import 'package:service_sphere/providers/user_provider.dart';

import '../screens/profile2.dart';


class AdminBottomBar extends StatefulWidget {
  static const String routName = '/actual-AdminHome';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int _page = 0;
  double bottomBarWidth = 5;
  double bottomBarBorderWidth = 48;

  List<Widget> pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const BusinessTools(),
    const AdminProfile2(),
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: FFNavigationBar(
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
            iconData: Icons.add_business,
            label: 'tools',
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
