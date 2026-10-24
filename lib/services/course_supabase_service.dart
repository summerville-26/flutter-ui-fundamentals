import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

import 'package:flutter/foundation.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseSupabaseService implements CourseDataSource {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    debugPrint('Supabase URL: ${supabase.rest.url}');
    debugPrint('Mulai mengambil data dari tabel courses...');

    final data = await supabase.from('courses').select().order('id');

    debugPrint('Hasil query courses: $data');
    debugPrint('Jumlah baris: ${(data as List).length}');

    final courses = data
        .map((item) => Course.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    debugPrint('Jumlah objek Course: ${courses.length}');

    return courses;
  }

  // I Komang Candra Aryadinata || 2415051085
  @override
  Future<Course> createCourse(Course course) async {
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(Map<String, dynamic>.from(row));
  }

  // Akan diimplementasikan pada Tahap 14.
  @override
  Future<void> updateCourse(int id, Course course) {
    throw UnimplementedError('Update course akan dibuat pada Tahap 14.');
  }

  // Akan diimplementasikan pada Tahap 15.
  @override
  Future<void> deleteCourse(int id) {
    throw UnimplementedError('Delete course akan dibuat pada Tahap 15.');
  }
}
