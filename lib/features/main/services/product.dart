

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import '../../../model/api_response.dart';
import '../../../model/product.dart';
import '../../../model/service_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/user.dart';
import '../../../providers/user_provider.dart';


class ProductServices {
  List<Category> parseService(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Category>((json) => Category.fromjson(json))
        .toList();
  }

  Future<List<Category>> fetchServices() async {
    var url = Uri.parse("$uri/fetchProduct");

    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return parseService(response.body);
      } else {
        throw Exception('Unable to fetch products from the REST API');
      }
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ApiResponse<List<User>>> fetchUserId({required BuildContext context,required userId}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    var url = Uri.parse('$uri/fetchUserId?_id=$userId');
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
        final List<User> providers = [];

        for (var json in jsonData) {
          providers.add(User.fromJson(json));
        }
        print('Parsed productList: $providers');
        return ApiResponse<List<User>>(data: providers);
      }
      return ApiResponse<List<User>>(error: true, errorMessage: 'An error happen');
    } catch(e){
      print(e);
      return ApiResponse<List<User>>(error: true, errorMessage: e.toString());
    }
  }
}

ProductServices productServices = ProductServices();