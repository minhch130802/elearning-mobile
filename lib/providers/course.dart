import 'package:elearning_project/models/fetch_exception.dart';
import 'package:elearning_project/models/model.dart';
import 'package:dio/dio.dart';
import 'package:elearning_project/utilities/webservice_functions.dart';

import 'course_util.dart';

class CourseRestAPI extends CourseUtil {
  static BaseOptions options = new BaseOptions(
    baseUrl: WSFunctions.baseURL,
    connectTimeout: 5000,
    receiveTimeout: 10000,
  );

  Dio dio = new Dio(options);

  //This will get the course content with the course id
  //If user with student role and not enrol to that course
  //this func will return en exception.
  Future<dynamic> getCourseContent(int courseId) async {

    FormData formData =
        new FormData.fromMap(await super.getCourseContentBody(courseId));
    FormData formDataLog =
        new FormData.fromMap(await super.logViewedCourseBody(courseId));

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200 && response.data is List) {
      await dio.post(WSFunctions.baseURL, data: formDataLog);
      return response;
    } else {
      throw FetchException(response.data['errorcode']);
    }
  }

  Future<dynamic> getCourseCategory(parent) async {
    FormData formData = new FormData.fromMap(await super.getCategoryBody(parent));

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200) {
      if(response.data is List) {
        return response;
      } else {
        throw FetchException(response.data['message']);
      }
    } else {
      throw FetchException(response.statusMessage!);
    }
  }

  Future<dynamic> getCourseByCategory(int id) async {
    FormData formData =
        new FormData.fromMap(await super.getCourseByFieldBody(id, 'category'));

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200) {
      if(response.data['message'] != null) {
        throw FetchException(response.data['message']);
      } else {
        return response;
      }
    } else {
      throw FetchException(response.statusMessage!);
    }
  }

  Future<List<UserModel>> getEnrolledParticipants(int id) async {
    FormData formData =
        new FormData.fromMap(await super.getCourseParticipantsBody(id));

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<UserModel> userList = [];
      final responseLength = response.data.length;

      if (responseLength == 0) return [];

      for (int i = 0; i < responseLength; i++) {
        UserModel content = new UserModel.fromJSON(response.data[i]);
        userList.add(content);
      }

      return userList;
    }

    return [];
  }

  Future<List<CourseModel>> getEnrolledCourses() async {
    FormData formData = new FormData.fromMap(await super.getCoursesEnrolledBody());

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<CourseModel> courseList = [];

      final responseLength = response.data.length;
      if (responseLength == 0) return [];

      for (int i = 0; i < responseLength; i++) {
        CourseModel content = new CourseModel.fromJSON(response.data[i]);
        courseList.add(content);
      }

      return courseList;
    }

    return [];
  }

  Future<CourseModel?> getCourseInformation(int id) async {
    FormData formDataGetCourse =
        new FormData.fromMap(await super.getCourseByFieldBody(id, 'id'));

    final responseCourse =
        await dio.post(WSFunctions.baseURL, data: formDataGetCourse);
    
    if(responseCourse.statusCode == 200) {
      return CourseModel.fromJSON(responseCourse.data['courses'][0]);
    }
    
    return null;
  }

  Future<List<GradeModel?>> getUserGrade() async {
    FormData formData = new FormData.fromMap(await super.getGradeBody());

    final response = await dio.post(WSFunctions.baseURL, data: formData);

    if (response.statusCode == 200) {
      List<GradeModel?> gradeList = [];
      final responseLength = response.data['grades'].length;

      for (int i = 0; i < responseLength; i++) {
        GradeModel? content;

        await this.getCourseInformation(response.data['grades'][i]['courseid']).then((value) {
           content = new GradeModel.fromJSON(
              response.data['grades'][i], value!.fullName ?? '');
        }).whenComplete((){
          gradeList.add(content);
        });
      }

      return gradeList;
    }

    return [];
  }
}
