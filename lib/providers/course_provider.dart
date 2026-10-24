import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';
import '../services/course_api_service.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseProvider extends ChangeNotifier {
  CourseProvider({
    CourseRepository? repository,
    String baseUrl = 'https://course-api-pearl.vercel.app',
  }) : repository = repository ?? CourseRepository(CourseApiService(baseUrl));

  final CourseRepository repository;

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSaving = false;

  bool get isSaving => _isSaving;
  List<Course> get courses => List.unmodifiable(_courses);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  Future<void> loadCourses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (error) {
      _errorMessage = 'Gagal memuat data mata kuliah: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Course> createCourse(Course course) async {
    _isSaving = true;
    notifyListeners();

    try {
      return await repository.createCourse(course);
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCourse(int id, Course course) async {
    _isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);
      await loadCourses();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> deleteCourse(int id) async {
    _isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);
      await loadCourses();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
