import 'package:flutter/material.dart';
import 'package:service_sphere/constant/global_variable.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
             const  Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/defaultPicture.png'),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('jay wilson', style: TextStyle(color: Colors.white),),
                      SizedBox(height: 2,),
                      Text('Cleaner', style: TextStyle(color: Colors.black),),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              //schedule info here
             const  ScheduleCard(),
              const SizedBox(height: 10,),
              //Action Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                          onPressed: () {},
                          child: const Text('Cancel', style: TextStyle(color : Colors.white),)
                      )
                  ),
                 const SizedBox(width: 10,),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          ),
                          onPressed: () {},
                          child: const Text('Completed', style: TextStyle(color : Colors.white),)
                      )
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, color: Colors.white, size: 15,),
          SizedBox(width: 5,),
          Text(
            'Monday,11/28/2024',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm, color: Colors.white, size: 15,),
          SizedBox(width: 5,),
          Flexible(child: Text('2:PM', style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}

