import 'package:elearning_project/models/course_category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({required this.category});
  final CourseCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('${category.name}',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF001E6C),
                  fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis),
        ));
  }
}
