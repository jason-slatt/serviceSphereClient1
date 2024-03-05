import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/category_list.dart';
import 'package:service_sphere/features/main/screens/Home/widget/categories.dart';
import 'package:service_sphere/features/main/screens/Home/widget/home_topBar.dart';
import 'package:service_sphere/features/main/services/product.dart';
import 'package:service_sphere/providers/user_provider.dart';

import '../../../../../model/service_category.dart';
import '../../../constant/global_variable.dart';
import '../../main/screens/Home/widget/topBar_search.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/AdminHome';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late Future<List<Category>> categories;
  @override
  void initState() {
    categories = productServices.fetchServices();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return  Scaffold(
      appBar: AppBar(
        elevation: 40,
        toolbarHeight: 120,
        backgroundColor: Colors.black,
        title:  Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child:  Icon(
                            Icons.location_pin,
                            size : 16,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalVariables.backgroundColor
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 210),
                          child: Icon(
                            Icons.notifications_sharp,
                            size: 16,
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
            ]
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Categories',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 160),
                      child: Text(
                        'view all >>',
                        style: TextStyle(
                            fontSize: 15,
                            color: GlobalVariables.secondaryColor),
                      ),
                    ),
                    onPressed: () {

                    },
                  )
                ],
              ),
              ServicesCategories()
            ],
          ),
        )
    );
  }





  Widget fetchCategories() => ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: GlobalVariables.categoryImages.length,
      itemBuilder: (context, index){
        return Column(
          children: [
            Card(
              child: Container(
                child: Image.asset(GlobalVariables.categoryImages[index]['icon']!),
              ),
            ),
            Text(GlobalVariables.categoryImages[index]['name']!)
          ],
        );
      }
  );
}
