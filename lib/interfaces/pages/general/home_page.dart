import 'package:elearning_project/interfaces/pages/general/grade_page.dart';
import 'package:elearning_project/interfaces/pages/general/recently_course_page.dart';

import '/interfaces/pages/general/discovery_page.dart';
import 'package:flutter/material.dart';

import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shape: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
            title: Text(
              "E-Learning Mobile",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xFF001E6C)),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              indicatorWeight: 3,
              indicatorColor: Color(0xFF001E6C),
              labelColor: Color(0xFF001E6C),
              tabs: [
                Tab(
                  text: "Discovery",
                ),
                Tab(
                  text: "Recently",
                ),
                Tab(
                  text: "Calendar",
                ),
                Tab(
                  text: "Grade",
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              DiscoveryPage(),
              RecentlyCoursePage(),
              CalendarPage(),
              GradePage()
            ],
          )
        ));
  }
}