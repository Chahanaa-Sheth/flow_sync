import 'package:flutter/material.dart';

class RequestDashboard extends StatelessWidget {
  const RequestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRequestTile(
            "Request Blood",
            Icons.bloodtype,
            Colors.red,
            () {},
          ),
          _buildRequestTile(
            "Request Breast Milk",
            Icons.child_care,
            Colors.pink,
            () {},
          ),
          _buildRequestTile("View Requests", Icons.list, Colors.blue, () {}),
        ],
      ),
    );
  }

  Widget _buildRequestTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
