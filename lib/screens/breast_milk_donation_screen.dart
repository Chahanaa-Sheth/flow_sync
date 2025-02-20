import 'package:flutter/material.dart';

class BreastMilkDonationScreen extends StatelessWidget {
  const BreastMilkDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Breast Milk Donation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Breast Milk",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Fill in the details below to donate breast milk."),
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
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Breast milk donation request submitted!"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
