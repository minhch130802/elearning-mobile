import 'dart:async';

import 'package:elearning_project/bloc/course_bloc.dart';
import 'package:elearning_project/bloc/enroll_bloc.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CourseEnrollPage extends StatefulWidget {
  CourseEnrollPage(
      {required this.courseId,
      required this.courseName,
      required this.teacherName,
      required this.courseDescription});

  final int courseId;
  final String courseName;
  final List<String> teacherName;
  final String courseDescription;

  @override
  _CourseEnrollPageState createState() => _CourseEnrollPageState();
}

class _CourseEnrollPageState extends State<CourseEnrollPage> {
  TextEditingController _passwordController = new TextEditingController();
  EnrollBloc _enrollBloc = EnrollBloc();
  CourseBloc _courseBloc = CourseBloc();

  @override
  void initState() {
    _enrollBloc.add(GetEnrollMethodInfo(widget.courseId));
    super.initState();
  }

  void onEnrolTap(bool isNeedPassword) async {
    String password = "";
    if(isNeedPassword == true) password = _passwordController.text;
    _courseBloc.add(SelfEnrollment(widget.courseId, password));
    Navigator.of(context).pop('done');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('${widget.courseName}',
              style: TextStyle(color: Colors.black, fontSize: 16),
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: BlocProvider(
            create: (_) => _enrollBloc,
            child: BlocListener<EnrollBloc, EnrollState>(
              listener: (context, state) {
                if (state is EnrollError) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              child: BlocBuilder<EnrollBloc, EnrollState>(
                builder: (context, state) {
                  if (state is EnrollInitial) {
                    return LoadingIndicator();
                  }

                  if (state is EnrollLoading) {
                    return LoadingIndicator();
                  }

                  if (state is EnrollMethodInfoLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.courseName}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.teacherName.length,
                                  itemBuilder: (context, index) =>
                                      Text("${widget.teacherName[index]}"),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.botticelliColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Html(data: "${widget.courseDescription}"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          state.data.enrolPassword == true
                              ? Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 10),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Password',
                                ),
                              ))
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: (){
                              onEnrolTap(state.data.enrolPassword ?? false);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Enrol",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
          )
        ),
      ),
    );
  }
}
