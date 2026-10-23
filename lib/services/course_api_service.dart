//I Komang Candra Aryadinata || 2415051085
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil course. '
        'Status code: ${response.statusCode}',
      );
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
      return Course.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }
}
