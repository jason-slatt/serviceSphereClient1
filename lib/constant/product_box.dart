import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/widget/product_list.dart';
import 'package:service_sphere/model/product.dart';


class ProductBox extends StatelessWidget {
  final List<Product>? productList;
  const ProductBox({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(left: 5, right: 5, ),
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: productList!.length,
          itemBuilder: (context, index) {
            return ProductList(product: productList![index],);
          }, gridDelegate: const  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 110,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 4,
        ),),
      ),
    );
  }
}
