import 'package:elearning_project/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class CourseUrlPage extends StatefulWidget {
  CourseUrlPage({required this.name, required this.url});
  final String name;
  final String url;
  @override
  State<CourseUrlPage> createState() => _CourseUrlPageState();
}

class _CourseUrlPageState extends State<CourseUrlPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toUpperCase(),
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
            overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        elevation: 0,
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
