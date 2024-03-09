import 'package:flutter/material.dart';
import 'package:service_sphere/model/user.dart';

 class UserProvider extends ChangeNotifier{
   late  User _user = User(
       name: '',
       email: '',
       password: '',
       token: '',
       type: ''
   );
   User get user => _user;
   void setUser(user){
     _user = User.fromJson(user);
     notifyListeners();
   }
 }