import 'course_contact.dart';

class Course {

  int? id;
  String? courseCode; //Custom field (this is not a key in json response)
  String? courseName; //Custom field (this is not a key in json response)
  String? courseClass; //Custom field (this is not a key in json response)
  List<String>? teacherName; //Custom field (this is not a key in json response)
  bool isCourse = true;
  String? fullName;
  String? displayName;
  String? shortName;
  int? categoryId;
  String? categoryName;
  int? sortOrder;
  String? summary;
  int? summaryFormat;
  List<dynamic>? summaryFiles;
  List<dynamic>? overviewFiles;
  List<CourseContact>? contacts;
  List<dynamic>? enrollmentMethods;
  String? idNumber;
  String? format;
  dynamic showGrades;
  int? newsItems;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? lastAccess;
  int? maxBytes;
  int? showReports;
  int? visible;
  int? groupMode;
  int? groupModeForce;
  int? defaultGroupingId;
  int? enableCompletion;
  int? completionNotify;
  String? lang;
  String? theme;
  int? marker;
  int? legacyFiles;
  String? calendarType;
  DateTime? timeCreated;
  DateTime? timeModified;
  int? requested;
  int? cacheRev;
  
  Course.fromJSON(Map<String, dynamic> json){
    this.id = json['id'];
    this.fullName = json['fullname'];
    this.displayName = json['displayname'];
    this.shortName = json['shortname'];
    this.categoryId = json['categoryid'];
    this.categoryName = json['categoryname'];
    this.sortOrder = json['sortorder'];
    this.summary = json['summary'];
    this.summaryFormat = json['summaryformat'];
    this.summaryFiles = json['summaryfiles'];
    this.overviewFiles = json['overviewfiles'];
    this.contacts = json['contacts'] != null ? parseContactList(json['contacts']) : null;
    this.enrollmentMethods = json['enrollmentmethods'];
    this.idNumber = json['idnumber'];
    this.format = json['format'];
    this.showGrades = json['showgrades'];
    this.newsItems = json['newsitems'];
    this.startDate = json['startdate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['startdate'] * 1000) : null;
    this.endDate = json['enddate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['enddate'] * 1000) : null;
    this.lastAccess = json['lastaccess'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastaccess'] * 1000) : null;
    this.visible = json['visible'];

    //Set value for custom field
    this.courseCode = splitCourseFullName(json['fullname'])[0];
    this.courseName = splitCourseFullName(json['fullname'])[1];
    this.courseClass = splitCourseFullName(json['fullname'])[2];
    this.teacherName = this.contacts != null ? teacherList(this.contacts!) : [];
  }

  List<CourseContact> parseContactList(data) {
    List<CourseContact> value = [];

    for(int i = 0; i < data.length; i++){
      CourseContact courseContact = new CourseContact.fromJSON(data[i]);
      value.add(courseContact);
    }
    
    return value;
  }

  List<String> splitCourseFullName(String fullName) {
    var temp = fullName.split('_');
    List<String> namePart = [];

    if (temp.length == 4) {
      namePart.addAll(temp);
    } else {
      namePart.addAll([fullName, 'Update soon', 'Update soon', 'Update soon']);
    }

    return namePart;
  }

  List<String> teacherList(List<CourseContact> data) {
    List<String> resultData = [];

    for(int i = 0; i < data.length; i++) {
      resultData.add(data[i].fullname!);
    }

    return resultData;
  }
}