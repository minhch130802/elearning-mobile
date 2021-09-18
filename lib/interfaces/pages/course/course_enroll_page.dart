import '/resources/api/core/core.dart';
import '/models/enrol/enrol.dart';
import 'package:flutter_html/flutter_html.dart';
import '/interfaces/themes/master.dart';
import 'package:flutter/material.dart';

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
  EnrolRestAPI _enrolRestAPI = new EnrolRestAPI();
  bool _isNeedPassword = false;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await _enrolRestAPI.getCourseEnrolMethod(widget.courseId).then((value) {
      if (value.status == true) {
        loadEnrolInfo(value);
      }
    }).whenComplete((){
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> loadEnrolInfo(EnrolModel model) async {
    await _enrolRestAPI.getCourseEnrolMethodInfo(model).then((value) {
      if (value.status == true) {
        setState(() {
          _isNeedPassword = value.enrolPassword!;
        });
      } else {
        setState(() {
          _isError = true;
        });
      }
    }).whenComplete((){
      setState(() {
        _isLoading = false;
      });
    });
  }

  void onEnrolTap() async {
    String password = "";
    bool status = false;
    if(_isNeedPassword == true) password = _passwordController.text;

    await _enrolRestAPI.selfEnrollment(widget.courseId, password).then((value){
      status = value;
      print(status);
    }).whenComplete((){
      if(status == true) {
        Navigator.of(context).pop(true);
      }
    });
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
          title: Text('Course Enrol',
              style: TextStyle(color: Colors.black, fontSize: 16),
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: _isLoading == false ? Column(
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
                    color: MasterTheme().botticelliColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Html(data: "${widget.courseDescription}"),
              ),
              SizedBox(
                height: 10,
              ),
              _isNeedPassword == true
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
                onTap: onEnrolTap,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MasterTheme().primaryColor,
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
          ) : Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10,),
                Text("Loading...")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
