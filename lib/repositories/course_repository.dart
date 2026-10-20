import '../models/course.dart';
import '../services/course_service.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseRepository {
  final CourseService courseService;

  CourseRepository({CourseService? courseService})
    : courseService = courseService ?? CourseService();

  Future<List<Course>> getCourses() async {
    return await courseService.fetchCourses();
  }
}
