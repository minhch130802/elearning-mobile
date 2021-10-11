import 'model.dart';


/// A object class to store and manage course content
/// that base on Moodle [CourseModel] Class.
class CourseModel {
  /// Create class based on [CourseModel] class of Moodle source code
  ///
  /// The [courseCode], [courseName], [courseClass], [teacherName],
  /// [contacts] arguments are the custom variable that is not visible in the
  /// response data from Restful API. Moreover, the [isCourse] argument
  /// define the return value as the [CourseModel] to serve the interfaces
  /// that need to distinguish between classes.
  ///
  /// The [id], [fullName], [displayName], [shortName], [categoryId],
  /// [categoryName], [sortOrder], [summary], [summaryFormat], [summaryFiles],
  /// [overviewFiles], [enrollmentMethods], [idNumber], [format], [showGrades],
  /// [newsItems], [startDate], [endDate], [lastAccess], and so on are the
  /// response arguments.

  /// The [CourseModel] id
  int? id;

  /// The course's code that get from the [displayName]
  String? courseCode; //Custom field (this is not a key in json response)

  /// The course's name that get from the [displayName]
  String? courseName; //Custom field (this is not a key in json response)

  /// The course's class that get from the [displayName]
  String? courseClass; //Custom field (this is not a key in json response)

  /// The course's teachers that get from the [contacts]
  List<String>? teacherName; //Custom field (this is not a key in json response)

  /// Determine this is a course content
  bool isCourse = true;

  /// Course's full name for the administrators or teachers role
  String? fullName;

  /// Course's display name to view on the course information
  String? displayName;

  /// Short name for search or manage course in admin site
  String? shortName;

  /// Category id of the course
  int? categoryId;

  /// Category name of the course
  String? categoryName;

  /// Priority order of courses in the list
  int? sortOrder;

  /// The short description of the course
  String? summary;

  /// The format of the summary
  /// [1] is:
  /// [2] is:
  int? summaryFormat;

  /// The included files in the summary, this will not
  /// display in the mobile application.
  List<dynamic>? summaryFiles;

  /// The overview files was displayed in the course card in web version
  /// and that will not display in the mobile application.
  List<dynamic>? overviewFiles;

  /// This will content all information of the teachers in the course.
  /// [CourseContactModel] object will save that information.
  List<CourseContactModel>? contacts;

  /// The available enrollment methods of this course.
  /// The default method is self_enroll (without password) and
  /// self_enroll (with password).
  List<dynamic>? enrollmentMethods;

  /// This is difference with the course id, [idNumber] is the global
  /// id of the instance.
  String? idNumber;

  /// Course format
  String? format;

  /// To show grade for student
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
  
  CourseModel.fromJSON(Map<String, dynamic> json){
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
    this.courseCode = splitCourseFullName(json['fullname'], this.id)[0];
    this.courseName = splitCourseFullName(json['fullname'], this.id)[1];
    this.courseClass = splitCourseFullName(json['fullname'], this.id)[2];
    this.teacherName = this.contacts != null ? teacherList(this.contacts!) : [];
  }

  List<CourseContactModel> parseContactList(data) {
    List<CourseContactModel> value = [];

    for(int i = 0; i < data.length; i++){
      CourseContactModel courseContact = new CourseContactModel.fromJSON(data[i]);
      value.add(courseContact);
    }
    
    return value;
  }

  List<String> splitCourseFullName(String fullName, int? id) {
    var temp = fullName.split('_');
    List<String> namePart = [];

    if (temp.length == 4) {
      namePart.addAll(temp);
    } else {
      var temp2 = fullName.split('-');

      if (temp2.length == 4) {
        namePart.addAll(temp2);
      } else {
        namePart.addAll(['$id', fullName, 'Update soon', 'Update soon']);
      }
    }

    return namePart;
  }

  List<String> teacherList(List<CourseContactModel> data) {
    List<String> resultData = [];

    for(int i = 0; i < data.length; i++) {
      resultData.add(data[i].fullName!);
    }

    return resultData;
  }
}