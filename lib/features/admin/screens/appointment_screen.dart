import 'package:flutter/material.dart';

class AdminAppointment extends StatefulWidget {
  static const String routeName = '/Admin-Appointment';
  const AdminAppointment({super.key});

  @override
  State<AdminAppointment> createState() => _AdminAppointmentState();
}

class _AdminAppointmentState extends State<AdminAppointment> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
      ),
    );
  }
}
