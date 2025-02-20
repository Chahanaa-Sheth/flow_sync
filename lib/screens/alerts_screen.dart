import 'package:flutter/material.dart';
import '../widgets/alert_tile.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Urgent Alerts")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          AlertTile(
            title: "Urgent Blood Needed",
            description: "O+ blood needed at XYZ Hospital, Chennai",
            contact: "Contact: 9876543210",
          ),
          AlertTile(
            title: "Breast Milk Needed",
            description: "Premature baby needs milk at ABC NICU, Bangalore",
            contact: "Contact: 9876543210",
          ),
        ],
      ),
    );
  }
}
