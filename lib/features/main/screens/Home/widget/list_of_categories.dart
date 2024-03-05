import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/main/screens/Home/services/home_services.dart';
import 'package:service_sphere/model/api_response.dart';

import '../../../../../model/product.dart';
import '../../../../admin/widget/single_product.dart';

class CategoriesList extends StatefulWidget {
  static const String routeName = '/category-deals';
  var category;
   CategoriesList({super.key,required this.category});

  @override
  State<CategoriesList> createState() => _CategoriesList();
}

class _CategoriesList extends State<CategoriesList> {
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
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await homeServices.fetchCategory(context: context, category: widget.category);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return ListView.builder(
            itemCount: _apiResponse.data!.length,
            itemBuilder: (context, index) {
              final productData = _apiResponse.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.category),
                       const Text('View all')
                      ],
                    ),
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
                    )
                  ],
                ),
              );
            },
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            );
        },
      ),
    );
  }
}
