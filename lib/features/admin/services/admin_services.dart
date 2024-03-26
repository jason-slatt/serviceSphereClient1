import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/error_handling.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/constant/utils.dart';
import 'package:service_sphere/features/admin/screens/post_sreen.dart';
import 'package:service_sphere/model/api_response.dart';
import 'package:service_sphere/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:service_sphere/model/user.dart';
import 'package:service_sphere/providers/user_provider.dart';

class AdminServices {
  void sellServices({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double price,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    EasyLoading.show(status: 'creating your post....',);
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dwhcxxkki/upload');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        final request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'dmrwvkud'
          ..files
              .add(await http.MultipartFile.fromPath('file', images[i].path));
        final response = await request.send();
          if (response.statusCode == 200) {
            try {
              final responseData = await response.stream.toBytes();
              final  responseString = (String.fromCharCodes(responseData));
              final jsonResponse = jsonDecode(responseString);
              imageUrls.add(jsonResponse['url']);
              print(imageUrls);
            } catch(e){
              print('Error making request: $e');
            }
        }
      }
      print('first');
      Product product = Product(
        images: imageUrls,
        name: name,
        description: description,
        price: price,
        category: category,
      );
      print('first2');
      var ur = Uri.parse('$uri/admin');
      print('first3');
      http.Response res = await http.post(
        ur,
        body: product.toJson(),
        headers: {
          'content-type': 'application/json; charset=UTF-8',
          'X-AUTH-TOKEN': userProvider.user.token!
        },
      );
      print(res.body);
      print('Token: ${userProvider.user.token}');

      httpErrorHandler(
          response: res,
          context: context,
          onsave: () {
            EasyLoading.show(status: 'service published');
            Navigator.pop(context);
            EasyLoading.dismiss();
          });
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse<List<Product>>> fetchProduct({required BuildContext context}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      var url = Uri.parse('$uri/fetchProduct');
      try{
           http.Response productRes = await http.get(
             url,
             headers: {
               'content-type': 'application/json; charset=UTF-8',
               'X-AUTH-TOKEN': userProvider.token!
             },
           );
           print('Response status code: ${productRes.statusCode}');
           print('Response body: ${productRes.body}');
           if(productRes.statusCode == 200 ) {
             final List<dynamic> jsonData = jsonDecode(productRes.body);
             final List<Product> productList = [];

             for (var json in jsonData) {
               productList.add(Product.fromJson(json));
             }


             print('Parsed productList: $productList');
             return ApiResponse<List<Product>>(data: productList);

           }
           return ApiResponse<List<Product>>(error: true, errorMessage: 'please check your network connection');
      } catch(e){
        print(e);
        return ApiResponse<List<Product>>(error: true, errorMessage: e.toString());
      }
      return http.get(
        url,
        headers: {
          'content-type': 'application/json; charset=UTF-8',
          'X-AUTH-TOKEN': userProvider.token!
        },
      ).then((productRes){


  if(productRes.statusCode == 200){
          final jsonData = jsonDecode(productRes.body);
          final productList = <Product>[];
          final jsonList = (jsonData as List).map((json) => Product.fromJson(json)).toList();

          for(var json in jsonData){
            productList.add(Product.fromJson(json));
          }
          return ApiResponse<List<Product>>(data: productList);
        }
        return ApiResponse<List<Product>>(error: true, errorMessage: 'An error happen');
      }
      ).catchError((_) => ApiResponse<List<Product>>(error: true, errorMessage: 'An error STILL'));

  }

}

AdminServices adminServices = AdminServices();
