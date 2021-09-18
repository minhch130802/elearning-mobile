import 'util.dart';

class EnrolUtil extends GlobalUtil {
  final String _selfEnrolUser = "enrol_self_enrol_user";
  final String _getEnrolMethod = "core_enrol_get_course_enrolment_methods";
  final String _getEnrolMethodInfo = "enrol_self_get_instance_info";

  Future<Map<String, dynamic>> selfEnrolUser(int courseId, String password) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._selfEnrolUser}',
      'courseid': courseId,
      'password': password
    };

    return body;
  }

  Future<Map<String, dynamic>> getEnrolMethod(int id) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getEnrolMethod}',
      'courseid': id
    };

    return body;
  }

  Future<Map<String, dynamic>> getEnrolMetodInfo(int id) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getEnrolMethodInfo}',
      'instanceid': id
    };

    return body;
  }
}