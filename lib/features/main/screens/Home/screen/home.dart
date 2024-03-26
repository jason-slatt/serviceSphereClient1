import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/category_list.dart';
import 'package:service_sphere/features/main/screens/Home/services/home_services.dart';
import 'package:service_sphere/features/main/screens/Home/widget/UI_widget/beauty.dart';
import 'package:service_sphere/features/main/screens/Home/widget/UI_widget/cleaning_widget.dart';
import 'package:service_sphere/features/main/screens/Home/widget/categories.dart';
import 'package:service_sphere/features/main/screens/Home/widget/home_topBar.dart';
import 'package:service_sphere/features/main/screens/Home/widget/list_of_categories.dart';
import 'package:service_sphere/features/main/services/product.dart';
import 'package:service_sphere/model/api_response.dart';
import 'package:service_sphere/providers/user_provider.dart';

import '../../../../../constant/global_variable.dart';
import '../../../../../model/product.dart';
import '../../../../../model/service_category.dart';
import '../widget/category_widget.dart';
import '../widget/topBar_search.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isLoading = true;
  late List<ServiceCategory> _categories = [];
  final HomeServices _homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<ServiceCategory> categories = [];
      for (String category in allCategories) {
        final ApiResponse<List<Product>> apiResponse = await _homeServices
            .fetchCategory(context: context, category: category);
        categories.add(
            ServiceCategory(name: category, products: apiResponse.data!));
      }
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<String> allCategories = [
    'Beauty',
    'Cleaning',
    'Coaching Classes',
    'Repair and Maintenance',
    'Teaching',
    'transportation',
  ];

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 40,
        toolbarHeight: 120,
        backgroundColor: Colors.black,
        title: Column(
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
                          child: Icon(
                            Icons.location_pin,
                            size: 16,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Services',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 180),
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
              const ServicesCategories(),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Cleaning',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 180),
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
              const CleaningWidgte(),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Beauty',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 180),
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
              const BeautyWidget()
            ],
          ),
        ),
      ),
    );
  }
}



