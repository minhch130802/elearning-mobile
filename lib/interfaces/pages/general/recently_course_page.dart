import 'package:elearning_project/interfaces/widgets/course_item.dart';
import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/resources/api/core/course.dart';
import 'package:flutter/material.dart';

class RecentlyCoursePage extends StatefulWidget {
  @override
  _RecentlyCoursePageState createState() => _RecentlyCoursePageState();
}

class _RecentlyCoursePageState extends State<RecentlyCoursePage>
    with AutomaticKeepAliveClientMixin<RecentlyCoursePage> {
  List<Course> _courseList = [];
  bool _isLoading = true;
  CourseRestAPI _courseRestAPI = new CourseRestAPI();
  DateTime _currentDate = new DateTime.now();

  @override
  void initState() {
    _getEnrolledData();
    super.initState();
  }

  void _getEnrolledData() async {
    _courseList.clear();

    await _courseRestAPI.getEnrolledCourses().then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].lastAccess != null) {
          if (_currentDate.difference(value[i].lastAccess!).inDays < 14) {
            _courseList.add(value[i]);
          }
        }
      }

      _courseList.sort((a, b) => a.lastAccess!.compareTo(b.lastAccess!));
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
    _getEnrolledData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _courseList.length > 0
              ? RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    itemCount: _courseList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CourseItem(
                      course: _courseList[index],
                    ),
                  ),
              )
              : Center(
                  child: Text("You haven't access any course yet."),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
