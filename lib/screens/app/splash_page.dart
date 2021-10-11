import 'package:elearning_project/screens/app/authencation_page.dart';
import 'package:elearning_project/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'master_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  void _checkLogin() async {
    final data = await storage.read(key: 'isLogin');

    Future.delayed(const Duration(seconds: 5), () {
      if (data == 'true') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (route) => MasterPage()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (route) => AuthenticationPage()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('./assets/images/full_logo.png'),
                ),
                SizedBox(height: 150,),
                LoadingIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}