import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/main/screens/Home/screen/categories_screen.dart';

class BeautyWidget extends StatelessWidget {

  const BeautyWidget({super.key});

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
          height: MediaQuery.of(context).size.height/3,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: GlobalVariables.beauty.length < 4? GlobalVariables.cleaning.length:4,
              itemBuilder: (context, index) {
                return  GestureDetector(
                  onTap:() => navigateToCategoryScreen(context, GlobalVariables.beauty[index]['name']!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    height: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 0,
                          child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                padding:const EdgeInsets.all(1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("assets/${GlobalVariables.beauty[index]['image']!}",  height: 130,
                                      width: 200,
                                      fit: BoxFit.cover, ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(GlobalVariables.beauty[index]['name']!),
                              Text(GlobalVariables.beauty[index]['description']!),
                              Row(children: [
                                const Text('start at '),
                                Text(GlobalVariables.beauty[index]['price']! , style: const TextStyle(color: GlobalVariables.priceColor),)
                              ],)
                            ],
                          ),
                        )

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
