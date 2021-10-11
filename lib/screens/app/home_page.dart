import 'package:elearning_project/screens/app/grade_page.dart';
import 'package:elearning_project/screens/app/recently_course_page.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'discovery_page.dart';
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
          backgroundColor: AppColors.secondaryColor,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return [
                const SliverAppBar(
                  backgroundColor: Colors.white,
                  shape: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
                  title: Text(
                    "E-Learning Mobile",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001E6C)
                    ),
                  ),
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  snap: true,
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
                )
              ];
            },
            body: TabBarView(
              children: [
                DiscoveryPage(),
                RecentlyCoursePage(),
                CalendarPage(),
                GradePage()
              ],
            )
          )
        ));
  }
}