import 'course_contact.dart';

class Course {

  int? id;
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
  int? showGrades;
  int? newsItems;
  DateTime? startDate;
  DateTime? endDate;
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
    this.contacts = parseContactList(json['contacts']);
    this.enrollmentMethods = json['enrollmentmethods'];
    this.idNumber = json['idnumber'];
    this.format = json['format'];
    this.showGrades = json['showgrades'];
    this.newsItems = json['newsitems'];
    this.startDate = DateTime.fromMillisecondsSinceEpoch(json['startdate'] * 1000);
    this.endDate = DateTime.fromMillisecondsSinceEpoch(json['enddate'] * 1000);
    this.visible = json['visible'];
  }

  List<CourseContact> parseContactList(data) {
    List<CourseContact> value = [];

    for(int i = 0; i < data.length; i++){
      CourseContact courseContact = new CourseContact.fromJSON(data[i]);
      value.add(courseContact);
    }
    
    return value;
  }
}