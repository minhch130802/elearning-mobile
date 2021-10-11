import 'package:elearning_project/utilities/webservice_functions.dart';

import 'global_util.dart';

class CourseUtil extends GlobalUtil {
  Future<Map<String, dynamic>> getCourseContentBody(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreCourseGetContents,
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> logViewedCourseBody(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreCourseViewCourse,
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCategoryBody(parent) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreCourseGetCategories,
      'criteria[0][key]': 'parent',
      'criteria[0][value]': parent
    };

    return body;
  }

  Future<Map<String, dynamic>> getCourseByFieldBody(int categoryId, String fieldName) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreCourseGetCoursesByField,
      'field': fieldName,
      'value': categoryId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCourseParticipantsBody(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreEnrolGetEnrolledUsers,
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCoursesEnrolledBody() async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': WSFunctions.coreEnrolGetUsersCourses,
      'userid': await super.getUserId()
    };

    return body;
  }

  Future<Map<String, dynamic>> getGradeBody() async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.gradeReportOverviewGetCourseGrades,
      'userid': await super.getUserId()
    };

    return body;
  }
}