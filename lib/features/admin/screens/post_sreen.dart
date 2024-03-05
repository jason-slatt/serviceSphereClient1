import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/constant/product_box.dart';
import 'package:service_sphere/features/admin/screens/add_service_screen.dart';
import 'package:service_sphere/features/admin/services/admin_services.dart';
import 'package:service_sphere/features/admin/widget/progress_indicator.dart';
import 'package:service_sphere/features/admin/widget/single_product.dart';
import 'package:service_sphere/features/auth/services/auth_servives.dart';
import 'package:service_sphere/model/api_response.dart';

import '../../../model/product.dart';
class PostScreen extends StatefulWidget {
  static const String routeNamed = '/post-screen';

  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ApiResponse<List<Product>> _apiResponse;
  bool _isLoading = false;
 late   List<Product>? product = [];
  //List<Product> myProducts = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProduct();
  }

  fetchAllProduct() async {
  setState(() {
    _isLoading = true;
  });

  _apiResponse =  await adminServices.fetchProduct(context: context);

  setState(() {
     _isLoading = false;
  });

  }
  void navigateToAddService() {
    Navigator.pushNamed(context, AddServiceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Services',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
           Icon(Icons.notifications),
          ],
        ),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: Builder(
        builder: (_) {
          if(_isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(_apiResponse.error){
            return Center(child: Text(_apiResponse.errorMessage!));
          }
          return GridView.builder(
            itemCount: _apiResponse.data!.length,
            itemBuilder: (context, index) {
              final productData = _apiResponse.data![index];
              return Column(
                children: [
                  SizedBox(
                    height: 130,
                    child: SingleProduct(
                        image: productData.images[0]
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(productData.name)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                    ],
                  )
                ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddService,
        tooltip: 'Upload a service',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}




