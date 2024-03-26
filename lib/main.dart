import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/admin/screens/admin_screen.dart';
import 'package:service_sphere/features/admin/screens/tools_screen.dart';
import 'package:service_sphere/features/admin/widget/admin_bottomBar.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/auth/screens/auth_screen.dart';
import 'package:service_sphere/features/auth/services/auth_servives.dart';
import 'package:service_sphere/features/main/widget/bottom_bar.dart';
import 'package:service_sphere/providers/user_provider.dart';
import 'package:service_sphere/route.dart';
import 'package:service_sphere/welcome.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create:(context) => UserProvider()
      )
    ],
      child: const MyApp()));
      configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp();
  }
  Future<void> initializeApp() async {
    await authService.getUserData(context);

    // Additional initialization logic if needed
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return MaterialApp(
      title: 'service sphere',
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the coloTrScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor, ),
        useMaterial3: true,
      ),
      onGenerateRoute: (setting) => generateRoute(setting),
      home: const AuthScreen()
    );
  }
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(100)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}


class Verification extends StatelessWidget {
  static const routeName = '/verify';
  const Verification({super.key});
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, UserProvider, child) {
          if(user.token!.isNotEmpty && user.type != 'admin'){
            return const  BottomBar();
          }
          if(user.type == 'admin'){
            return const AdminBottomBar();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}


