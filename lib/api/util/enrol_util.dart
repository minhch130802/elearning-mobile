import 'util.dart';

class EnrolUtil extends GlobalUtil {
  final String _selfEnrolUser = "enrol_self_enrol_user";
  final String _getEnrolMethod = "core_enrol_get_course_enrolment_methods";
  final String _getEnrolMethodInfo = "enrol_self_get_instance_info";

  Map<String, dynamic> selfEnrolUser(int courseId, String password) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._selfEnrolUser}',
      'courseid': courseId,
      'password': password
    };

    return body;
  }

  Map<String, dynamic> getEnrolMethod(int id) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getEnrolMethod}',
      'courseid': id
    };

    return body;
  }

  Map<String, dynamic> getEnrolMetodInfo(int id) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getEnrolMethodInfo}',
      'instanceid': id
    };

    return body;
  }
}