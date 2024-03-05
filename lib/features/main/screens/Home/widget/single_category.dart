import 'package:flutter/material.dart';
import 'package:service_sphere/model/service_category.dart';

class SingleCategory extends StatelessWidget {
  final Category category;
  const SingleCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 140,
      child: Column(
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
                      Image.asset("assets/icons/${category.icon}", height: 50, width: 80, ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(category.name)
        ],
      ),
    );
  }
}
