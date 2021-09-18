class CourseCategory {
  CourseCategory({
    required this.id,
    this.name,
    this.idNumber,
    this.description,
    this.descriptionFormat,
    this.parent, 
    this.sortOrder,
    this.courseCount,
    this.visible,
    this.visibleOld,
    this.timeModified,
    this.depth,
    this.path,
    this.theme
  });

  late int id;
  String? name;
  String? idNumber;
  String? description;
  bool isCourse = false;
  int? descriptionFormat;
  int? parent;
  int? sortOrder;
  int? courseCount;
  int? visible;
  int? visibleOld;
  DateTime? timeModified;
  int? depth;
  String? path;
  String? theme;

  CourseCategory.fromJSON(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.idNumber = json['idnumber'];
    this.description = json['description'];
    this.descriptionFormat = json['descriptionformat'];
    this.parent = json['parent'];
    this.sortOrder = json['sortorder'];
    this.courseCount = json['coursecount'];
    this.visible = json['visible'];
    this.visibleOld = json['visibleold'];
    this.timeModified = json['timemodified'] != null ? DateTime.fromMillisecondsSinceEpoch(json['timemodified'] * 1000) : null;
    this.depth = json['depth'];
    this.path = json['path'];
    this.theme = json['theme'];
  }
}