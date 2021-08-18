import 'package:elearning_project/models/course/course_module_content.dart';
import 'package:elearning_project/themes/master.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FolderItem extends StatefulWidget {
  FolderItem({required this.content});
  final CourseModuleContent content;

  @override
  _FolderItemState createState() => _FolderItemState();
}

class _FolderItemState extends State<FolderItem> {
  bool showDes = false;
  bool isDowloading = false;
  bool isDone = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: MasterTheme().secondaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          GestureDetector(
            onTap: showDesFunc,
            child: Container(
              height: 40,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      "${widget.content.fileName}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: MasterTheme().primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isDowloading == false
                            ? Icon(
                                EvaIcons.downloadOutline,
                                size: 25,
                                color: MasterTheme().primaryColor,
                              )
                            : isDone == false
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: MasterTheme().primaryColor,
                                    )))
                                : Icon(
                                    EvaIcons.checkmark,
                                    size: 25,
                                    color: MasterTheme().primaryColor,
                                  ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: showDesFunc,
                          child: showDes == false
                              ? Icon(
                                  EvaIcons.infoOutline,
                                  size: 25,
                                  color: MasterTheme().primaryColor,
                                )
                              : Icon(EvaIcons.closeCircleOutline,
                                  size: 25, color: Colors.red[400]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: Container(
              child: Column(
                children: [
                  Divider(),
                  fileDetail(
                      "File size:", "${widget.content.fileSize}KB"),
                  Divider(),
                  fileDetail("Upload date:",
                      nullDateParse(widget.content.timeCreated)),
                  Divider(),
                  fileDetail("Last modified:",
                      nullDateParse(widget.content.timeModified)),
                  Divider(),
                  fileDetail("Author:", "${widget.content.author}"),
                ],
              ),
            ),
            secondChild: Container(),
            crossFadeState: showDes ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }

  void showDesFunc(){
    setState(() {
      showDes = !showDes;
    });
  }

  Widget fileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          Container(
              width: 90,
              margin: const EdgeInsets.only(right: 5),
              child: Text(title)),
          Container(
              width: MediaQuery.of(context).size.width - 150,
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                value,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: MasterTheme().primaryColor,
                    fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }

  String nullDateParse(DateTime? dateTime) {
    if (dateTime == null) {
      return "Unknown";
    }

    final f = new DateFormat('hh:mm dd/MM/yyyy');

    return f.format(dateTime).toString();
  }
}
