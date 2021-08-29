class EnrolModel {
  EnrolModel({
    this.id,
    this.courseId,
    this.type,
    this.name,
    this.status,
    this.enrolPassword
  });

  int? id;
  int? courseId;
  String? type;
  String? name;
  bool? status;
  bool? enrolPassword;

  EnrolModel.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.courseId = json['courseid'];
    this.type = json['type'];
    this.name = json['name'];
    this.status = json['status'];
    this.enrolPassword = json['enrolpassword'] != null ? true : false;
  }
}