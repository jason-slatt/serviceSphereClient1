import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/main/screens/Home/screen/categories_screen.dart';

class ServicesCategories extends StatelessWidget {

  const ServicesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToCategoryScreen(BuildContext context, String category){
      Navigator.pushNamed(context, CategoriesDealsScreen.routeName, arguments: category);
    }
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18),
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height/6,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: GlobalVariables.categoryImages.length,
              itemBuilder: (context, index) {
                return  GestureDetector(
                  onTap:() => navigateToCategoryScreen(context, GlobalVariables.categoryImages[index]['name']!),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    height: 140,
                    child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                padding:const EdgeInsets.all(1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("assets/${GlobalVariables.categoryImages[index]['icon']!}", height: 50, width: 80, ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(GlobalVariables.categoryImages[index]['name']!)
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
