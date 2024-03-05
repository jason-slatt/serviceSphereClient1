import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/widget/single_product.dart';
import 'package:service_sphere/model/product.dart';

class ProductList extends StatelessWidget {
  final Product product;
  const ProductList ({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.only(top: 0),
            child: SingleProduct(
              image: product.images[0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3 , right: 50),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text(product.name , style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                //Text(item.description),
                Row(children: [
                  const Text('start at '),
                  //Text(product.price , style: const TextStyle(color: GlobalVariables.priceColor),)
                ],)
              ]
          ),
        )
      ],
    );
  }
}
