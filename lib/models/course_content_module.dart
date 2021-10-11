import 'package:elearning_project/models/model.dart';

class CourseContentModuleModel {
  CourseContentModuleModel({
    this.id,
    this.name,
    this.instance,
    this.description,
    this.visible,
    this.userVisible,
    this.visibleOnCoursePage,
    this.modIcon,
    this.modName,
    this.modPlural,
    this.availability,
    this.indent,
    this.onClick,
    this.afterClick,
    this.customData,
    this.noViewLink,
    this.completion,
    this.completionData
  });

  int? id;
  String? name;
  int? instance;
  String? description;
  int? visible;
  bool? userVisible;
  int? visibleOnCoursePage;
  String? modIcon;
  String? modName;
  String? modPlural;
  String? availability;
  int? indent;
  String? onClick;
  String? afterClick;
  String? customData;
  bool? noViewLink;
  int? completion;
  CompletionData? completionData;
  List<CourseModuleContentModel>? contents;

  CourseContentModuleModel.fromJSON(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.instance = json['instance'];
    this.description = json['description'];
    this.visible = json['visible'];
    this.userVisible = json['uservisible'];
    this.visibleOnCoursePage = json['visibleoncoursepage'];
    this.modIcon = json['modicon'];
    this.modName = json['modname'];
    this.modPlural = json['modplural'];
    this.availability = json['availability'];
    this.indent = json['indent'];
    this.onClick = json['onclick'];
    this.afterClick = json['afterclick'];
    this.customData = json['customdata'];
    this.noViewLink = json['noviewlink'];
    this.completion = json['completion'];
    this.completionData = json['completiondata'] != null ? CompletionData.fromJSON(json['completiondata']) : CompletionData(state: 0);
    this.contents = json['contents'] != null ? parseModuleContentList(json['contents']) : [];
  }

  List<CourseModuleContentModel> parseModuleContentList(json) {
    List<CourseModuleContentModel> data = [];

    for(int i = 0; i < json.length; i++) {
      data.add(new CourseModuleContentModel.fromJSON(json[i]));
    }

    return data;
  }
}