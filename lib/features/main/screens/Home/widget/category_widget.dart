import 'package:flutter/material.dart';
import 'package:service_sphere/features/main/screens/Home/widget/product_widget.dart';

import '../../../../../model/product.dart';

class CategoryListWidget extends StatelessWidget {
  final ServiceCategory category;

  const CategoryListWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category.name),
        Container(
          padding: const EdgeInsets.only(left: 18),
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height/3.6,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: category.products.length < 4? category.products.length : 4,
            itemBuilder: (context, index) {
              final product = category.products.isEmpty?  null : category.products[index];
              return ProductWidget(product: product!);
            },
          ),
        ),
      ],
    );
  }
}

class ServiceCategory {
  final String name;
  final List<Product> products;

  ServiceCategory({required this.name, required this.products});
}