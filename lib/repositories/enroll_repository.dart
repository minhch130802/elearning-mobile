
import 'package:elearning_project/models/model.dart';
import 'package:elearning_project/providers/core.dart';

class EnrollRepository {
  EnrolRestAPI enrolRestAPI = new EnrolRestAPI();

  Future<void> selfEnrollment(int courseId, String password) async {
    try {
      await enrolRestAPI.selfEnrollment(courseId, password);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<EnrolModel> fetchCourseEnrolMethod(int id) async {
    try {
      final rawData = await enrolRestAPI.getCourseEnrolMethod(id);
      print(rawData is List);
      return EnrolModel.fromJSON(rawData.data[0]);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<EnrolModel> fetchCourseEnrolMethodInfo(int id) async {
    try {
      final rawData = await enrolRestAPI.getCourseEnrolMethodInfo(id);
      return EnrolModel.fromJSON(rawData.data);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}