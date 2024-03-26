
import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/screens/add_service_screen.dart';
import 'package:service_sphere/features/admin/screens/appointment_screen.dart';
import 'package:service_sphere/features/admin/screens/post_sreen.dart';
import 'package:service_sphere/features/admin/screens/profile.dart';
import 'package:service_sphere/features/main/screens/Home/screen/categories_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/auth/screens/auth_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/serrvice_description_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/sucess_booking_screen.dart';
import 'package:service_sphere/features/main/screens/appointment_screen.dart';
import 'package:service_sphere/features/main/widget/bottom_bar.dart';
import 'package:service_sphere/main.dart';
import 'features/auth/screens/forgetPassword_screen.dart';
import 'features/auth/screens/signIn_screen.dart';
import 'features/auth/screens/signUp_screen.dart';
import 'features/main/screens/Home/screen/booking_screen.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case AdminAppointment.routeName:
      return MaterialPageRoute(builder: (_) => const AdminAppointment());
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
    case AppointmentScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AppointmentScreen());
    case BookingScreen.routeName:
      var serviceId = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>  BookingScreen(serviceId: serviceId,));
    case CategoriesDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>CategoriesDealsScreen(category: category,));
    case AdminProfile.routeName:
      var provider = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>AdminProfile(userId: provider,));
    case ServiceDescriptionScreen.routeName:
      var serviceId = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) => ServiceDescriptionScreen(serviceId: serviceId,));
    default:
  return MaterialPageRoute(
  builder: (_) => const Scaffold(
  body: Center(
  child: Text("THIS PAGE DOES NOT EXIST"),
  )));
  }
}