import 'dart:convert';
import 'dart:io';
import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/models/course/course_category.dart';
import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/models/user/user.dart';
import 'util.dart';
import 'package:dio/dio.dart';

class CourseAPI {

  //Define varibles
  APIUtil _apiUtil = new APIUtil();
  Dio dio = new Dio();


  //This will get the course content with the course id
  Future<List<CourseContent>> getCourseContent(int courseId) async {

    FormData formData = new FormData.fromMap(_apiUtil.getCourseContentBody(courseId));

    final response = await dio.post(
        _apiUtil.baseURL,
        data: formData
    );

    if(response.statusCode == 200){
      List<CourseContent> courseContentList = [];
      final responseLength = response.data.length;

      for(int i = 0; i < responseLength; i++){
        CourseContent content = new CourseContent.fromJSON(response.data[i]);
        courseContentList.add(content);
      }

      return courseContentList;
    }

    return [];
  }

  Future<List<CourseCategory>> getCourseCategory() async {
    FormData formData = new FormData.fromMap(_apiUtil.getCategoryBody());

    final response = await dio.post(
        _apiUtil.baseURL,
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
    FormData formData = new FormData.fromMap(_apiUtil.getCourseByCategoryBody(id));

    final response = await dio.post(
        _apiUtil.baseURL,
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
    FormData formData = new FormData.fromMap(_apiUtil.getCourseParticipantsBody(id));

    final response = await dio.post(
        _apiUtil.baseURL,
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