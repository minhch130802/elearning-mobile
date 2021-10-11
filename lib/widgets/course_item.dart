import 'package:elearning_project/screens/course/course_content_page.dart';
import 'package:elearning_project/models/course.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CourseItem extends StatelessWidget {
  CourseItem({required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseContentPage(
                  courseId: course.id!,
                  courseName: course.courseName!,
                  courseDescription: course.summary!,
                  teacherName: course.teacherName!,
                )));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("${course.courseName}".toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  )),
            ),
            Divider(),
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Text('Code/ID: '),
                    Text("${course.courseCode}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis)
                  ],
                )),

            Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Text('Class: '),
                    Text("${course.courseClass}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis)
                  ],
                )),

            Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Text('Last access: '),
                    Text( course.lastAccess != null
                        ? "${Jiffy(course.lastAccess!).fromNow()}"
                        : 'Never',
                        style: TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis)
                  ],
                )),

            course.teacherName!.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text("Teachers: "),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: course.teacherName!.length,
                        itemBuilder: (context, i) => Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              "${course.teacherName![i]}",
                              style: TextStyle(
                                  color: Color(0xFF185ADB),
                                  fontWeight: FontWeight.w500),
                            )),
                      )
                    ],
                  )
                : Container(margin: const EdgeInsets.only(bottom: 5)),
          ],
        ),
      ),
    );
  }
}
