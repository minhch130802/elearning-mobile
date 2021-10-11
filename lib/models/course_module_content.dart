
class CourseModuleContentModel {
  CourseModuleContentModel({
    this.type,
    this.fileName,
    this.filePath,
    this.fileSize,
    this.fileUrl,
    this.timeCreated,
    this.timeModified,
    this.sortOrder,
    this.mimeType,
    this.isExternalFile,
    this.repositoryType,
    this.userId,
    this.author,
    this.license
  });

  String? type;
  String? fileName;
  String? filePath;
  int? fileSize;
  String? fileUrl;
  DateTime? timeCreated;
  DateTime? timeModified;
  int? sortOrder;
  String? mimeType;
  bool? isExternalFile;
  String? repositoryType;
  int? userId;
  String? author;
  String? license;

  CourseModuleContentModel.fromJSON(Map<String, dynamic> json) {
    this.type = json['type'];
    this.fileName = json['filename'];
    this.filePath = json['filepath'];
    this.fileSize = json['filesize'];
    this.fileUrl = json['fileurl'];
    this.timeCreated = json['timecreated'] != null ? DateTime.fromMillisecondsSinceEpoch(json['timecreated'] * 1000) : null;
    this.timeModified = json['timemodified'] != null ? DateTime.fromMillisecondsSinceEpoch(json['timemodified'] * 1000) : null;
    this.sortOrder = json['sortorder'];
    this.mimeType = json['mimetype'];
    this.isExternalFile = json['isexternalfile'];
    this.repositoryType = json['respositorytype'];
    this.userId = json['userid'];
    this.author = json['author'];
    this.license = json['license'];
  }

}