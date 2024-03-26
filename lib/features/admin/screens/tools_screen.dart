
import 'package:flutter/material.dart';
import 'package:service_sphere/components/admin_card.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../common/raw.dart';
import '../../../components/action_row.dart';
import '../../../components/settings.dart';

class BusinessTools extends StatelessWidget {
  const BusinessTools({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(child: AdminToolsPage()),
      ),
    );
  }
}

class AdminToolsPage extends StatelessWidget {
  const AdminToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    page({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .scrollable();

    return <Widget>[
      const Text(
        'Business Tools',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ).alignment(Alignment.centerLeft).padding(bottom: 20),
      const AdminCard(),
      const ActionsRow(),
      const Settings(),
    ].toColumn().parent(page);
  }
}