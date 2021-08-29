import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/models/course/course_category.dart';
import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/models/user/user.dart';
import '../util/util.dart';
import 'package:dio/dio.dart';

class CourseRestAPI extends CourseUtil{

  Dio dio = new Dio();


  //This will get the course content with the course id
  //If user with student role and not enrol to that course
  //this func will return en exception.
  Future<List<CourseContent>> getCourseContent(int courseId) async {

    FormData formData = new FormData.fromMap(super.getCourseContentBody(courseId));

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200){
      List<CourseContent> courseContentList = [];
      if(response.data['exception'] == null)  {
        final responseLength = response.data.length;

        for(int i = 0; i < responseLength; i++){
          CourseContent content = new CourseContent.fromJSON(response.data[i]);
          courseContentList.add(content);
        }

        return courseContentList;
      } else {
        throw(response.data['errorcode']);
      }

    }

    return [];
  }

  Future<List<CourseCategory>> getCourseCategory() async {
    FormData formData = new FormData.fromMap(super.getCategoryBody());

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200){
      List<CourseCategory> courseCategoryList = [];

      for(int i = 0; i < response.data.length; i++){
        CourseCategory content = new CourseCategory.fromJSON(response.data[i]);
        courseCategoryList.add(content);
      }

      return courseCategoryList;
    }

    return [];
  }

  Future<List<Course>> getCourseByCategory(int id) async {
    FormData formData = new FormData.fromMap(super.getCourseByCategoryBody(id));

    final response = await dio.post(
        super.baseURL,
      data: formData
    );

    if(response.statusCode == 200){
      List<Course> courseList = [];

      final responseLength = response.data["courses"].length;
      if(responseLength == 0) return [];

      for(int i = 0; i < responseLength; i++){
        
        Course content = new Course.fromJSON(response.data["courses"][i]);
        courseList.add(content);
      }

      return courseList;
    }

    return [];
  }

  Future<List<User>> getEnrolledParticipants(int id) async {
    FormData formData = new FormData.fromMap(super.getCourseParticipantsBody(id));

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200){
      List<User> userList = [];
      final responseLength = response.data.length;

      if(responseLength == 0) return [];

      for(int i = 0; i < responseLength; i++){

        User content = new User.fromJSON(response.data[i]);
        userList.add(content);
      }

      return userList;
    }

    return [];
  }
}