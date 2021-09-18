import 'package:elearning_project/interfaces/widgets/course_item.dart';

import '/resources/api/api.dart';
import 'package:elearning_project/models/course/course.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  CoursePage({required this.categoryId, required this.categoryName});
  final int categoryId;
  final String categoryName;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  CourseRestAPI _courseAPI = new CourseRestAPI();
  List<Course> _courseList = [];
  bool _isLoading = true;

  @override
  void initState() {
    _getAllCourseByCategory();
    super.initState();
  }

  void _getAllCourseByCategory() {
    _courseAPI.getCourseByCategory(widget.categoryId).then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          _courseList.add(value[i]);
        }
        _courseList.sort((a, b) => a.sortOrder!.compareTo(b.sortOrder!));
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.categoryName}",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: _isLoading
            ? Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Loading...")
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _courseList.length,
                itemBuilder: (context, index) {
                  return CourseItem(
                    course: _courseList[index],
                  );
                },
              ),
      ),
    );
  }
}
