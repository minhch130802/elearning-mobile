class CourseContact {
  CourseContact({this.id, this.fullname});
  
  int? id;
  String? fullname;

  CourseContact.fromJSON(Map<String, dynamic> json){
    this.id = json['id'];
    this.fullname = json['fullname'];
  }
}