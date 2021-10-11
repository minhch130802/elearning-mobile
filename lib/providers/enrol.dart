import 'package:dio/dio.dart';
import 'package:elearning_project/models/fetch_exception.dart';
import 'package:elearning_project/utilities/webservice_functions.dart';
import 'enrol_util.dart';


class EnrolRestAPI extends EnrolUtil {
  static BaseOptions options = new BaseOptions(
    baseUrl: WSFunctions.baseURL,
    connectTimeout: 5000,
    receiveTimeout: 10000,
  );

  Dio dio = new Dio(options);

  //This function will enrol user into the current code with code id
  //With the code with no password just set it by null
  Future<dynamic> selfEnrollment(int courseId, String password) async {
    FormData formData = new FormData.fromMap(await super.selfEnrolUserBody(courseId, password));

    final response = await dio.post(
        WSFunctions.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      if(response.data['status'] == false) {
        throw FetchException(response.data['message']);
      }
    }

    throw FetchException('${response.statusMessage}');
  }

  Future<dynamic> getCourseEnrolMethod(int courseId) async {
    FormData formData = new FormData.fromMap(await super.getEnrolMethodBody(courseId));

    final response = await dio.post(
        WSFunctions.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      if(response.data[0]['status'] is bool) {
        return response;
      } else {
        throw FetchException(response.data[0]['status']);
      }
    }

    throw FetchException('${response.statusMessage}');
  }

  Future<dynamic> getCourseEnrolMethodInfo(int id) async {
    FormData formData = new FormData.fromMap(await super.getEnrolMethodInfo(id));

    final response = await dio.post(
        WSFunctions.baseURL,
        data: formData
    );

    if(response.statusCode == 200) {
      print(response);
      if(response.data['status'] is bool) {
        return response;
      } else {
        throw FetchException(response.data['status']);
      }
    }

    throw FetchException('${response.statusMessage}');
  }
}
