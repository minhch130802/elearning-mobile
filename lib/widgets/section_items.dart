import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/screens/course/course_url_page.dart';
import '../models/course_content_module.dart';
import '../screens/course/course_file_page.dart';
import '../screens/course/course_folder_page.dart';
import '../screens/app/under_develop_page.dart';
import 'module_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SectionItems extends StatelessWidget {
  SectionItems({required this.courseContent});
  final CourseContentModel courseContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${courseContent.name}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Html(
              data: '${courseContent.summary}',
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courseContent.modules!.length,
            itemBuilder: (context, i) => InkWell(
              onTap: () {
                viewModule(context, courseContent.modules![i]);
              },
              child: ModuleItems(module: courseContent.modules![i]),
            ),
          ),
        ],
      ),
    );
  }

  void viewModule(BuildContext context, CourseContentModuleModel content) {
    if (content.contents != null) {
      if (content.modName == 'resource') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CourseFilePage(content: content.contents![0])));
        return;
      }

      if (content.modName == 'folder') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CourseFolderPage(content: content.contents!)));
        return;
      }

      if (content.modName == 'url') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CourseUrlPage(name: content.name!, url: content.contents![0].fileUrl!)));
        return;
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UnderDevelopingPage()));
    }
  }
}
