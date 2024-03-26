
import 'package:flutter/material.dart';
import 'package:service_sphere/features/admin/screens/appointment_screen.dart';
import 'package:styled_widget/styled_widget.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key,});

  Widget _buildActionItem(BuildContext context,String name, IconData icon, String routeName,VoidCallback onTap) {
    final Widget actionIcon = Icon(icon, size: 20, color: const Color(0xFF42526F))
        .alignment(Alignment.center)
        .ripple()
        .constrained(width: 50, height: 50)
        .backgroundColor(const Color(0xfff6f5f8))
        .clipOval()
        .padding(bottom: 5)
        .gestures(onTap: onTap);

    final Widget actionText = Text(
      name,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 12,
      ),
    );

    return <Widget>[
      actionIcon,
      actionText,
    ].toColumn().padding(vertical: 20);
  }

  @override
  Widget build(BuildContext context) => <Widget>[
    _buildActionItem( context, 'Wallet', Icons.attach_money,'wallet', () {}),
    _buildActionItem(context,'Message', Icons.message, '/Messages', () {}),
    _buildActionItem(context,'Appointment', Icons.room_service, AdminAppointment.routeName ,() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminAppointment() ));
    }),
  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
}