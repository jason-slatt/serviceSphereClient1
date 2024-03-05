import 'package:flutter/material.dart';
class SingleProduct extends StatelessWidget {
final String image;
  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(top: 0),
        child: Image.network(image)
      ),
    );
  }
}
