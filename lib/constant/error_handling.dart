import 'dart:convert';

import 'package:service_sphere/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler(
    {required http.Response response,
      required BuildContext context,
      required VoidCallback onsave}) {
  switch (response.statusCode) {
    case 200:
      onsave();
      break;
    case 201:
      showSnackBar(context, jsonDecode(response.body)['message']);
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
