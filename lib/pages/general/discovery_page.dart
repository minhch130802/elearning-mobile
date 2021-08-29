import 'package:elearning_project/pages/course/course_category_page.dart';
import 'package:flutter/material.dart';
import 'package:elearning_project/api/core/course.dart';
import 'package:elearning_project/models/course/course_category.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin<DiscoveryPage> {
  CourseRestAPI _courseCategoryAPI = new CourseRestAPI();
  List<CourseCategory> _courseCategoryList = [];
  Map<int, String> _imageList = {
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
    36: 'simple_logo.png'
  };
  bool _isLoading = true;

  @mustCallSuper
  void initState() {
    _getCourseCategories();
    super.initState();
  }

  void _getCourseCategories() {
    _courseCategoryAPI.getCourseCategory().then((value) {
      if (value != []) {
        for (int i = 0; i < value.length; i++) {
          if (value[i].parent == 0) {
            _courseCategoryList.add(value[i]);
          }
        }
        _courseCategoryList
            .sort((a, b) => a.sortOrder!.compareTo(b.sortOrder!));
      }
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
        print("Length: ${_courseCategoryList.length}");
      });
    });
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return !_isLoading
        ? RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: itemWidth / 250,
                children: _courseCategoryList.map<Widget>((item) {
                  return GestureDetector(
                    onTap: () => _onCategoryTap(item.id!),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                        './assets/images/${_imageList[item.id]}'),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            height: 53,
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
                            child: Text("${item.name!.split('/')[0]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF001E6C)),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text("Please wait...")
              ],
            ),
          );
  }

  void _onCategoryTap(int id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CourseCategoryPage(
              categoryId: id,
            )));
  }

  Future<void> _pullRefresh() async {
    _courseCategoryList.clear();
    setState(() {
      _isLoading = true;
    });
    _getCourseCategories();
  }

  @mustCallSuper
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
