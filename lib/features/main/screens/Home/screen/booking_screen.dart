
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_sphere/features/auth/widget/custom_button.dart';
import 'package:service_sphere/features/main/screens/Home/screen/serrvice_description_screen.dart';
import 'package:service_sphere/features/main/screens/Home/screen/sucess_booking_screen.dart';
import 'package:service_sphere/features/main/screens/appointment_screen.dart';
import 'package:service_sphere/features/main/services/booking.dart';
import 'package:service_sphere/main.dart';
import 'package:service_sphere/model/dateTime_convert.dart';
import 'package:service_sphere/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant/utils.dart';

class BookingScreen extends StatefulWidget {
  static const String routeName = '/booking-screen';
  final String serviceId;
  const BookingScreen({super.key,required this.serviceId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  //declaration
  Bookings bookings = Bookings();
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusday = DateTime.now();
  DateTime _currentday = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String bookingStatus = 'pending';

  void createBooking() async {
    var customerId = Provider.of<UserProvider>(context, listen: false).user.id;
    if (_dateSelected && _timeSelected) {
      final getDate = DateConverted.getDate(_currentday);
      final getDay = DateConverted.getDay(_currentday.weekday);
      final getTime = DateConverted.getTime(_currentIndex!);
      final result = await bookings.createBooking(
          day: getDay,
          date: getDate,
          time: getTime,
          bookingStatus: bookingStatus,
          context: context,
          customerId: customerId,
          serviceId: widget.serviceId);
      if (result != null) {
        // Booking created successfully, navigate to success screen
        Navigator.pop(context);
        EasyLoading.showSuccess('Appointment successfully booked, please wait for service provider review');
        EasyLoading.dismiss();
      } else {
        print('Failed to create booking');
        // Handle booking creation failure
        EasyLoading.showError('Appointment successfully booked, please wait for service provider review');
      }
    } else {
      // Handle case where date or time is not selected
      EasyLoading.show(status : 'please select both time and date to make an appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment')
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                //display calender here
                _tableCalender(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'Select Working Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend?
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: const Text(
                'weekend is not available, please select another day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
            ),
          )
              : SliverGrid(
              delegate: SliverChildBuilderDelegate((context , index){
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: (){
                    setState((){
                      _currentIndex = index;
                      _timeSelected = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index ? Colors.white : Colors.black
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: _currentIndex == index? GlobalVariables.secondaryColor : null
                    ),
                    alignment: Alignment.center,
                    child: Text(
                        '${index + 9 }: 00 ${index + 9 > 11? "PM" : "AM" }',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index? Colors.white : null
                      ),
                    ),
                  ),
                );
              },
                childCount: 8
              ),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                childAspectRatio: 2.5
              )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: CustomButton(
                text: 'Make Appointment',
                onTap: () => createBooking(),
              ),
            ),
          )
        ],
      ),
    );
  }
  //calender widget
Widget _tableCalender(){
    return TableCalendar(
        focusedDay: _focusday,
        firstDay: DateTime.now(),
        lastDay: DateTime(2024, 12, 12),
        calendarFormat: _format,
        currentDay: _currentday,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
            color: GlobalVariables.secondaryColor,
            shape: BoxShape.circle,
        )
      ),
      availableCalendarFormats: const {
        CalendarFormat.month : 'month',
      },
      onFormatChanged: (format){
          setState(() {
            _format = format;
          });
      },
      //check if weekend is selected
      onDaySelected: ((selectedDay, focusedDay){
        setState(() {
          _currentday = selectedDay;
          _focusday = focusedDay;
          _dateSelected = true;
          if(selectedDay.weekday == 6 || selectedDay.weekday == 7){
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
}
}
