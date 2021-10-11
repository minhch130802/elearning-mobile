import 'package:elearning_project/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        semanticsLabel: "Please wait...",
      ),
    );
  }
}