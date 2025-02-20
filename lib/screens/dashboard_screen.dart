import 'package:flutter/material.dart';
import 'blood_donation_screen.dart';
import 'breast_milk_donation_screen.dart';
import 'find_donor_screen.dart';
import 'alerts_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton("Donate Blood", Colors.red, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BloodDonationScreen(),
                ),
              );
            }),
            _buildButton("Donate Breast Milk", Colors.pink, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BreastMilkDonationScreen(),
                ),
              );
            }),
            _buildButton("Find a Donor", Colors.blue, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindDonorScreen(),
                ),
              );
            }),
            _buildButton("Urgent Alerts", Colors.orange, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlertsScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
