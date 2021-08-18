class CourseCategory {
  CourseCategory({
    this.id,
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

  int? id;
  String? name;
  String? idNumber;
  String? description;
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
    this.timeModified = DateTime.fromMillisecondsSinceEpoch(json['timemodified'] * 1000);
    this.depth = json['depth'];
    this.path = json['path'];
    this.theme = json['theme'];
  }
}