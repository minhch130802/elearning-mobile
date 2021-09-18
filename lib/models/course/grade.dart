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

  GradeModel.fromJSON(Map<String, dynamic> json, String? name) {
    this.courseId = json['courseid'];
    this.courseName = name;
    this.grade = json['grade'];
    this.rawGrade = json['rawgrade'];
  }
}