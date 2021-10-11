import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import '../../widgets/folder_items.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseFolderPage extends StatefulWidget {
  CourseFolderPage({required this.content});
  final List<CourseModuleContentModel> content;
  @override
  _CourseFolderPageState createState() => _CourseFolderPageState();
}

class _CourseFolderPageState extends State<CourseFolderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Folder content",
            style: TextStyle(color: Colors.black, fontSize: 16),
            overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Included: ${widget.content.length} file(s)",
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        child: Text(
                      "Download all files",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Icon(EvaIcons.infoOutline)),
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        "You only can download 5 files in one time!",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.content.length,
                itemBuilder: (context, index) =>
                    FolderItem(content: widget.content[index]),
              ),
            )
          ],
        ),
      ),
    );
  }


}
