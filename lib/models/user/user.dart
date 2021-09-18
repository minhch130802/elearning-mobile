import 'package:elearning_project/models/user/enrolled_course.dart';
import 'package:elearning_project/models/user/role.dart';

class User {
  User({this.id});

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
  List<Role>? roles;
  List<EnrolledCourse>? enrolledCourses;

  User.fromJSON(Map<String, dynamic> json) {
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

  List<EnrolledCourse> parseEnrolledCourseList(json) {
    List<EnrolledCourse> data = [];

    for(int i = 0; i < json.length; i++) {
      data.add(new EnrolledCourse.fromJSON(json[i]));
    }

    return data;
  }

  List<Role> parseRoleList(json) {
    List<Role> data = [];

    for(int i = 0; i < json.length; i++) {
      data.add(new Role.fromJSON(json[i]));
    }

    return data;
  }
}