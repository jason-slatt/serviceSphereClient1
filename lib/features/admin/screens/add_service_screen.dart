

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/constant/utils.dart';
import 'package:service_sphere/features/admin/services/admin_services.dart';
import 'package:service_sphere/features/auth/widget/custom_button.dart';
import 'package:service_sphere/features/auth/widget/custom_textfield.dart';
import 'package:service_sphere/providers/user_provider.dart';

class AddServiceScreen extends StatefulWidget {
  static const String routeName = '/add-service';
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  AdminServices adminServices = AdminServices();
  final _postServiceKey = GlobalKey<FormState>();

  String category = 'Cleaning';
  List<File> images = [];

  @override
  void dispose() {
    serviceNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  void provideService(){
    if(_postServiceKey.currentState!.validate() && images.isNotEmpty){
      adminServices.sellServices(
          context: context,
          name: serviceNameController.text,
          description: descriptionController.text,
          category: category,
          price: double.parse(priceController.text),
          images: images,
      );
    }
  }
  List<String> serviceCategories = [
    'Beauty',
    'Coaching Classes',
    'Repair and Maintenance',
    'Cleaning',
    'Teaching',
    'transportation',
  ];
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add service'),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _postServiceKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 25,),
                images.isNotEmpty? CarouselSlider(
                    items: images.map(
                        (i) {
                          return Builder(
                              builder:(BuildContext context) => Image.file(
                                i,
                                fit : BoxFit.cover,
                                height : 200
                              )
                          );
                        }
                    ).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200
                    )
                ):GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.folder_open , size : 40),
                            const SizedBox(height: 15, ),
                            Text('select your service Image', style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),)
                          ],
                        ),
                      )
                  ),
                ),
               const SizedBox(height: 30,),
                CustomTextField(controller: serviceNameController, hintext: 'service name'),
                const SizedBox(height: 10,),
                CustomTextField(controller: descriptionController, hintext: 'Description', maxline: 2,),
                const SizedBox(height: 10,),
                CustomTextField(controller: priceController, hintext: 'price',),
                const SizedBox(height: 10,),
                 SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Padding(
                      padding:  EdgeInsets.only(left: 130),
                      child:  Icon(Icons.keyboard_arrow_down),
                    ),
                    items: serviceCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                          child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal){
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 50,),
                CustomButton(text: 'Provide',
                    onTap: provideService
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
