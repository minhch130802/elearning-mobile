import 'package:dio/dio.dart';
import 'package:elearning_project/api/util/util.dart';
import 'package:elearning_project/models/enrol/enrol.dart';


class EnrolRestAPI extends EnrolUtil {
  Dio dio = new Dio();
  //This function will enrol user into the current code with code id
  //With the code with no password just set it by null
  Future<bool> selfEnrollment(int courseId, String password) async {
    FormData formData = new FormData.fromMap(super.selfEnrolUser(courseId, password));

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      if(response.data['status'] == true) {
        return true;
      }
    }

    return false;
  }

  Future<EnrolModel> getCourseEnrolMethod(int courseId) async {
    FormData formData = new FormData.fromMap(super.getEnrolMethod(courseId));

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      if(response.data[0]['status'] == true) {
        return EnrolModel.fromJSON(response.data[0]);
      }
    }

    return EnrolModel(status: false);
  }

  Future<EnrolModel> getCourseEnrolMethodInfo(EnrolModel model) async {
    FormData formData = new FormData.fromMap(super.getEnrolMetodInfo(model.id!));

    final response = await dio.post(
        super.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      if(response.data['status'] == true) {
        return EnrolModel.fromJSON(response.data);
      }
    }

    return EnrolModel(status: false);
  }

}
