class CourseContactModel {
  CourseContactModel({this.id, this.fullName});
  
  int? id;
  String? fullName;

  CourseContactModel.fromJSON(Map<String, dynamic> json){
    this.id = json['id'];
    this.fullName = json['fullname'];
  }
}