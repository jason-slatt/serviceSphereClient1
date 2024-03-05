import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:service_sphere/features/auth/screens/signIn_screen.dart';
import 'package:service_sphere/features/auth/screens/signUp_screen.dart';

import '../../../constant/global_variable.dart';


class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/haircutF.jpeg'), fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Stack(
                  children: [
                    const Positioned(
                      bottom: 50,
                      top: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 80, left: 0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: GlobalVariables.backgroundColor,
                                  child: Icon(
                                    Icons.house,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 15),
                                  child: Text(
                                    'ServiceSphere',
                                    style: TextStyle(
                                        color: GlobalVariables.backgroundColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12, right: 50),
                            child: Text(
                              'All Services on \nyour fingertips.',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 70),
                      child: Align(
                        heightFactor: 24,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 60, bottom: 20, left: 60),
                              height: 40,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "log in",
                                style: TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 60, bottom: 20, left: 60),
                              height: 40,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignupScreen.routeNamed);
                              },
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "sign Up",
                                style: TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
