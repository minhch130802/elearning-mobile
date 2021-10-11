import 'package:elearning_project/bloc/course_bloc.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/widgets/category_item.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'course_page.dart';

class CourseCategoryPage extends StatefulWidget {
  CourseCategoryPage({required this.id, required this.name});
  final int id;
  final String name;

  @override
  _CourseCategoryPageState createState() => _CourseCategoryPageState();
}

class _CourseCategoryPageState extends State<CourseCategoryPage> {
  final CourseBloc _courseBloc = CourseBloc();
  List<int> _history = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    _history.clear();
    print(widget.id);
    _courseBloc.add(
        GetCourseCategoryList(widget.id, '${widget.name}'));
    _history.add(widget.id);
  }

  void getNextPage(int id, String name) {
    _courseBloc.add(GetCourseCategoryList(id, '$name'));
    _history.add(id);
  }

  @override
  void dispose() {
    _history.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      _history.removeLast();

      if (_history.length == 0) {
        return true;
      } else {
        _courseBloc.add(GetCourseCategoryList(_history[_history.length - 1], ''));
        return false;
      }
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar:AppBar(
          title: Text(
            'Course categories',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: AppColors.secondaryColor,
        body: SafeArea(
          child: BlocProvider(
            create: (_) => _courseBloc,
            child: BlocListener<CourseBloc, CourseState>(
              listener: (context, state) {
                if (state is CourseError) {
                  Fluttertoast.showToast(msg: state.message);
                }

                if (state is CourseNavigate) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (route) => CoursePage(
                        categoryId: state.id,
                        categoryName: state.name,
                      )));
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

                    if (state is CourseCategoriesLoaded) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: RefreshIndicator(
                              onRefresh: () async {
                                loadData();
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        getNextPage(state.data[index].id,
                                            state.data[index].name);
                                      },
                                      child: CategoryItem(
                                        category: state.data[index],
                                      ));
                                },
                              )));
                    }

                    if(state is CourseNavigate) {
                      _onWillPop();
                    }
                    return Container();
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
