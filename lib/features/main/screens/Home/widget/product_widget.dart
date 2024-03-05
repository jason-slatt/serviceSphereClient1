import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/widget/single_product.dart';

import '../../../../../constant/global_variable.dart';
import '../../../../../model/product.dart';
class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Image.network(product.images[0],
                height: 130,
                width: 200,
                fit: BoxFit.cover
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3 , right: 50),
          child: ClipRRect(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  Text(product.name , style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text(product.description),
                  Row(children: [
                    const Text('start at '),
                    Text(product.price.toString() , style: const TextStyle(color: GlobalVariables.priceColor),)
                  ],)
                ]
            ),
          ),
        )
      ],
    );
  }
}
