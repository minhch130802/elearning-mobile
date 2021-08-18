import 'package:elearning_project/models/course/course_content_module.dart';
import 'package:elearning_project/models/course/course_module_completion_data.dart';
import 'package:elearning_project/themes/master.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class ModuleItems extends StatefulWidget {
  ModuleItems({required this.module});
  final CourseContentModule module;

  @override
  _ModuleItemsState createState() => _ModuleItemsState();
}

class _ModuleItemsState extends State<ModuleItems> {
  Map<String, Icon>? icons;

  @override
  void initState() {
    icons = {
      'resource': _icon(EvaIcons.fileOutline),
      'page': _icon(EvaIcons.fileTextOutline),
      'url': _icon(EvaIcons.link2Outline),
      'forum': _icon(EvaIcons.messageSquareOutline),
      'assign': _icon(EvaIcons.uploadOutline),
      'survey': _icon(EvaIcons.barChartOutline),
      'choice': _icon(EvaIcons.gridOutline),
      'feedback': _icon(EvaIcons.emailOutline),
      'quiz': _icon(EvaIcons.menu2Outline),
      'folder': _icon(EvaIcons.folderOutline),
      'attendance': _icon(EvaIcons.checkmarkSquareOutline)
    };

    super.initState();
  }

  Icon _icon(IconData data) {
    return Icon(
      data,
      color: Color(0xFF001E6C),
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.module.modName) {
      case 'label':
        {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Html(
              data: widget.module.description!,
              style: {
                'h1': Style(fontSize: FontSize(18)),
                'h2': Style(fontSize: FontSize(16)),
                'h4': Style(fontSize: FontSize(14)),
              },
            ),
          );
        }

      case 'resource':
      case 'page':
      case 'url':
      case 'forum':
      case 'assign':
      case 'survey':
      case 'choice':
      case 'feedback':
      case 'attendance':
      case 'quiz':
      case 'folder':
        {
          return generalModule(context, icons![widget.module.modName!],
              widget.module.name, widget.module.completionData);
        }

      default:
        {
          return Text("Still developer");
        }
    }
  }

  Widget generalModule(context, icon, name, CompletionData? completionData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 50,
          width: 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2)),
              color: completionData!.state == 1
                  ? MasterTheme().thirdColor
                  : MasterTheme().secondaryColor),
        ),
        Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: icon,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(name,
                        style: TextStyle(color: Color(0xFF001E6C)),
                        overflow: TextOverflow.ellipsis))
              ],
            ))
      ],
    );
  }
}
