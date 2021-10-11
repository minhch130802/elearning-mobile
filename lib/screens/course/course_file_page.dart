import 'package:elearning_project/utilities/app_colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:elearning_project/models/model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseFilePage extends StatefulWidget {
  CourseFilePage({required this.content});
  final CourseModuleContentModel content;
  @override
  _CourseFilePageState createState() => _CourseFilePageState();
}

class _CourseFilePageState extends State<CourseFilePage> {
  final storage = new FlutterSecureStorage();
  var taskId;
  bool _isDownloading = false;
  bool _isFailed = false;

  void _requestDownload(String link) async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        _isDownloading = true;
      });
      var token = await storage.read(key: 'token');
      taskId = await FlutterDownloader.enqueue(
        url: link + '&token=$token',
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      ).onError((error, stackTrace){
        setState(() {
          _isFailed = true;
          _isDownloading = false;
        });
        Fluttertoast.showToast(
          msg: "Download file failed!",
          toastLength: Toast.LENGTH_LONG
        );
      }).whenComplete((){
        setState(() {
          _isDownloading = false;
        });
        if(_isFailed == false) {
          Fluttertoast.showToast(
              msg: "File download successfully",
              toastLength: Toast.LENGTH_LONG
          );
        }
      });
    }
  }

  void _cancelDownload() async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  void _retryDownload() async {
    String? newTaskId = await FlutterDownloader.retry(taskId: taskId);
    setState(() {
      taskId = newTaskId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File content",
            style: TextStyle(color: Colors.black, fontSize: 16),
            overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  fileDetail("File name:", "${widget.content.fileName}"),
                  Divider(),
                  fileDetail("File size:", "${widget.content.fileSize}KB"),
                  Divider(),
                  fileDetail("Upload date:",
                      nullDateParse(widget.content.timeCreated)),
                  Divider(),
                  fileDetail("Last modified:",
                      nullDateParse(widget.content.timeModified)),
                  Divider(),
                  fileDetail("Author:", "${widget.content.author}"),
                ],
              ),
            ),

            Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Icon(EvaIcons.infoOutline)),
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        "You only can download 5 files in one time!",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )),
                ],
              ),
            ),

            GestureDetector(
              onTap: (){
                if(_isDownloading == false) {
                  if(_isFailed == true) {
                    _retryDownload();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Start downloading...",
                        toastLength: Toast.LENGTH_SHORT
                    );
                    _requestDownload("${widget.content.fileUrl}");
                  }
                } else {
                  _cancelDownload();
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    _isDownloading == false ? "Download file" : "Downloading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          Container(
              width: 90,
              margin: const EdgeInsets.only(right: 5),
              child: Text(title)),
          Container(
              width: MediaQuery.of(context).size.width - 150,
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                value,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }

  String nullDateParse(DateTime? dateTime) {
    if (dateTime == null) {
      return "Unknown";
    }

    final f = new DateFormat('hh:mm dd/MM/yyyy');

    return f.format(dateTime).toString();
  }
}
