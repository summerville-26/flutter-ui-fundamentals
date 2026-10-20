import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider({CourseRepository? repository})
    : repository = repository ?? CourseRepository();

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _errorMessage;

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
}
