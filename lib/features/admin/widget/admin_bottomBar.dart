import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:badges/badges.dart';
import 'package:service_sphere/features/admin/screens/admin_screen.dart';
import 'package:service_sphere/features/admin/screens/post_sreen.dart';
import 'package:service_sphere/features/admin/screens/profile.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/providers/user_provider.dart';


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
    const PostScreen(),
    const AdminProfile(),


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
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 25,
        selectedFontSize: 30,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unSelectedNavBarColor,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(
              icon: Container(
            width:bottomBarWidth ,
            height: 10,
            child: const  Icon(
              Icons.home_outlined,
            ),
          ),
              label: ''
          ),
          //Booking
          BottomNavigationBarItem(icon: Container(
            width:bottomBarWidth ,
            height: 3,
            child: const  Icon(
              Icons.publish_outlined,
            ),
          ),
              label: ''
          ),
          //Account
          BottomNavigationBarItem(icon: Container(
            width:bottomBarWidth ,
            height: 3,
            child: const  Icon(
              Icons.person_2_outlined,
            ),
          ),
              label: ''
          )
        ],
      ),
    );
  }
}
