
import 'package:flutter/material.dart';
import '../../../constant/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      onPressed: onTap,
      color: GlobalVariables.secondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child:  Text(
        text,
        style: const TextStyle(
            color: GlobalVariables.backgroundColor,
            fontSize: 17
        ),
      ),
    );
  }
}
