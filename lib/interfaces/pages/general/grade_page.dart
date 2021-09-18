import 'package:elearning_project/interfaces/themes/master.dart';
import 'package:elearning_project/interfaces/widgets/course_item.dart';
import 'package:elearning_project/interfaces/widgets/loading_indicator.dart';
import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/models/course/grade.dart';
import 'package:elearning_project/resources/api/core/course.dart';
import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage>
    with AutomaticKeepAliveClientMixin<GradePage> {
  List<GradeModel?> _gradeList = [];
  bool _isLoading = true;
  CourseRestAPI _courseRestAPI = new CourseRestAPI();

  @override
  void initState() {
    _getGradeData();
    super.initState();
  }

  void _getGradeData() async {
    _gradeList.clear();

    await _courseRestAPI.getUserGrade().then((value) {
      _gradeList.addAll(value);
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _isLoading = true;
    });
    _getGradeData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: _isLoading == true
          ? LoadingIndicator()
          : _gradeList.length > 0
              ? RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    itemCount: _gradeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: MasterTheme().secondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 1.5,
                              child: Text(
                                "${_gradeList[index]!.courseName}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${_gradeList[index]!.grade}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: MasterTheme().primaryColor),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
              : Center(
                  child: Text("You haven't access any course yet."),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
