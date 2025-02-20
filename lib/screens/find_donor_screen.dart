import 'package:flutter/material.dart';

class FindDonorScreen extends StatelessWidget {
  const FindDonorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find a Donor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find a Donor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Search for nearby donors based on blood group or breast milk availability.",
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Blood Group / Milk Requirement",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Searching for donors...")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
              ),
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
