import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class UnderDevelopingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer",
            style: TextStyle(color: Colors.black, fontSize: 16),
            overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('./assets/images/full_logo.png'),
              ),

              SizedBox(height: 30,),

              Text(
                "Hello there!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                    "This feature is still under developing! Please wait for new"
                        " update and got this feature soon. Thank you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}