import 'package:flutter/material.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';

import '../../../../constant/global_variable.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late TabController _controller = TabController(length: 5, vsync: this);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  double bottomBarWidth = 23;
  double bottomBarBorderWidth = 5;


  void updatePage(int page){
    _controller.animateTo(_page += 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        bottom: TabBar(
          controller: _controller,
          onTap: updatePage,
          tabs: [
            Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Container(
                      width:60,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide.none,
                              bottom:BorderSide(
                                color: _page == 0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                              )
                          )
                      ),
                      child: const Text('About')
                  ),
                  Container(
                      width: 60 ,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide.none,
                              bottom:BorderSide(
                                color: _page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                              )
                          )
                      ),
                      child: const Text('Services')
                  ),
                  Container(
                      width:60 ,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide.none,
                              bottom:BorderSide(
                                color: _page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                              )
                          )
                      ),
                      child: const Text('Gallery')
                  ),
                  Container(
                      width:60 ,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide.none,
                              bottom:BorderSide(
                                color: _page == 3 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                              )
                          )
                      ),
                      child: const Text('Review')
                  ),


                ]

            ),



          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget> [
          const Text('u'),
          const Text('b'),
          const Text('v')
        ],
      ),
        );


    DefaultTabController(
      length: 2,
      child : Column(
        children: <Widget>[
          // the tab bar with two items
          SizedBox(
            height:6,
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.directions_bike),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.directions_car,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // create widgets for each tab bar here
          SizedBox(
            height: 6,
            child: TabBarView(
              children: [
                // first tab bar view widget
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Bike',
                    ),
                  ),
                ),

                // second tab bar viiew widget
                Container(
                  color: Colors.pink,
                  child: Center(
                    child: Text(
                      'Car',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}