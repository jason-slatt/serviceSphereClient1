import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

String uri = 'http://172.20.10.5:8080';

class GlobalVariables {
static const secondaryColor = Color.fromRGBO(0, 112, 255, 10);
static const backgroundColor = Color.fromRGBO(255, 255, 255, 1);
static const priceColor = Color.fromARGB(255, 0, 255, 21);
static const selectedNavBarColor = Colors.black;
static const unSelectedNavBarColor = Colors.grey;




static const List<Map<String, String>> categoryImages = [
  {
    "icon" : "cleaning.png" ,
    "name" : "Cleaning "
  },
  {
    "icon" : "beauty.png",
    "name" : "Beauty"
  },
  {
    "icon" : "electrician.png",
    "name" : "Electrician"
  },
  {
    "icon" : "ac.png",
    "name" : "Ac"
  }
];


static const List<Map<String, String>> cleaning = [
    {
      "image": "home_cleaning.jpeg",
      "name": "Bathroom cleaning",
      "description": "services at home",
      "category": "cleaning",
      "price":"4900 XAF"
    },
    {
      "image": "car_cleaning.jpeg",
      "name": "car cleaning",
      "description": "services at home",
      "category": "cleaning",
      "price":"4900 XAF"
    },
    {
      "image": "home_cleaning.jpeg",
      "name": "house cleaning",
      "description": "services at home",
      "category": "cleaning",
      "price":"4900 XAF"
    },
    {
      "image": "pest_control.jpeg",
      "name": "pest",
      "description": "services at home",
      "category": "cleaning",
      "price":" 4900 XAF"
    },

];

static const List<Map<String,String>> beauty = [
  {
    "image": "massageTherapy.jpg",
    "name": "Massage ",
    "description": "free body masssage",
    "category": "beauty",
    "price":" 4900 XAF"
  },

  {
    "image": "haircutF.jpeg",
    "name": "Salon",
    "description": "free waxing",
    "category": "beauty",
    "price":"4900 XAF"
  },
  {
    "image": "nailsMake.jpeg",
    "name": "Nails maker",
    "description": "get pretty nails",
    "category": "beauty",
    "price":" 4900 XAF"
  },
  {
    "image": "haircutM.jpeg",
    "name": "swag boy salon",
    "description": "get pretty in a shave",
    "category": "beauty",
    "price":" 4900 XAF"
  },
  {
    "image": "hairsTreat.jpeg",
    "name": "hairs treat",
    "category": "beauty",
    "description": "get smooth hairs",
    "price":" 4900 XAF"
  },
  {
    "image": "bodyMassage.jpeg",
    "name": "Body massage",
    "category": "beauty",
    "description": "free body massage",
    "price":" 4900 XAF"
  },
  {
    "image": "skinCare.jpeg",
    "name": "Skin care",
    "description": "get skin smooth",
    "category": "beauty",
    "price":"4900 XAF"
  },
  {
    "image": "chineeseMassage.jpeg",
    "name": "chineese",
    "description": "free of best Masssage",
    "category": "beauty",
    "price":" 4900 XAF"
  }
];

}


//
// class Cloudinary{
//   Future<String?> uploadImageToCloudinary(File image) async {
//     try {
//       final cloudinary = CloudinaryPublic('dwhcxxkki','bzcsydrb', );
//       final response = await cloudinary.uploadFile(
//         CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
//       );
//
//       // Extract the public URL of the uploaded file from the response
//       final imageUrl = response.secureUrl;
//
//       return imageUrl;
//     } catch (error) {
//       print('Error uploading to Cloudinary: $error');
//       return null;
//     }
//   }
//
//   Future<List<String>> uploadImagesToCloudinary(List<File>images) async {
//     List<String> imageUrls = [];
//
//     for (File image in images) {
//       String? imageUrl = await uploadImageToCloudinary(image);
//
//       if (imageUrl != null) {
//         imageUrls.add(imageUrl);
//       } else {
//         // Handle the case where image upload fails for a file
//         // You might want to retry, show an error message, or take other actions
//       }
//     }
//
//     return imageUrls;
//   }
// }
//
// Cloudinary cloudinary = Cloudinary();

