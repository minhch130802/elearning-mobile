import 'dart:convert';
import 'dart:math';

import 'package:elearning_project/interfaces/pages/master_page.dart';
import 'package:elearning_project/interfaces/themes/master.dart';
import 'package:elearning_project/resources/api/core/user.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'decoding.dart';

class AuthencationPage extends StatefulWidget {
  @override
  _AuthencationPageState createState() => _AuthencationPageState();
}

class _AuthencationPageState extends State<AuthencationPage> {
  final storage = new FlutterSecureStorage();
  UserRestAPI _userRestAPI = new UserRestAPI();

  void _authenticate() async {
    Random random = new Random();

    final passport = (random.nextDouble() * 1000).toString();
    final baseUrl = 'https://elearning.tdmu.edu.vn';
    String loginUrl = baseUrl + '/admin/tool/mobile/launch.php';
    loginUrl += '?service=moodle_mobile_app';
    loginUrl += '&passport=' + passport;
    loginUrl += '&urlscheme=moodlemobile';

    if (await canLaunch(loginUrl)) {
      await launch(loginUrl);
    }

    linkStream.listen((event) async {
      final uri = event;

      if(uri != null) {
        final base64Text = base64.decode(uri.substring(uri.indexOf('=') + 1));
        final result = utf8.decode(base64Text);
        var params = result.split(':::');

        this._saveToken(params[1], params[2]).whenComplete(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (route) => MasterPage()));
        });
      }
    });

  }

  Future<void> _saveToken(String token, String privateToken) async {
    var userid = await _userRestAPI.getUserFromSite(token);
    print('UserId: $userid');
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'privateToken', value: privateToken);
    await storage.write(key: 'isLogin', value: 'true');
    await storage.write(key: 'userid', value: userid.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Center(
            child:
                Column(
                  children: [
                    SizedBox(height: 100,),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('./assets/images/full_logo.png'),
                    ),

                    Text(
                      "Welcome back",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "Please sign in to your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        this._authenticate();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MasterTheme().primaryColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.only(top: 100),
                        child: Center(
                            child: Text(
                                'Sign in with E-Learning SSO',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
        ),
      ),
    );
  }
}
