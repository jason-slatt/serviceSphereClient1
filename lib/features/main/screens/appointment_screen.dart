import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_sphere/constant/global_variable.dart';
import 'package:service_sphere/features/admin/widget/single_product.dart';
import 'package:service_sphere/features/main/services/booking.dart';
import 'package:service_sphere/model/api_response.dart';
import 'package:service_sphere/model/booking.dart';
import 'package:service_sphere/providers/user_provider.dart';

class AppointmentScreen extends StatefulWidget {
  static const String routeName = '/appointment-screen';
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}
//enum for appointment
enum FilterStatus {pending,upcoming,completed,cancelled}

class _AppointmentScreenState extends State<AppointmentScreen> {
  FilterStatus status = FilterStatus.pending; //initial status
  Alignment _alignment = Alignment.centerLeft;
  Bookings booking = Bookings();
  bool _isLoading = false;
 late ApiResponse<List<Booking>> schedules = ApiResponse();
  late FilterStatus updateStatus;

  List<Booking> bookings = [];
  List<Booking> filteredBookings = [];// List to hold filtered bookings
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllBookings(context);
  }

  Future<void> getAllBookings( BuildContext context ) async {
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;
    setState(() {
      _isLoading = true;
    });

    schedules = await booking.getAllBookings(context, userId);
    setState(() {
      bookings = schedules.data ?? [];
      filterAppointments();
      _isLoading = false;
    });
  }

  Future<void> updateBooking(BuildContext context,String bookingId, String newStatus) async {
    updateStatus = await booking.updateBookings(context, bookingId, newStatus);
    setState(() {
      status = updateStatus;
    });
  }

  void filterAppointments() {
    filteredBookings = bookings.where((booking) {
      switch (status) {
        case FilterStatus.pending:
          return booking.bookingStatus == 'pending';
        case FilterStatus.upcoming:
          return booking.bookingStatus == 'upcoming';
        case FilterStatus.completed:
          return booking.bookingStatus == 'completed';
        case FilterStatus.cancelled:
          return booking.bookingStatus == 'cancelled';
        default:
          return false;
      }
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (_) {
        if(_isLoading){
         const Center( child: CircularProgressIndicator());
        }
        if(schedules.errorMessage != null){
          return Center(child: Text('${schedules.errorMessage}'));
        }
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          child: _isLoading ? const Center( child: CircularProgressIndicator())
          :Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              const Text(
                'Appointment Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ) ,
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CupertinoSegmentedControl<FilterStatus>(
                      children: const {
                        FilterStatus.pending: Text('Pending'),
                        FilterStatus.upcoming: Text('Upcoming'),
                        FilterStatus.completed: Text('Completed'),
                        FilterStatus.cancelled: Text('Cancelled'),
                      },
                      groupValue: status,
                      onValueChanged: (FilterStatus value) {
                        setState(() {
                          status = value;
                          // Filter the bookings based on the selected status
                          filterAppointments();
                        });
                      },
                      borderColor: GlobalVariables.secondaryColor,
                      selectedColor: GlobalVariables.secondaryColor,
                      unselectedColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child:ListView.builder(
                    itemCount: filteredBookings.length ,
                    itemBuilder: ((context, index) {
                      var  _schedule = filteredBookings[index];
                      bool _isLastElement =  filteredBookings.length - 1 == index;
                      return Card(
                        borderOnForeground: true,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                        ),
                        margin: !_isLastElement? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                        child:  Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                   CircleAvatar(
                                    backgroundImage: NetworkImage(_schedule.serviceImage?? '', ),
                                     maxRadius: 35,
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _schedule.serviceName ?? '',
                                        style: const TextStyle(
                                          fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(
                                        _schedule.serviceCategory?? '',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 70),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                child:  Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_today, color: GlobalVariables.secondaryColor, size: 15,),
                                    const SizedBox(width: 20,),
                                    Row(
                                      children: [
                                        Text(
                                          _schedule.day ?? '',
                                          style: const TextStyle(
                                              color: GlobalVariables.secondaryColor
                                          ),
                                        ),
                                        const Text(','),
                                        Text(
                                            _schedule.date ?? '',
                                            style: const TextStyle(
                                                color: GlobalVariables.secondaryColor
                                            )
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    const  Icon(Icons.access_alarm, color: GlobalVariables.secondaryColor, size: 15,),
                                    const SizedBox(width: 20,),
                                    Flexible(child: Text(_schedule.time ?? '', style: const TextStyle(color: GlobalVariables.secondaryColor),))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              if(_schedule.bookingStatus == 'pending')Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        updateBooking(context, _schedule.id?? '', 'cancelled');
                                      },
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                        side: BorderSide.none
                                      ),
                                      child: const Text(
                                        'cancel',
                                        style: TextStyle(
                                            color: GlobalVariables.backgroundColor
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                 Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                      },
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: GlobalVariables.secondaryColor,
                                          side: BorderSide.none
                                      ),
                                      child:  const Text(
                                        'Reschedule',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if(_schedule.bookingStatus == 'upcoming')Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: GlobalVariables.secondaryColor,
                                      side: BorderSide.none
                                  ),
                                  child:  const Text(
                                    'Job completed',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                ),
              )
            ],
          ) ,
        );
      })
    );
  }
}

