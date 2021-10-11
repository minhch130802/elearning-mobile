import 'package:community_material_icon/community_material_icon.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/providers/user.dart';
import 'package:elearning_project/utilities/user_page_functions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<dynamic> _actions = [
    [CommunityMaterialIcons.account_edit_outline, 'Edit Preferences', 'EDIT_PREFERENCES'],
    [CommunityMaterialIcons.book_open_outline, 'My Courses', 'MY_COURSES'],
    [CommunityMaterialIcons.trophy_outline, 'My Badges & Certificates', 'BADGE_ACHIEVEMENT'],
    [CommunityMaterialIcons.cog_outline, 'Settings', 'SETTINGS'],
    [CommunityMaterialIcons.cellphone_link, 'Permission & Privacy', 'PERMISSIONS'],
    [CommunityMaterialIcons.information_outline, 'About App', 'ABOUT_APP'],
    [CommunityMaterialIcons.logout_variant, 'Log out', 'LOG_OUT']
  ];
  
  UserModel? _currentUser;
  UserRestAPI _restAPI = new UserRestAPI();
  bool _loading = true;
  
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }
  
  void _getUserInfo() async {
    await _restAPI.getUserInformation(await _restAPI.getUserId()).then((value){
      setState(() {
        _currentUser = value;
        print(value.username);
      });
    }).whenComplete((){
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _loading == false ? Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${_currentUser!.profileImageUrl}"),
                          fit: BoxFit.contain
                        ),
                        color: Colors.grey
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      child: Text(
                        "${_currentUser!.fullName}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      child: Text(
                        "${_currentUser!.email}",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    )
                  ],
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _actions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      UserFunctions.openActionsPage(context, _actions[index][2]);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(_actions[index][0], size: 20,),

                          SizedBox(width: 10),

                          Text(
                            _actions[index][1],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ) : Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}