import 'package:elearning_project/models/model.dart';

class UserModel {
  UserModel({this.id});

  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? fullName;
  String? email;
  String? department;
  String? idNumber;
  DateTime? firstAccess;
  DateTime? lastAccess;
  DateTime? lastCourseAccess;
  String? description;
  int? descriptionFormat;
  String? city;
  String? country;
  String? profileImageUrlSmall;
  String? profileImageUrl;
  List<dynamic>? groups;
  List<RoleModel>? roles;
  List<EnrolledCourseModel>? enrolledCourses;

  UserModel.fromJSON(Map<String, dynamic> json) {
    this.id = json['id'];
    this.username = json['username'];
    this.firstname = json['firstname'];
    this.lastname = json['lastname'];
    this.fullName = json['fullname'];
    this.email = json['email'];
    this.department = json['department'];
    this.idNumber = json['idnumber'];
    this.firstAccess = json['firstaccess'] != null ? DateTime.fromMillisecondsSinceEpoch(json['firstaccess'] * 1000) : null;
    this.lastAccess = json['lastaccess'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastaccess'] * 1000) : null;
    this.lastCourseAccess = json['lastcourseaccess'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastcourseaccess'] * 1000) : null;
    this.description = json['description'];
    this.descriptionFormat = json['descriptionformat'];
    this.city = json['city'];
    this.country = json['country'];
    this.profileImageUrlSmall = json['profileimageurlsmall'];
    this.profileImageUrl = json['profileimageurl'];
    this.groups = json['groups'];
    this.roles = json['roles'] != null ? parseRoleList(json['roles']) : [];
    this.enrolledCourses = json['enrolledcourses'] != null ? parseEnrolledCourseList(json['enrolledcourses']) : [];

  }

  List<EnrolledCourseModel> parseEnrolledCourseList(json) {
    List<EnrolledCourseModel> data = [];

    for(int i = 0; i < json.length; i++) {
      data.add(new EnrolledCourseModel.fromJSON(json[i]));
    }

    return data;
  }

  List<RoleModel> parseRoleList(json) {
    List<RoleModel> data = [];

    for(int i = 0; i < json.length; i++) {
      data.add(new RoleModel.fromJSON(json[i]));
    }

    return data;
  }
}