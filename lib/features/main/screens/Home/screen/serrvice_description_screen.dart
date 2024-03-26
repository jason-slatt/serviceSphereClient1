import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:service_sphere/constant/lorems.dart';
import 'package:service_sphere/features/auth/widget/custom_button.dart';
import 'package:service_sphere/features/main/screens/Home/screen/booking_screen.dart';
import 'package:service_sphere/features/main/screens/Home/services/home_services.dart';
import 'package:service_sphere/model/api_response.dart';

import '../../../../../components/gf_rating.dart';
import '../../../../../constant/global_variable.dart';
import '../../../../../model/product.dart';
import '../../../../admin/screens/profile.dart';


class ServiceDescriptionScreen extends StatefulWidget {
  static const routeName = '/service-description';
  final String serviceId;
  const ServiceDescriptionScreen({super.key, required this.serviceId});

  @override
  State<ServiceDescriptionScreen> createState() => _ServiceDescriptionScreenState();
}

class _ServiceDescriptionScreenState extends State<ServiceDescriptionScreen> {
   ApiResponse<Product> _apiResponse = ApiResponse();
  HomeServices homeServices =HomeServices();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchServiceId();
  }

  fetchServiceId() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await homeServices.fetchServiceId(context: context, serviceId: widget.serviceId);

    setState(() {
      _isLoading = false;
    });
  }
   void navigateToProviderProfile(BuildContext context, String? userId){
     if (userId != null) {
       Navigator.pushNamed(context, AdminProfile.routeName, arguments: userId);
     } else {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('User ID is null or invalid')),
       );
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  BottomAppBar(
        height: MediaQuery.of(context).size.height/8,
        child: CustomButton(
          onTap: () {
            Navigator.pushNamed(context, BookingScreen.routeName, arguments: _apiResponse.data?.id ?? '');
          },
          text: 'Book now',
        ),
      ),
      appBar: AppBar(
        title: Text(_apiResponse.data?.name  ?? '', style: const TextStyle(color: GlobalVariables.backgroundColor),),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Builder(
          builder: (_) {
            if(_isLoading){
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                children: [
                  LayoutBuilder(
                    builder:  (BuildContext context, BoxConstraints constraints) {
                      return  Container(
                        width: double.infinity  ,
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CarouselSlider(
                                  items: _apiResponse.data?.images.map(
                                          (i) {
                                        return Builder(
                                            builder:(BuildContext context) => Image.network(
                                              i,
                                              fit : BoxFit.cover,
                                              height : 200,
                                              width: constraints.maxWidth,
                                            )
                                        );
                                      }
                                  ).toList() ?? [],
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      height: 200,
                                      enlargeCenterPage: false,
                                      autoPlay: true,
                                      aspectRatio: 16 / 9
                                  )
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_apiResponse.data?.name ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Row(
                            children: [
                              const Text('Start at '),
                              Text(_apiResponse.data?.price.toString()?? '',style: const TextStyle(color: GlobalVariables.priceColor)),
                              const Text(' XAF')
                            ],
                          ),
                          Row(
                            children: [
                              GFRating(
                                onChanged: (double rating) {  },
                                value: 5,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              const Text('(7K)')
                            ],
                          ),
                          TextButton(
                              onPressed: () =>  navigateToProviderProfile(context,_apiResponse.data!.userId),
                              child: const Text('view profile')
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 130),
                        child:  Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.call),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                child: Icon(Icons.message),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16),),
                      LoremIpsumWidget()
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
