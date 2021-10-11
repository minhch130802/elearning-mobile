import 'package:elearning_project/bloc/course_bloc.dart';
import 'package:elearning_project/providers/course.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'course_enroll_page.dart';
import 'course_enrolled_participants_page.dart';
import '../../widgets/bottom_sheet_items.dart';
import '../../widgets/section_items.dart';
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
  final CourseBloc _courseBloc = CourseBloc();

  @override
  void initState() {
    _courseBloc.add(GetCourseContent(widget.courseId));
    super.initState();
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
                    name: "Participants",
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
                    name: "Grade",
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
          title: Text(widget.courseName.toUpperCase(),
              style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          elevation: 0,
          actions: [
            InkWell(
              onTap: onMenuTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  EvaIcons.menuOutline,
                  color: AppColors.primaryColor,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        body: BlocProvider(
            create: (_) => _courseBloc,
            child: BlocListener<CourseBloc, CourseState>(
              listener: (context, state) async {
                if (state is CourseError) {
                  Fluttertoast.showToast(msg: state.message);
                }

                if(state is CourseEnrolled) {
                  if(state.enrolled == true) {
                    _courseBloc.add(GetCourseContent(widget.courseId));
                  } else {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (route) => CourseEnrollPage(
                          courseId: widget.courseId,
                          courseName: widget.courseName,
                          courseDescription: widget.courseDescription,
                          teacherName: widget.teacherName,
                        ))).then((value){
                          if(value == null){
                            Navigator.pop(context);
                          } else {
                            _courseBloc.add(SetCourseEnrolled(true));
                          }
                    });
                  }
                }
              },
              child: BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                    if (state is CourseInitial) {
                      return LoadingIndicator();
                    }

                    if (state is CourseLoading) {
                      return LoadingIndicator();
                    }

                    if (state is CourseContentLoaded) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.separated(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) =>
                              SectionItems(courseContent: state.data[index]),
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Divider(
                                  height: 1,
                                  color: AppColors.primaryColor
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return Container();
                  }
              ),
            )
        ),);
  }

  Future<void> _onRefresh() async {
    _courseBloc.add(GetCourseContent(widget.courseId));
  }
}