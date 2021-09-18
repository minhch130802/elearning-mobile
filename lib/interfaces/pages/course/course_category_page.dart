import 'package:elearning_project/interfaces/widgets/category_item.dart';
import 'package:elearning_project/models/course/course_category.dart';
import 'package:elearning_project/resources/api/core/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'course_page.dart';

class CourseCategoryPage extends StatefulWidget {
  CourseCategoryPage({required this.category});
  final CourseCategory category;

  @override
  _CourseCategoryPageState createState() => _CourseCategoryPageState();
}

class _CourseCategoryPageState extends State<CourseCategoryPage> {
  CourseRestAPI _courseCategoryAPI = new CourseRestAPI();
  List<CourseCategory> _courseCategory = [];
  List<CourseCategory> _categoryList = [];
  List<int> _clickHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    _getCourseCategories();
    super.initState();
  }

  void _getCourseCategories() {
    setState(() {
      _isLoading = true;
    });

    _courseCategoryAPI.getCourseCategory(widget.category.id).then((value) {
      if (value != []) {
        for(int i = 1; i < value.length; i++) {
          _categoryList.add(value[i]);
        }
        _categoryList.sort((a,b) => a.sortOrder!.compareTo(b.sortOrder!));
      }
    }).whenComplete(() {
      _getCourseCategoryByParent(widget.category.id, 'root');
    });
  }

  @override
  void dispose() {
    _clickHistory.clear();
    _categoryList.clear();
    _courseCategory.clear();
    super.dispose();
  }

  void _getCourseCategoryByParent(int parent, String name) {
    List<CourseCategory> temp = [];

    for (int i = 0; i < _categoryList.length; i++) {
      if (_categoryList[i].parent == parent) {
        temp.add(_categoryList[i]);
      }
    }

    print(temp.length);

    if (temp.length == 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CoursePage(categoryId: parent, categoryName: name)));
    } else {
      if(_clickHistory.length > 0) {
        if(_clickHistory[_clickHistory.length - 1] != parent){
          _clickHistory.add(parent);
        }
      } else {
        _clickHistory.add(parent);
      }

      _courseCategory.clear();
      _courseCategory.addAll(temp);
    }


    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      _clickHistory.removeLast();

      if(_clickHistory.length == 0) {
        return true;
      } else {
        _getCourseCategoryByParent(_clickHistory[_clickHistory.length - 1],'back');
        return false;
      }
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Course categories",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
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
                : Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    itemCount: _courseCategory.length,
                    itemBuilder: (context, index) {
                      return _courseCategory[index].name != ""
                          ? GestureDetector(
                          onTap: () {
                            _getCourseCategoryByParent(
                                _courseCategory[index].id,
                                _courseCategory[index].name!);
                          },
                          child: CategoryItem(category: _courseCategory[index],))
                          : Container(
                        height: 45,
                        width: double.infinity,
                      );
                    },
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    _categoryList.clear();
    _courseCategory.clear();
    _getCourseCategories();
  }
}