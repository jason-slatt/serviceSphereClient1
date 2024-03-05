import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product{
  late final String? id;
  late final List<String> images;
  late final String name;
  late final String description;
  late final double price;
  late final String category;
  late final String? userId;
  late final String? userName;



  Product({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.images,
    required this.price,
    this.userId,
    this.userName


  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map["_id"] ?? '' ,
    name: map["name"] ?? '',
    description: map["description"] ?? '',
    category: map["category"] ?? '',
    images: List<String>.from(map["images"]),
    userId: map["userId"] ?? '',
    userName: map["userName"] ?? '',
    price: map["price"]?.toDouble() ?? 0.0,



  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "images" : images,
    "name": name,
    "description" : description,
    "price" : price,
    "category": category,
    "userId" : userId,
    "userName" : userName,



  };
  factory Product.fromJson(Map<String,dynamic> json) {
    return Product(
      id: json['_id'] ,
     name: json['name'] ?? '',
     description: json['description'] ?? '',
      category: json["category"] ?? '',
      userId: json["userId"] ?? '',
      userName: json["userName"] ?? '',
      price: json['price']?.toDouble(), // Assuming price is a double or int in JSON
      images: List<String>.from((json['images']))
   );
  }

  String toJson() => json.encode(toMap());
 //
  factory Product.ffromJson(String str) {
    Map<String, dynamic> jsonMap = json.decode(str);
    return Product.fromMap(jsonMap);
  }}



