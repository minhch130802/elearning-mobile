import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/providers/course.dart';

class CourseRepository {
  final courseRestAPI = new CourseRestAPI();

  Future<List<CourseContentModel>> fetchCourseContent(int id) async {
    try {
      final rawData = await courseRestAPI.getCourseContent(id);
      final dataLength = rawData.data.length;
      List<CourseContentModel> courseContentList = [];

      for (int i = 0; i < dataLength; i++) {
        courseContentList.add(new CourseContentModel.fromJSON(rawData.data[i]));
      }

      return courseContentList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<CourseCategoryModel>> fetchCourseCategories(int parent) async {
    try {
      final rawData = await courseRestAPI.getCourseCategory(parent);
      final dataLength = rawData.data.length;
      List<CourseCategoryModel> courseCategoryList = [];

      for (int i = 0; i < dataLength; i++) {
        if(rawData.data[i]['parent'] == parent) {
          courseCategoryList.add(new CourseCategoryModel.fromJSON(rawData.data[i]));
        }
      }

      courseCategoryList.sort((a, b) => a.sortOrder!.compareTo(b.sortOrder!));

      return courseCategoryList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<CourseModel>> fetchCoursesByCategory(id) async {
    try {
      final rawData = await courseRestAPI.getCourseByCategory(id);
      List<CourseModel> courseList = [];

      final responseLength = rawData.data["courses"].length;

      for (int i = 0; i < responseLength; i++) {
        courseList.add(new CourseModel.fromJSON(rawData.data["courses"][i]));
      }

      courseList.sort((a,b) => a.sortOrder!.compareTo(b.sortOrder!));

      return courseList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<UserModel>> getEnrolledParticipants(id) => courseRestAPI.getEnrolledParticipants(id);
}