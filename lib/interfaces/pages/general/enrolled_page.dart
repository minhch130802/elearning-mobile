import 'package:elearning_project/interfaces/themes/master.dart';
import 'package:elearning_project/interfaces/widgets/course_item.dart';
import 'package:elearning_project/interfaces/widgets/loading_indicator.dart';
import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/resources/api/api.dart';
import 'package:flutter/material.dart';

class EnrolledPage extends StatefulWidget {
  @override
  _EnrolledPageState createState() => _EnrolledPageState();
}

class _EnrolledPageState extends State<EnrolledPage> {
  List<Course> _courseList = [];
  bool _isLoading = true;
  CourseRestAPI _courseRestAPI = new CourseRestAPI();

  @override
  void initState() {
    _getEnrolledData();
    super.initState();
  }

  void _getEnrolledData() async {
    _courseList.clear();

    await _courseRestAPI.getEnrolledCourses().then((value) {
      _courseList.addAll(value);
      _courseList.sort((a, b) => a.courseName!.compareTo(b.courseName!));
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
        title: Text(
          "Courses Enrolled",
          style: TextStyle(
              color: MasterTheme().primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: _isLoading == true
              ? LoadingIndicator()
              : RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                  itemCount: _courseList.length,
                  itemBuilder: (context, index) => CourseItem(
                    course: _courseList[index],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
