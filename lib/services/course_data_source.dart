//I Komang Candra Aryadinata || 2415051085
import '../models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();

  Future<Course> createCourse(Course course);

  Future<void> updateCourse(int id, Course course);

  Future<void> deleteCourse(int id);
}
