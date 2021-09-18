import 'package:elearning_project/interfaces/themes/master.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: MasterTheme().primaryColor,
          ),
          SizedBox(width: 10,),
          Text("Please wait..."),
        ],
      ),
    );
  }
}