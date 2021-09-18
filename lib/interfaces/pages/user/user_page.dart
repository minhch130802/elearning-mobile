import 'package:elearning_project/interfaces/themes/master.dart';
import 'package:elearning_project/models/user/user.dart';
import 'package:elearning_project/resources/api/core/user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<String> _settingActions = [
    'Edit Preferences',
    'My Courses',
    'My Badges & Certificates',
    'Settings',
    'Permission & Privacy',
    'About App',
    'Log out'
  ];
  
  User? _currentUser;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: _loading == false ? Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MasterTheme().secondaryColor
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
                            color: MasterTheme().primaryColor
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _settingActions.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                        _settingActions[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
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