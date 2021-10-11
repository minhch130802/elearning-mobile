import 'package:elearning_project/utilities/webservice_functions.dart';
import 'global_util.dart';

class EnrolUtil extends GlobalUtil {

  Future<Map<String, dynamic>> selfEnrolUserBody(int courseId, String password) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.enrolSelfEnrolUser,
      'courseid': courseId,
      'password': password
    };

    return body;
  }

  Future<Map<String, dynamic>> getEnrolMethodBody(int id) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreEnrolGetCourseEnrolmentMethods,
      'courseid': id
    };

    return body;
  }

  Future<Map<String, dynamic>> getEnrolMethodInfo(int id) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.enrolSelfGetInstanceInfo,
      'instanceid': id
    };

    return body;
  }
}