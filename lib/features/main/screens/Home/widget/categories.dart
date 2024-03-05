import 'package:flutter/material.dart';
import 'package:service_sphere/features/main/screens/Home/widget/single_category.dart';
import '../../../../../constant/global_variable.dart';
import '../../../../../model/service_category.dart';

class Categories extends StatelessWidget {
   final List<Category> category;
  const Categories({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 140),
                      child: Text(
                        'view all >>',
                        style: TextStyle(
                            fontSize: 15,
                            color: GlobalVariables.secondaryColor),
                      ),
                    ),
                    onPressed: () {
                      //code here
                    },
                  )
                ],
              ),
        Container(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height/6,
          padding: const EdgeInsets.only(top:10, left: 10, bottom: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
              itemBuilder: (context, index){
                return  SingleCategory(category: category[index]);
              }
          ),
        )
      ],
    );
  }
}
