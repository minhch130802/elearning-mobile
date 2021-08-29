import 'package:elearning_project/pages/general/home_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  List<Widget> body = [
    HomePage(),
    HomePage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Color(0xFF001E6C)),
        selectedItemColor:  Color(0xFF001E6C),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.homeOutline),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.activityOutline),
            label: "History"
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.bellOutline),
              label: "Notifications"
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.personOutline),
              label: "Profile"
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _selectedIndex,
      ),
      backgroundColor: Colors.white,
      body: body[_selectedIndex]
    );
  }
}