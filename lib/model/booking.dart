import 'dart:convert';

import 'package:flutter/foundation.dart';

class Booking{
  late  final String? id;
  late final String? customerId;
  late final String? serviceId;
  late final String? customerName;
  late final String? serviceProviderName;
  late final String? serviceCategory;
  late final String? serviceName;
  late final String? serviceImage;
  late final String day;
  late final String date;
  late final String time;
  late final String bookingStatus;

  Booking({ this. serviceName, this. serviceImage, this.customerName, this.serviceCategory, this.serviceProviderName, this.id,this.customerId,this.serviceId, required this.date, required this.day,required this.time, required this.bookingStatus});

  factory Booking.fromJson(Map<String, dynamic> json){
    return  Booking(
      id: json['_id']??'',
        customerId: json['customerId']?? '',
        serviceId: json['serviceId']?? '',
        customerName:json['customerName'] ,
        serviceProviderName: json['serviceProviderName'],
        serviceCategory: json['serviceCategory'],
        serviceImage: json['serviceImage'],
        serviceName: json['serviceName'],
        day: json['day'],
        date: json['date']?? '',
        time: json['time']?? '',
      bookingStatus: json['bookingStatus']?? ''
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "customerId" : customerId,
    "serviceId" : serviceId,
    "day": day,
    "date": date,
    "time" : time,
    "bookingStatus" : bookingStatus
  };

  String toJson() => json.encode(toMap());

}

