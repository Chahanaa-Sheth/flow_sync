import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'request_dashboard.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "How do you want to proceed?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildButton("I want to Donate", Colors.red, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              }),
              _buildButton(
                "I need Blood/Breast Milk",
                Colors.pink.shade300,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestDashboard(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
