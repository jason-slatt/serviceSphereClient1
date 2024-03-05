import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/error_handling.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/constant/utils.dart';
import 'package:service_sphere/features/auth/screens/auth_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/auth/screens/signIn_screen.dart';
import 'package:service_sphere/features/main/widget/bottom_bar.dart';
import 'package:service_sphere/main.dart';
import 'package:service_sphere/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_sphere/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //SIGN UP USER
  void signUpUser({required BuildContext context,
    required String name,
    required String email,
    required String password}) async {
    try {
      User user = User(
        name: name,
        email: email,
        password: password,
      );
      var url = Uri.parse('$uri/api/signup');
      http.Response res = await http.post(url,
          body: user.toJson(),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8'
          });
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onsave: () {
            showSnackBar(
                context, 'Account created , logIn with the same credentials');
            Navigator.pushNamed(context, LoginScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password
})async{
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      var url = Uri.parse('$uri/api/signin');
      http.Response res = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password
        }),
        headers: <String, String> {
          'content-type' : 'application/json; charset=UTF-8',
        }
      );
      print(email);
      print(password);
      print(res.body);
      httpErrorHandler(
          response: res,
          context: context,
          onsave: () async {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            var userToken = jsonDecode(res.body)['token'];
            if(userToken != null){
              sharedPreferences.setString('X-AUTH-TOKEN', userToken);
            } else {
              print('no token found');
            }
            Navigator.pushNamedAndRemoveUntil(context, Verification.routeName, (route) => false);
            EasyLoading.showProgress(0.3, status: '',);
            EasyLoading.dismiss();
          }
      );
      print(res.body);
    }catch(e){
            showSnackBar(context,e.toString());
            print(e);
    }

}
//get user data
   getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('X-AUTH-TOKEN');

      if (token == null) {
        prefs.setString('X-AUTH-TOKEN', '');
      }

      if (await verifyToken(token)) {
        // If token verification is successful, fetch user data
        var userData = await fetchUserData(token);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userData);
        print(userData);
      }
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }

  Future<bool> verifyToken(String? token) async {
    if (token == null) {
      // Handle the case where the token is null
      return false;
    }

    try {
      var url = Uri.parse('$uri/verifyToken');
      var tokenRes = await http.post(
        url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          'X-AUTH-TOKEN': token,
        },
      );

      return jsonDecode(tokenRes.body) == true;
    } catch (e) {
      // Handle token verification failure
      return false;
    }
  }

  Future<String> fetchUserData(String? token) async {
    if (token == null) {
      // Handle the case where the token is null
      return '';
    }

    try {
      var url = Uri.parse('$uri/');
      var userRes = await http.get(
        url,
        headers: {
          'content-type': 'application/json; charset=UTF-8',
          'X-AUTH-TOKEN': token,
        },
      );

      return userRes.body;
    } catch (e) {
      // Handle user data fetching failure
      return '';
    }
  }
}



// void emailVerification(
//     {required BuildContext context,
//       required String otp,
//     }) async {
//   try {
//     var url = Uri.parse('$uri/api/auth/email-verification');
//     http.Response res = await http.post(url,
//         body: jsonEncode({
//           'otp': otp,
//         }),
//         headers: <String, String>{
//           'content-type': 'application/json; charset=UTF-8'
//         });
//     // ignore: use_build_context_synchronously
//     httpErrorHandler(
//         response: res,
//         context: context,
//         onsave: () {
//           showSnackBar(context, 'success');
//           Navigator.pushNamed(context, LoginScreen.routeName);
//         });
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
// }
