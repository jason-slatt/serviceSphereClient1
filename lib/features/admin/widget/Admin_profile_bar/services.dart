import 'package:flutter/material.dart';
import 'package:service_sphere/features/auth/widget/custom_button.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreen();
}

class _ServicesScreen extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ),
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(2.0),
            child:  Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset("assets/haircutF.jpeg",
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,),
                ),
                Container(
                    child: ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text("Book Now")
                    )

                )

              ],
            )
          );
        }
    );
  }
}
