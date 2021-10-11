import 'package:elearning_project/utilities/app_colors.dart';

import '../models/course_content_module.dart';
import 'package:elearning_project/models/model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class ModuleItems extends StatefulWidget {
  ModuleItems({required this.module});
  final CourseContentModuleModel module;

  @override
  _ModuleItemsState createState() => _ModuleItemsState();
}

class _ModuleItemsState extends State<ModuleItems> {
  Map<String, Icon>? icons;
  bool isChecked = false;

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
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.primaryColor;
      }
      return AppColors.primaryColor;
    }

    if (widget.module.modName == 'label') {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Html(
          data: widget.module.description!,
          style: {
            'h1': Style(fontSize: FontSize(18)),
            'h2': Style(fontSize: FontSize(16)),
            'h4': Style(fontSize: FontSize(14)),
          },
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width - 30,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                //color: Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: icons![widget.module.modName]
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text('${widget.module.name}',
                          style: TextStyle(color: Color(0xFF001E6C)),
                          overflow: TextOverflow.ellipsis)),
                  Spacer(),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: widget.module.completionData!.state == 0 ? false : true,
                    onChanged: (bool? value) {

                    },
                  ),
                ],
              ))
        ],
      );
    }
  }
}
