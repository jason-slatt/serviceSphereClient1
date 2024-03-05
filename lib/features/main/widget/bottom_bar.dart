import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:badges/badges.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';


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
    const Center(child : Text('Booking page')),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unSelectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(icon: Container(
            width:bottomBarWidth ,
            decoration: BoxDecoration(
              border: Border(
                top:BorderSide(
                  color: _page == 0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth
                )
              )
            ),
            child: const  Icon(
              Icons.home_outlined,
            ),
          ),
            label: ''
          ),
          //Booking
          BottomNavigationBarItem(icon: Container(
            width:bottomBarWidth ,
            decoration: BoxDecoration(
                border: Border(
                    top:BorderSide(
                        color: _page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth
                    )
                )
            ),
            child: const  Icon(
              Icons.calendar_month_outlined,
            ),
          ),
              label: ''
          ),
          //Account
          BottomNavigationBarItem(icon: Container(
            width:bottomBarWidth ,
            decoration: BoxDecoration(
                border: Border(
                    top:BorderSide(
                        color: _page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth
                    )
                )
            ),
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
