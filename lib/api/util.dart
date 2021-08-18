class APIUtil {
  //APIUtil({this.userToken});

  final String baseURL = "https://elearning.tdmu.edu.vn/webservice/rest/server.php?";
  final String _getCourseContent = "core_course_get_contents";
  final String _getCourseCategory = "core_course_get_categories";
  final String _getCoursesByField = "core_course_get_courses_by_field";
  final String _getEnrolledParticipants = "core_enrol_get_enrolled_users";
  final String userToken = "495b580580111a5a78850ed7c0b337ac";

  Map<String, dynamic> getCourseContentBody(int courseId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${this.userToken}',
      'wsfunction': '${this._getCourseContent}',
      'courseid': courseId
    };

    return body;
  }

  Map<String, dynamic> getCategoryBody() {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${this.userToken}',
      'wsfunction': '${this._getCourseCategory}',
    };

    return body;
  }

  Map<String, dynamic> getCourseByCategoryBody(int categoryId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${this.userToken}',
      'wsfunction': '${this._getCoursesByField}',
      'field': 'category',
      'value': categoryId
    };

    return body;
  }

  Map<String, dynamic> getCourseParticipantsBody(int courseId) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${this.userToken}',
      'wsfunction': '${this._getEnrolledParticipants}',
      'courseid': courseId
    };

    return body;
  }
}