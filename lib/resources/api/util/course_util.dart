import 'util.dart';

class CourseUtil extends GlobalUtil {
  final String _getCourseContent = "core_course_get_contents";
  final String _getCourseCategory = "core_course_get_categories";
  final String _getCoursesByField = "core_course_get_courses_by_field";
  final String _getEnrolledParticipants = "core_enrol_get_enrolled_users";
  final String _getEnrolledUserCourses = "core_enrol_get_users_courses";
  final String _logViedCourse = "core_course_view_course";
  final String _getGrade = "gradereport_overview_get_course_grades";

  Future<Map<String, dynamic>> getCourseContentBody(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getCourseContent}',
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> logViewedCourse(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._logViedCourse}',
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCategoryBody(parent) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getCourseCategory}',
      'criteria[0][key]': 'parent',
      'criteria[0][value]': parent
    };

    return body;
  }

  Future<Map<String, dynamic>> getCourseByFieldBody(int categoryId, String fieldName) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getCoursesByField}',
      'field': fieldName,
      'value': categoryId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCourseParticipantsBody(int courseId) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getEnrolledParticipants}',
      'courseid': courseId
    };

    return body;
  }

  Future<Map<String, dynamic>> getCoursesEnrolled() async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getEnrolledUserCourses}',
      'userid': await super.getUserId()
    };

    return body;
  }

  Future<Map<String, dynamic>> getGrade() async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getGrade}',
      'userid': await super.getUserId()
    };

    return body;
  }
}