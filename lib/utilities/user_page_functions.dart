import 'package:elearning_project/screens/app/about_app_page.dart';
import 'package:elearning_project/screens/app/permission_page.dart';
import 'package:elearning_project/screens/app/settings_page.dart';
import 'package:elearning_project/screens/app/splash_page.dart';
import 'package:elearning_project/screens/user/user_badge_achievement_page.dart';
import 'package:elearning_project/screens/user/user_courses_page.dart';
import 'package:elearning_project/screens/user/user_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserFunctions {
  UserFunctions._();

  static void openActionsPage(BuildContext context, String actionName) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (route) => getPageName(actionName)
        )
    );
  }

  static Widget getPageName(String actionName) {
    switch (actionName) {
      case 'EDIT_PREFERENCES': {
        return UserEditPreferencesPage();
      }

      case 'MY_COURSES': {
        return UserCoursesPage();
      }

      case 'BADGE_ACHIEVEMENT': {
        return UserBadgeAchievementPage();
      }

      case 'SETTINGS': {
        return SettingPage();
      }

      case 'PERMISSIONS': {
        return PermissionPage();
      }

      case 'ABOUT_APP': {
        return AboutAppPage();
      }

      case 'LOG_OUT': {
        final storage = new FlutterSecureStorage();
        storage.deleteAll();
        return SplashPage();
      }
    }

    return Container();
  }
}