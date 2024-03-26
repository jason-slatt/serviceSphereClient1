
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class AdminCard extends StatelessWidget {
  const AdminCard({super.key});

  Widget _buildUserRow() {
    return <Widget>[
      const Icon(Icons.account_circle)
          .decorated(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      )
          .constrained(height: 50, width: 50)
          .padding(right: 10),
      <Widget>[
        const Text(
          'Olomo kenneth',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
        Text(
          'software Engineer',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      _buildUserStatsItem('846', 'pending client'),
      _buildUserStatsItem('51', 'ongoing job'),
      _buildUserStatsItem('267', 'completed job'),
      _buildUserStatsItem('39', 'profile view'),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value, String text) => <Widget>[
    Text(value).fontSize(20).textColor(Colors.white).padding(bottom: 5),
    Text(text).textColor(Colors.white.withOpacity(0.6)).fontSize(12),
  ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
        color: const Color(0xff3977ff), borderRadius: BorderRadius.circular(20))
        .elevation(
      5,
      shadowColor: const Color(0xff3977ff),
      borderRadius: BorderRadius.circular(20),
    )
        .height(175)
        .alignment(Alignment.center);
  }
}