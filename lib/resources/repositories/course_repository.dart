import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/models/course/course_category.dart';
import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/models/user/user.dart';
import 'package:elearning_project/resources/api/api.dart';

class CourseRepository {
  final courseRestAPI = new CourseRestAPI();

  Future<List<CourseContent>> fetchCourseContent(id) => courseRestAPI.getCourseContent(id);

  Future<List<CourseCategory>> fetchCourseCategories(parent) => courseRestAPI.getCourseCategory(parent);

  Future<List<Course>> getCourseByCategory(id) => courseRestAPI.getCourseByCategory(id);

  Future<List<User>> getEnrolledParticipants(id) => courseRestAPI.getEnrolledParticipants(id);
}