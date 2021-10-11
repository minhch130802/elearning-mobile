import 'package:elearning_project/bloc/course_bloc.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/widgets/course_item.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoursePage extends StatefulWidget {
  CoursePage({required this.categoryId, required this.categoryName});
  final int categoryId;
  final String categoryName;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseBloc _courseBloc = CourseBloc();

  @override
  void initState() {
    _courseBloc.add(GetCoursesByCategory(widget.categoryId));
    super.initState();
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
      backgroundColor: AppColors.secondaryColor,
      body: BlocProvider(
        create: (_) => _courseBloc,
        child: BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseError) {
              Fluttertoast.showToast(msg: state.message);
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

                if (state is CourseCoursesLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _courseBloc.add(GetCoursesByCategory(widget.categoryId));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return CourseItem(
                          course: state.data[index],
                        );
                      },
                    ),
                  );
                }

                return Container();
              }
          ),
        )
      ),
    );
  }
}
