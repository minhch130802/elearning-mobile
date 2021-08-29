import 'package:elearning_project/api/api.dart';
import 'package:elearning_project/models/course/course_content.dart';
import 'package:elearning_project/pages/course/course_enroll_page.dart';
import 'package:elearning_project/pages/course/course_enrolled_participants_page.dart';
import 'package:elearning_project/themes/master.dart';
import 'package:elearning_project/widgets/bottom_sheet_items.dart';
import 'package:elearning_project/widgets/section_items.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseContentPage extends StatefulWidget {
  CourseContentPage(
      {required this.courseId,
      required this.courseName,
      required this.teacherName,
      required this.courseDescription});
  final int courseId;
  final String courseName;
  final List<String> teacherName;
  final String courseDescription;

  @override
  _CourseContentPageState createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  CourseRestAPI _contentAPI = new CourseRestAPI();
  List<CourseContent> _courseContentList = [];
  bool _isLoading = true;

  @override
  void initState() {
    _getCourseContent();
    super.initState();
  }

  @override
  void dispose() {
    _courseContentList.clear();
    super.dispose();
  }

  void _getCourseContent() {
    _isLoading = true;
    if (_courseContentList.length > 0) _courseContentList.clear();

    _contentAPI.getCourseContent(widget.courseId).then((value) {
      if (value != []) {
        setState(() {
          _courseContentList.addAll(value);
        });
      }
    }).whenComplete(() {
      _isLoading = !_isLoading;
    }).catchError((error) {
      if (error == 'errorcoursecontextnotvalid') {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (route) => CourseEnrollPage(
                      courseId: widget.courseId,
                      courseName: widget.courseName,
                      courseDescription: widget.courseDescription,
                      teacherName: widget.teacherName,
                    )))
            .then((value) {
          if (value == true) {
            _getCourseContent();
          }
        });
      }
    });
  }

  void onMenuTap() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  BottomSheetItems(
                    name: "Students",
                    icon: EvaIcons.personOutline,
                    function: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CourseEnrolledParticipantsPage(
                                courseId: widget.courseId,
                              )));
                    },
                  ),
                  BottomSheetItems(
                    name: "Badges",
                    icon: EvaIcons.shieldOutline,
                  ),
                  BottomSheetItems(
                    name: "Competencies",
                    icon: EvaIcons.checkmarkSquare2Outline,
                  ),
                  BottomSheetItems(
                    name: "Grades",
                    icon: EvaIcons.keypadOutline,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.courseName,
              style: TextStyle(color: Colors.black, fontSize: 16),
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: onMenuTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  EvaIcons.menuOutline,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: _isLoading
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: MasterTheme().primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Loading...",
                        style: TextStyle(
                            color: MasterTheme().primaryColor, fontSize: 16),
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: _courseContentList.length,
                    itemBuilder: (context, index) =>
                        SectionItems(courseContent: _courseContentList[index]),
                  ),
                ),
        ));
  }

  Future<void> _onRefresh() async {
    _getCourseContent();
  }
}
