
import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/screens/add_service_screen.dart';
import 'package:service_sphere/features/admin/screens/post_sreen.dart';
import 'package:service_sphere/features/admin/screens/profile.dart';
import 'package:service_sphere/features/main/screens/Home/screen/categories_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/auth/screens/auth_screen.dart';
import 'package:service_sphere/features/main/widget/bottom_bar.dart';
import 'package:service_sphere/main.dart';
import 'features/auth/screens/forgetPassword_screen.dart';
import 'features/auth/screens/signIn_screen.dart';
import 'features/auth/screens/signUp_screen.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SignupScreen.routeNamed:
      return MaterialPageRoute(builder: (_) => const SignupScreen());
    case ForgetPasswordScreen.routeNamed:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddServiceScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddServiceScreen());
    case PostScreen.routeNamed:
      return MaterialPageRoute(builder: (_) => const PostScreen());
    case Verification.routeName:
      return MaterialPageRoute(builder: (_) => const Verification());
    case CategoriesDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>CategoriesDealsScreen(category: category,));
    case AdminProfile.routeName:
      var provider = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>AdminProfile(userId: provider,));
    default:
  return MaterialPageRoute(
  builder: (_) => const Scaffold(
  body: Center(
  child: Text("THIS PAGE DOES NOT EXIST"),
  )));
  }
}