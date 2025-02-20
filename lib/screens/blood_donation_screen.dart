import 'package:flutter/material.dart';

class BloodDonationScreen extends StatelessWidget {
  const BloodDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blood Donation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Blood",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Fill in the details below to schedule your blood donation.",
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Blood donation request submitted!"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
