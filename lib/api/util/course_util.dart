import 'util.dart';

class CourseUtil extends GlobalUtil {
  final String _getCourseContent = "core_course_get_contents";
  final String _getCourseCategory = "core_course_get_categories";
  final String _getCoursesByField = "core_course_get_courses_by_field";
  final String _getEnrolledParticipants = "core_enrol_get_enrolled_users";

  Map<String, dynamic> getCourseContentBody(int courseId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getCourseContent}',
      'courseid': courseId
    };

    return body;
  }

  Map<String, dynamic> getCategoryBody() {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getCourseCategory}',
    };

    return body;
  }

  Map<String, dynamic> getCourseByCategoryBody(int categoryId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getCoursesByField}',
      'field': 'category',
      'value': categoryId
    };

    return body;
  }

  Map<String, dynamic> getCourseParticipantsBody(int courseId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${super.userToken}',
      'wsfunction': '${this._getEnrolledParticipants}',
      'courseid': courseId
    };

    return body;
  }
}