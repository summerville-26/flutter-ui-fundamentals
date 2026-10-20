import 'package:flutter/material.dart';

import '../data/course_data.dart';
import '../main.dart';

// I Komang Candra Aryadinata || 2415051085
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, $studentName!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('NIM: $studentId'),
                  const SizedBox(height: 12),
                  const Text(
                    'Jelajahi modul pembelajaran interactive mobile '
                    'development pada tab Courses.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ringkasan Kursus',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.class_, color: Colors.blue),
            title: const Text('Total Course Available'),
            trailing: Text('${dummyCourses.length} Courses'),
          ),
        ],
      ),
    );
  }
}
