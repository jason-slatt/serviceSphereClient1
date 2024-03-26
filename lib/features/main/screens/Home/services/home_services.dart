import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_sphere/model/product.dart';

import '../../../../../constant/global_variable.dart';
import '../../../../../model/api_response.dart';
import '../../../../../model/user.dart';
import '../../../../../providers/user_provider.dart';

class HomeServices{
  Future<ApiResponse<List<Product>>> fetchCategory({required BuildContext context,required category}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.parse('$uri/fetchCategory?category=$category');
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
        return ApiResponse<List<Product>>(data: productList);
      }
      return ApiResponse<List<Product>>(error: true, errorMessage: 'An error happen');
    } catch(e){
      print(e);
      return ApiResponse<List<Product>>(error: true, errorMessage: e.toString());
    }
  }
  Future<ApiResponse<List<String>>> fetchUserIds({required BuildContext context, required userId}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      var url = Uri.parse('$uri/fetchCategory');

      final response = await http.get(
        url,
        headers: {
          'content-type': 'application/json; charset=UTF-8',
          'X-AUTH-TOKEN': userProvider.token!,
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<String> userIds = jsonData.map((item) => item['userId'] as String).toList();

        print('Parsed userIds: $userIds');

        return ApiResponse<List<String>>(data: userIds);
      }

      return ApiResponse<List<String>>(error: true, errorMessage: 'An error occurred while fetching user IDs');
    } catch (e) {
      print('An error occurred: $e');
      return ApiResponse<List<String>>(error: true, errorMessage: e.toString());
    }
  }



  Future<ApiResponse<User>> fetchUserId({required BuildContext context,required userId}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.parse('$uri/fetchUserId/$userId');
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
        Map<String, dynamic> jsonData = jsonDecode(productRes.body);
        final user = User.fromJson(jsonData);
        print('Parsed user: $user');
        return ApiResponse<User>(data: user);
      }
      return ApiResponse<User>(error: true, errorMessage: 'An error happen');
    } catch(e){
      print(e);
      return ApiResponse<User>(error: true, errorMessage: e.toString());
    }
  }

  Future<ApiResponse<Product>> fetchServiceId({required BuildContext context,required serviceId}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.parse('$uri/fetchServiceId/$serviceId');
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
        Map<String, dynamic> jsonData = jsonDecode(productRes.body);
        final user = Product.fromJson(jsonData);
        print('Parsed user: $user');
        return ApiResponse<Product>(data: user);
      }
      return ApiResponse<Product>(error: true, errorMessage: 'An error happen');
    } catch(e){
      print(e);
      return ApiResponse<Product>(error: true, errorMessage: e.toString());
    }
  }
}