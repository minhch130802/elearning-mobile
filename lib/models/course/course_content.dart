import 'course_content_module.dart';

class CourseContent {
  CourseContent({
    required this.id,
    required this.name,
    required this.visible,
    required this.summary,
    required this.summaryFormat,
    required this.section,
    required this.hiddenByNumSections,
    required this.userVisible,
    this.modules
  });

  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryFormat;
  int? section;
  int? hiddenByNumSections;
  bool? userVisible;
  List<CourseContentModule>? modules;

  CourseContent.fromJSON(Map<dynamic, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.visible = json['visible'];
    this.summary = json['summary'];
    this.summaryFormat = json['summaryformat'];
    this.section = json['section'];
    this.hiddenByNumSections = json['hiddenbynumsections'];
    this.userVisible = json['uservisible'];
    this.modules = parse(json['modules']);
  }

  Map<dynamic, dynamic> toJSON(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['visible'] = this.visible;
    data['summary'] = this.summary;
    data['summaryformat'] = this.summaryFormat;
    data['section'] = this.section;
    data['hiddenbynumsections'] = this.hiddenByNumSections;
    data['uservisible'] = this.userVisible;
    data['modules'] = this.modules;

    return data;
  }

  List<CourseContentModule> parse(List<dynamic> data){
    List<CourseContentModule> parseData = [];

    for(int i = 0; i < data.length; i++){
      CourseContentModule courseContentModule = new CourseContentModule.fromJSON(data[i]);
      parseData.add(courseContentModule);
    }

    return parseData;
  }
}