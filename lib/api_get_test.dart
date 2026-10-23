import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Identitas Mahasiswa
const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

// Endpoint REST API dari dosen
const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));

  debugPrint('HTTP Status: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data is List) {
      debugPrint('Jumlah data diterima: ${data.length}');
      return data;
    }

    throw Exception('Format respons bukan array JSON.');
  }

  throw Exception('HTTP ${response.statusCode}');
}

void main() {
  runApp(const ApiGetTestApp());
}

class ApiGetTestApp extends StatelessWidget {
  const ApiGetTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTTP GET Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ApiGetTestPage(),
    );
  }
}

class ApiGetTestPage extends StatefulWidget {
  const ApiGetTestPage({super.key});

  @override
  State<ApiGetTestPage> createState() => _ApiGetTestPageState();
}

class _ApiGetTestPageState extends State<ApiGetTestPage> {
  late Future<List<dynamic>> coursesFuture;

  @override
  void initState() {
    super.initState();
    coursesFuture = fetchCourses();
  }

  void retryRequest() {
    setState(() {
      coursesFuture = fetchCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengujian REST API'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              studentName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('NIM: $studentId'),
            const SizedBox(height: 20),
            const Text(
              'HTTP GET - Course API',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SelectableText(apiUrl),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 40,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gagal mengambil data:\n${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: retryRequest,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  final courses = snapshot.data ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: HTTP 200 OK',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jumlah data diterima: ${courses.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Data mata kuliah:'),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];

                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${course['id']}'),
                                ),
                                title: Text('${course['title']}'),
                                subtitle: Text(
                                  'Kode: ${course['code']}'
                                  '\nStatus: ${course['status']}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
