class EnrolledCourseModel {
  EnrolledCourseModel({this.id, this.fullName, this.shortName});

  int? id;
  String? fullName;
  String? shortName;

  EnrolledCourseModel.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.fullName = json['fullname'];
    this.shortName = json['shortname'];
  }
}