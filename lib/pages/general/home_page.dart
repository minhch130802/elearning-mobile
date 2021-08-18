import 'package:elearning_project/pages/general/discovery_page.dart';
import 'package:flutter/material.dart';

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
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  shape: Border(bottom: BorderSide(color: Color(0xFFEFEFEF))),
                  title: Text(
                    "E-Learning Mobile",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xFF001E6C)),
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
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
                Center(
                  child: Text("In developing"),
                ),
                Center(
                  child: Text("In developing"),
                ),
                Center(
                  child: Text("In developing"),
                )
              ],
            ),
          ),
        ));
  }
}
