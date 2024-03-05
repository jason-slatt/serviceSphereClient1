import 'package:flutter/material.dart';

import '../../../../../constant/global_variable.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 0,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      color: GlobalVariables.backgroundColor,
      margin: const EdgeInsets.only(
          top: 0, bottom: 20, left: 10, right: 10),
      child: TextField(
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 10),
            prefixIcon: Icon(Icons.search),
            hintText: 'search',
            border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
            focusedBorder: InputBorder.none),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
