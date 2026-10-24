import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  CourseRepository(this._apiService);

  final CourseApiService _apiService;

  Future<List<Course>> getCourses() {
    return _apiService.getCourses();
  }

  Future<Course> createCourse(Course course) {
    return _apiService.createCourse(course);
  }
}
