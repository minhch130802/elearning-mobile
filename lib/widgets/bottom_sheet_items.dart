import 'package:elearning_project/themes/master.dart';
import 'package:flutter/material.dart';

class BottomSheetItems extends StatelessWidget {
  BottomSheetItems({required this.name, required this.icon, this.function});
  final String name;
  final IconData icon;
  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MasterTheme().secondaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: MasterTheme().primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 14, color: MasterTheme().primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
