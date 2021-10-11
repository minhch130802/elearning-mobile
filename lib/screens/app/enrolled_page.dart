import 'package:elearning_project/providers/course.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/widgets/course_item.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:elearning_project/models/model.dart';
import 'package:flutter/material.dart';

class EnrolledPage extends StatefulWidget {
  @override
  _EnrolledPageState createState() => _EnrolledPageState();
}

class _EnrolledPageState extends State<EnrolledPage> {
  List<CourseModel> _courseList = [];
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
      backgroundColor: Color(0xFFF6F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
        title: Text(
          "Courses Enrolled",
          style: TextStyle(
              color: AppColors.primaryColor,
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
