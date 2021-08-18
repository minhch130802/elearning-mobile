import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/models/course/course_content_module.dart';
import 'package:elearning_project/models/course/course_module_content.dart';
import 'package:elearning_project/pages/course/course_file_page.dart';
import 'package:elearning_project/pages/course/course_folder_page.dart';
import 'package:elearning_project/pages/general/under_develop_page.dart';
import 'package:elearning_project/widgets/module_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SectionItems extends StatelessWidget {
  SectionItems({required this.courseContent});
  final CourseContent courseContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${courseContent.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            child: Html(
              data: '${courseContent.summary}',
            ),
          ),

          for(int i = 0; i < courseContent.modules!.length; i++) 
            GestureDetector(
              onTap: (){
                viewModule(context, courseContent.modules![i]);
              },
              child: ModuleItems(module: courseContent.modules![i]),
            ),

          SizedBox(height: 10,),

          Divider(height: 2, thickness: 1, color: Colors.grey,)
        ],
      ),
    );
  }

  void viewModule(BuildContext context, CourseContentModule content){
    if(content.contents != null) {
      if(content.modName == 'resource'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseFilePage(content: content.contents![0])));
        return;
      }

      if(content.modName == 'folder'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseFolderPage(content: content.contents!)));
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => UnderDevelopingPage()));
    }
  }
}