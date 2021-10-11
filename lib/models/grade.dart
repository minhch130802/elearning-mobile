class GradeModel {
  GradeModel({
    this.courseId,
    this.courseName,
    this.grade,
    this.rawGrade
  });

  int? courseId;
  String? courseName;
  String? grade;
  String? rawGrade;

  GradeModel.fromJSON(Map<String, dynamic> json, String name) {
    this.courseId = json['courseid'];
    this.courseName = splitCourseFullName(name);
    this.grade = json['grade'];
    this.rawGrade = json['rawgrade'];
  }

  String splitCourseFullName(String fullName) {
    var temp = fullName.split('_');

    if (temp.length == 4) {
      return temp[1];
    }

    return fullName;
  }
}