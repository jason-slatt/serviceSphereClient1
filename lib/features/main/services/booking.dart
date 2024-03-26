
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/error_handling.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:service_sphere/model/api_response.dart';
import 'package:service_sphere/model/booking.dart';
import 'package:service_sphere/model/user.dart';
import 'package:service_sphere/providers/user_provider.dart';

import '../../../constant/utils.dart';
import '../screens/appointment_screen.dart';

class Bookings {
   createBooking({
      String? customerId,
     required  String bookingStatus,
    required String day,
    required String date,
    required String time, required BuildContext context,required String serviceId}) async {
     try {
       EasyLoading.show(status : 'making Appointment');
       var user = Provider
           .of<UserProvider>(context, listen: false)
           .user;
       var url = Uri.parse('$uri/createBooking');
       print('you1');
       Booking booking = Booking(
         customerId: customerId,
         bookingStatus: bookingStatus,
           day: day,
           date: date,
           time: time,
           serviceId: serviceId
       );
       http.Response res = await http.post(
           url,
           body: booking.toJson(),
           headers: {
             'Content-type': 'application/json; charset=UTF-8',
             'X-AUTH-TOKEN': user.token!
           }
       );
       if (res.statusCode == 201) {
         return json.decode(res.body); // Booking created successfully
       } else {
         throw Exception('Failed to create booking: ${res.statusCode}');
       }

     } catch (e, stackTrace) {
       print('Caught exception: $e');
       print('Stack trace: $stackTrace');
       showSnackBar(context, 'An error occurred while creating the booking.');
     }
  }

  Future<ApiResponse<List<Booking>>> getAllBookings(BuildContext context, userId) async {
     var user = Provider.of<UserProvider>(context).user.token!;
     try{
         var url = Uri.parse('$uri/getAllBookings/$userId');
         http.Response allBookingsRes = await http.get(
             url,
             headers: {
               'content-type': 'application/json; charset=UTF-8',
               'X-AUTH-TOKEN': user
             }
         );
         print('Response status code: ${allBookingsRes.statusCode}');
         print('Response body: ${allBookingsRes.body}');
          if(allBookingsRes.statusCode == 200){
            final List<dynamic> jsonData = jsonDecode(allBookingsRes.body);
            final List<Booking> bookings = [];
            for(var data in jsonData){
              bookings.add(Booking.fromJson(data));
            }
            print('Parsed productList: $bookings');
            return ApiResponse<List<Booking>>(data: bookings);

          }
          if(allBookingsRes.statusCode == 404){
           return ApiResponse<List<Booking>>( error : true , errorMessage:'No appointment yet', statusCode: allBookingsRes.statusCode );
         }
         return ApiResponse<List<Booking>>(error: true, errorMessage: 'An error happen');
     }catch(e){
       return ApiResponse<List<Booking>>(error: true, errorMessage: e.toString());
     }
  }
   Future<FilterStatus> updateBookings(BuildContext context, String bookingId, String updateStatus) async {
     try {
       EasyLoading.show(status: 'Cancelling Booking..');
       var user = Provider.of<UserProvider>(context, listen: false).user.token;
       var url = Uri.parse('$uri/updateBookingStatus/$bookingId');

       final response = await http.put(
         url,
         body: jsonEncode(<String, String>{'newStatus': updateStatus}),
         headers: {
           'Content-Type': 'application/json; charset=UTF-8',
           'X-AUTH-TOKEN': user!,
         },
       );

       print('Response status code: ${response.statusCode}');
       print('Response body: ${response.body}');

       if (response.statusCode == 200) {
         final jsonData = jsonDecode(response.body);
         final status = FilterStatus.values.firstWhere(
               (element) => element.toString() == 'FilterStatus.$jsonData',
           orElse: () => FilterStatus.pending,
         );
         EasyLoading.showSuccess('service with ID: $bookingId cancelled');
         print('Parsed status: $status');
         EasyLoading.dismiss();
         return status;
       } else if (response.statusCode == 404) {
         print('No booking found with ID: $bookingId');
         return FilterStatus.pending; // Or return any other default status
       } else {
         print('Unable to update booking status: ${response.body}');
         throw Exception('Unable to update booking status');
       }
     } catch (e) {
       print('Error updating booking status: $e');
       throw Exception('Error updating booking status: $e');
     }
   }
}
