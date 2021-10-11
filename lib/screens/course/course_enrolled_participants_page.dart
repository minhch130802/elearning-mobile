import 'package:elearning_project/providers/course.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseEnrolledParticipantsPage extends StatefulWidget {
  CourseEnrolledParticipantsPage({required this.courseId});
  final int courseId;

  @override
  _CourseEnrolledParticipantsPageState createState() =>
      _CourseEnrolledParticipantsPageState();
}

class _CourseEnrolledParticipantsPageState
    extends State<CourseEnrolledParticipantsPage> {
  CourseRestAPI _courseAPI = new CourseRestAPI();
  List<UserModel> _userList = [];
  bool _isLoading = true;

  @override
  void initState() {
    getParticipantsList();
    super.initState();
  }

  @override
  void dispose() {
    if (_userList.length > 0) _userList.clear();
    super.dispose();
  }

  void getParticipantsList() {
    if (_isLoading == false) _isLoading = true;
    if (_userList.length > 0) _userList.clear();

    _courseAPI.getEnrolledParticipants(widget.courseId).then((value) {
      setState(() {
        _userList.addAll(value);
        _userList.sort((a, b) => a.firstname!.compareTo(b.firstname!));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Participants",
            style: TextStyle(color: Colors.black, fontSize: 16),
            overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: RefreshIndicator(
          onRefresh: getRefresh,
          child: ListView.builder(
            itemCount: _userList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 70,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${_userList[index].profileImageUrl}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          width: MediaQuery.of(context).size.width - 120,
                          child: Text(
                            "${_userList[index].fullName}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "${_userList[index].email}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: AppColors.primaryColor),
                          ),
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < _userList[index].roles!.length;
                                    i++)
                                  Text(addBreak(i) +
                                      "${roleToString(_userList[index].roles![i].roleId!)}"),
                              ],
                            )),

                        SizedBox(height: 5,)
                      ],
                    ),
                    Container(
                      height: 70,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color:
                              isRecently(_userList[index].lastCourseAccess!) <
                                      10
                                  ? Colors.green[400]
                                  : Colors.red[400]),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getRefresh() async {
    getParticipantsList();
  }

  String roleToString(int id) {
    var roles = ['Admin', '?', '?', 'Teacher', '?', 'Student'];
    return roles[id];
  }

  int isRecently(DateTime dateTime) {
    final date = DateTime.now();
    return (date.difference(dateTime).inHours / 24).round();
  }

  String addBreak(int pos) {
    if (pos > 0) return ", ";
    return "";
  }
}
