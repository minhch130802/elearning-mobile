import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/models/course/course_category.dart';
import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/models/course/grade.dart';
import 'package:elearning_project/models/user/user.dart';
import '../util/util.dart';
import 'package:dio/dio.dart';

class CourseRestAPI extends CourseUtil {
  Dio dio = new Dio();

  //This will get the course content with the course id
  //If user with student role and not enrol to that course
  //this func will return en exception.
  Future<List<CourseContent>> getCourseContent(int courseId) async {
    List<CourseContent> courseContentList = [];
    FormData formData =
        new FormData.fromMap(await super.getCourseContentBody(courseId));
    FormData formDataLog =
        new FormData.fromMap(await super.logViewedCourse(courseId));

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      if (response.data is List) {
        final responseLength = response.data.length;

        for (int i = 0; i < responseLength; i++) {
          CourseContent content = new CourseContent.fromJSON(response.data[i]);
          courseContentList.add(content);
        }

        await dio.post(super.baseURL, data: formDataLog);
      } else {
        throw (response.data['errorcode']);
      }
    }

    return courseContentList;
  }

  Future<List<CourseCategory>> getCourseCategory(parent) async {
    FormData formData = new FormData.fromMap(await super.getCategoryBody(parent));

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<CourseCategory> courseCategoryList = [];

      for (int i = 0; i < response.data.length; i++) {
        if(response.data[i]['parent'] == parent) {
          CourseCategory content = new CourseCategory.fromJSON(
              response.data[i]);
          courseCategoryList.add(content);
        }
      }

      return courseCategoryList;
    }

    return [];
  }

  Future<List<Course>> getCourseByCategory(int id) async {
    FormData formData =
        new FormData.fromMap(await super.getCourseByFieldBody(id, 'category'));

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<Course> courseList = [];

      final responseLength = response.data["courses"].length;
      if (responseLength == 0) return [];

      for (int i = 0; i < responseLength; i++) {
        Course content = new Course.fromJSON(response.data["courses"][i]);
        courseList.add(content);
      }

      return courseList;
    }

    return [];
  }

  Future<List<User>> getEnrolledParticipants(int id) async {
    FormData formData =
        new FormData.fromMap(await super.getCourseParticipantsBody(id));

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<User> userList = [];
      final responseLength = response.data.length;

      if (responseLength == 0) return [];

      for (int i = 0; i < responseLength; i++) {
        User content = new User.fromJSON(response.data[i]);
        userList.add(content);
      }

      return userList;
    }

    return [];
  }

  Future<List<Course>> getEnrolledCourses() async {
    FormData formData = new FormData.fromMap(await super.getCoursesEnrolled());

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<Course> courseList = [];

      final responseLength = response.data.length;
      if (responseLength == 0) return [];

      for (int i = 0; i < responseLength; i++) {
        Course content = new Course.fromJSON(response.data[i]);
        courseList.add(content);
      }

      return courseList;
    }

    return [];
  }

  Future<Course?> getCourseInformation(int id) async {
    FormData formDataGetCourse =
        new FormData.fromMap(await super.getCourseByFieldBody(id, 'id'));

    final responseCourse =
        await dio.post(super.baseURL, data: formDataGetCourse);
    
    if(responseCourse.statusCode == 200) {
      return Course.fromJSON(responseCourse.data['courses'][0]);
    }
    
    return null;
  }

  Future<List<GradeModel?>> getUserGrade() async {
    FormData formData = new FormData.fromMap(await super.getGrade());

    final response = await dio.post(super.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<GradeModel?> gradeList = [];
      final responseLength = response.data['grades'].length;

      for (int i = 0; i < responseLength; i++) {
        GradeModel? content;

        await this.getCourseInformation(response.data['grades'][i]['courseid']).then((value) {
           content = new GradeModel.fromJSON(
              response.data['grades'][i], value!.fullName);
        }).whenComplete((){
          gradeList.add(content);
        });
      }

      return gradeList;
    }

    return [];
  }
}
