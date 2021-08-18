import 'package:elearning_project/api/api.dart';
import 'package:elearning_project/models/course/course.dart';
import 'package:elearning_project/pages/course/course_content_page.dart';
import 'package:elearning_project/themes/master.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  CoursePage({required this.categoryId, required this.categoryName});
  final int categoryId;
  final String categoryName;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  CourseAPI _courseAPI = new CourseAPI();
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
          if (value[i].visible == 1) {
            _courseList.add(value[i]);
          }
        }
        print(_courseList.length);
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CourseContentPage(
                              courseId: _courseList[index].id!,
                              courseName: _courseList[index].displayName!)));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                                "${_courseValidName(_courseList[index].displayName!).toUpperCase()}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001E6C),
                                )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Text('Class: '),
                                  Text(
                                      "${_groupName(_courseList[index].displayName!)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),
                                      overflow: TextOverflow.ellipsis)
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Text("Teachers: "),
                          ),
                          for (int i = 0;
                              i < _courseList[index].contacts!.length;
                              i++)
                            Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "${_courseList[index].contacts![i].fullname}",
                                  style: TextStyle(
                                      color: Color(0xFF185ADB),
                                      fontWeight: FontWeight.w500),
                                )),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  String _courseValidName(String name) {
    var temp = name.split('_');
    if (temp.length == 4) {
      return temp[0] + ' | ' + temp[1];
    }

    return name;
  }

  String _groupName(String name) {
    var temp = name.split('_');
    if (temp.length == 4) {
      return temp[2];
    }

    return 'Update soon';
  }
}