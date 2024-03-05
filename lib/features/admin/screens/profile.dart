import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/features/admin/widget/Admin_profile_bar/About.dart';
import 'package:service_sphere/features/admin/widget/Admin_profile_bar/gallery.dart';
import 'package:service_sphere/features/admin/widget/Admin_profile_bar/review.dart';
import 'package:service_sphere/features/admin/widget/Admin_profile_bar/services.dart';
import 'package:service_sphere/features/main/screens/Home/services/home_services.dart';
import 'package:service_sphere/model/api_response.dart';
import 'package:service_sphere/providers/user_provider.dart';

import '../../../components/gf_rating.dart';
import '../../../model/user.dart';

class AdminProfile extends StatefulWidget {
  static const String routeName = '/-user_profile';
  final  userId;

  const AdminProfile({super.key, this.userId});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  HomeServices homeServices = HomeServices();
   ApiResponse<User> _provider = ApiResponse<User>();
  bool _isLoading = false;
  bool _isDisposed = false;
  late User _user = User(name: '', email: '', password: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserById();

  }
  @override
  void dispose() {
    _isDisposed = true; // Set a flag indicating that the widget has been disposed
    // Cancel any ongoing operations here, if any
    super.dispose();
  }
  fetchUserById() async {
    setState(() {
      _isLoading = true;
    });


    if (!_isDisposed) {
      // Fetch user information using the userId
      homeServices.fetchUserId(context: context, userId: widget.userId).then((provider) {
        if (!provider.error) {
          final userData = provider.data as Map<String, dynamic>; // Cast to Map<String, dynamic> or null
          if (userData != null) {
            // User data available, parse and assign to _user
            setState(() {
              _provider = provider;
              _user = User(
                name: userData['name'] ?? '',
                email: userData['email'] ?? '',
                password: userData['password']
                // Add more fields as needed
              );
              _isLoading = false;
            });
          } else {
            // Handle case where user data is null
            setState(() {
              _isLoading = false;
            });
            print('Error: User data is null');
            // Optionally, display an error message to the user
          }
        } else {
          // Handle error case
          setState(() {
            _isLoading = false;
          });
          print('Error fetching user: ${provider.errorMessage}');
          // Optionally, display an error message to the user
        }
      });

    }
  }




  Color? adminActivitiesColors = Colors.grey[300];
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        body: _isLoading? const Center(child: CircularProgressIndicator(),)
            : _user != null && _user.id != user.id ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // business description
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          _user.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          _user.email,
                          style:  const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        GFRating(
                          onChanged: (double rating) {  },
                          value: 5,
                          color: Colors.yellowAccent,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  //profile picture
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            // Admin activities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(child: Text('Edit profile', style: TextStyle(fontWeight: FontWeight.w400),)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: Center(child: Text('upload Gallery',style: TextStyle(fontWeight: FontWeight.w400))),
                        ),

                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(child: Text('Upload Plan',style: TextStyle(fontWeight: FontWeight.w400))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),

            // available option
            AdminProfileSocials(),

            const SizedBox(height: 20,),
            //tab Bar
            const TabBar(
              labelColor: Colors.black ,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide.none
              ),
              tabs: [
                Text('About'),
                Text('Services'),
                Text('Gallery'),
                Text('Review'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AboutScreen(),
                  ServicesScreen(),
                  Gallery(),
                  Review()
                ],
              ),
            )
          ],
        ) : Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // business description
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          user.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          user.email,
                          style:  const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        GFRating(
                          onChanged: (double rating) {  },
                          value: 5,
                          color: Colors.yellowAccent,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  //profile picture
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            // Admin activities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(child: Text('Edit profile', style: TextStyle(fontWeight: FontWeight.w400),)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: Center(child: Text('upload Gallery',style: TextStyle(fontWeight: FontWeight.w400))),
                        ),

                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: adminActivitiesColors,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(child: Text('Upload Plan',style: TextStyle(fontWeight: FontWeight.w400))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),

            // available option
            AdminProfileSocials(),

            const SizedBox(height: 20,),
            //tab Bar
            const TabBar(
              labelColor: Colors.black ,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide.none
              ),
              tabs: [
                Text('About'),
                Text('Services'),
                Text('Gallery'),
                Text('Review'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AboutScreen(),
                  ServicesScreen(),
                  Gallery(),
                  Review()
                ],
              ),
            )
          ],

        )

      ),
    );
  }
}

Widget AdminProfileSocials() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          IconButton(onPressed: () {}, icon: const Icon( CupertinoIcons.globe, size: 20,)),
          const Text('Website', style: TextStyle(fontSize:10),)
        ],
      ),
      Column(
        children: [
          IconButton(onPressed: () {}, icon: const Icon( CupertinoIcons.phone,size: 20)),
          const Text('CallNow',style: TextStyle(fontSize:10),)
        ],
      ),
      Column(
        children: [
          IconButton(onPressed: () {}, icon: const Icon( CupertinoIcons.text_bubble,size: 20)),
          const Text('Message',style: TextStyle(fontSize:10,),)
        ],
      ),
      Column(
        children: [
          IconButton(onPressed: () {}, icon: const Icon( CupertinoIcons.share)),
          const Text('Share')
        ],
      ),
    ]
);

