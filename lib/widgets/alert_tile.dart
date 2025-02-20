import 'package:flutter/material.dart';

class AlertTile extends StatelessWidget {
  final String title;
  final String description;
  final String contact;

  const AlertTile({
    super.key,
    required this.title,
    required this.description,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.red.shade100,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 5),
            Text(
              contact,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.warning, color: Colors.red),
      ),
    );
  }
}
