
import 'package:flutter/material.dart';
import 'package:service_sphere/features/main/screens/Home/widget/topBar_search.dart';

import '../../../../../constant/global_variable.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bbg.jpeg'),
              fit: BoxFit.cover)),
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.only(top: 0, bottom: 20),
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: [
          Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Column(
                  children: [
                     Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child:  Icon(
                            Icons.location_pin,
                            size : 24,
                            color: GlobalVariables.backgroundColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Dla Cameroon',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalVariables.backgroundColor
                                    ),
                                  ),
                                  Icon(
                                      Icons.arrow_drop_down_sharp,
                                    color: GlobalVariables.backgroundColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 125),
                          child: Icon(
                            Icons.notifications_sharp,
                            size: 30,
                            color: GlobalVariables.backgroundColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    TopSearchBar(),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
