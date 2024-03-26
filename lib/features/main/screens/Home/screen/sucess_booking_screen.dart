import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:service_sphere/features/auth/widget/custom_button.dart';
import 'package:service_sphere/features/main/screens/Home/screen/home.dart';
import 'package:service_sphere/features/main/screens/Home/screen/serrvice_description_screen.dart';

class SuccessBooking extends StatefulWidget {
  static const String routeName = '/success_Booked';
  const SuccessBooking({super.key});

  @override
  State<SuccessBooking> createState() => _SuccessBookingState();
}

class _SuccessBookingState extends State<SuccessBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              totalRepeatCount: 20,
                animatedTexts: [ ScaleAnimatedText(
              'Appointment  Booked',
              duration: const Duration(milliseconds: 4000),
              textStyle:
              const TextStyle(color: Colors.indigo, fontSize: 30.0),
            ), ]),
            CustomButton(
                text: 'Go back to home',
                onTap: () => Navigator.pushNamed(context, ServiceDescriptionScreen.routeName)
            )
          ],
        ),
      ),
    );
  }
}
