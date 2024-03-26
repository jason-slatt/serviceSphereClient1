import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/admin/screens/profile.dart';
import 'package:service_sphere/features/main/screens/Home/screen/serrvice_description_screen.dart';
import 'package:service_sphere/features/main/screens/Home/services/home_services.dart';
import 'package:service_sphere/model/api_response.dart';

import '../../../../../model/product.dart';
import '../../../../admin/widget/single_product.dart';

class CategoriesDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoriesDealsScreen({super.key, required this.category});

  @override
  State<CategoriesDealsScreen> createState() => _CategoriesDealsScreenState();
}

class _CategoriesDealsScreenState extends State<CategoriesDealsScreen> {
  HomeServices homeServices = HomeServices();
  late ApiResponse<List<Product>> _apiResponse;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategory();

  }
  void fetchCategory() async {


    _apiResponse = await homeServices.fetchCategory(context: context, category: widget.category);

    setState(() {
      _isLoading = false;
    });
  }
  void navigateToProviderProfile(BuildContext context, String? userId){
    if (userId != null) {
      Navigator.pushNamed(context, AdminProfile.routeName, arguments: userId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID is null or invalid')),
      );
    }
  }

  void navigateToServiceDescription(BuildContext context, String? serviceId){
    if (serviceId != null) {
      Navigator.pushNamed(context, ServiceDescriptionScreen.routeName, arguments: serviceId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' ID is null or invalid')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 40,
        backgroundColor:GlobalVariables.secondaryColor,
        title: Text(widget.category)
      ),
      body: Builder(
        builder: (_) {
          if(_isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(_apiResponse.error){
            return Center(child: Text(_apiResponse.errorMessage!));
          }
          if(_apiResponse.data!.isEmpty){
            return const Center(child: Text('OOPs! this category is not yet available '),);
          }
          return GridView.builder(
            itemCount: _apiResponse.data!.length,
            itemBuilder: (context, index) {
              final productData = _apiResponse.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GestureDetector(
                  onTap: () => navigateToServiceDescription(context, productData.id),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.lightBlueAccent,
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: const EdgeInsets.only(top: 0),
                          child: Image.network(productData.images[0],height: 130, width: 200, fit: BoxFit.cover,),
                        ),
                      ),
                      Text(productData.name),
                      Text(productData.description, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      Row(
                        children: [
                          const Text('Start at '),
                          Text(productData.price.toString(),style: const TextStyle(color: GlobalVariables.priceColor)),
                          const Text(' XAF')
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
          );
        },
      ),
    );
  }
}
