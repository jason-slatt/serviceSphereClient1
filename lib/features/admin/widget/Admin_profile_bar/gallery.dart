import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
   final List<String> userPost = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
       shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3
        ),
        itemBuilder: (context, index){
          return Padding(
              padding: const EdgeInsets.all(2.0),
            child: Container(
              color: Colors.grey[500],
              child: Image.asset("assets/haircutF.jpeg",
              fit: BoxFit.cover,),
          ),
          );
        }
    );
  }
}
