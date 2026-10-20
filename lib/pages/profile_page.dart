import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/feedback_form_widget.dart';

// I Komang Candra Aryadinata || 2415051085
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                studentName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('NIM: $studentId'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Form Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const FeedbackFormWidget(),
        ],
      ),
    );
  }
}
