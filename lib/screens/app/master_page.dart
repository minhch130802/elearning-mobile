import 'package:elearning_project/screens/app/enrolled_page.dart';
import 'package:elearning_project/screens/app/notification_page.dart';
import 'package:elearning_project/screens/user/user_page.dart';
import 'package:elearning_project/utilities/app_colors.dart';

import 'home_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final List<Widget> body = [
    HomePage(),
    EnrolledPage(),
    NotificationPage(),
    UserPage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
        selectedItemColor:  AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.homeOutline),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.activityOutline),
            label: "Enrolled"
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
        onTap: (index){
          setState((){
            _selectedIndex = index;
          });
        },
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: body,
      )
    );
  }
}