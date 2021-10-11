import 'package:elearning_project/screens/course/course_category_page.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({required this.id, required this.name});
  final int id;
  final String name;
  final Map<int, String> _imageList = {
    698: 'simple_logo.png',
    3: 'KKTE.png',
    2: 'KTCN.png',
    20: 'KHQL.png',
    12: 'SP.png',
    4: 'KNN.png',
    69: 'KTC.png',
    128: 'simple_logo.png',
    129: 'KTR.png',
    195: 'SDH.jpg',
    201: 'simple_logo.png',
    39: 'simple_logo.png',
    6: 'simple_logo.png',
    29: 'simple_logo.png',
    611: 'simple_logo.png',
    490: 'simple_logo.png',
    636: 'THT.png',
    641: 'simple_logo.png',
    112: 'HSV.png',
    492: 'simple_logo.png',
    30: 'simple_logo.png',
    9: 'simple_logo.png',
    14: 'simple_logo.png',
    5: 'simple_logo.png',
    36: 'simple_logo.png',
    914: 'simple_logo.png'
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCategoryTap(context),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          // border: Border.all(color: Color(0xFFE5E5E5)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image:
                      AssetImage('./assets/images/${_imageList[id]}'),
                      fit: BoxFit.cover)
                    ),
            ),
            Container(
              height: 53,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              //decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
              child: Text("${name.split('/')[0]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xFF001E6C)),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  void _onCategoryTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CourseCategoryPage(
          id: id,
          name: name
        )));
  }
}