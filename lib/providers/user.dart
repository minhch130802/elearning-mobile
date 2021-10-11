import 'package:dio/dio.dart';
import 'package:elearning_project/utilities/webservice_functions.dart';
import 'package:elearning_project/models/model.dart';
import 'user_util.dart';

class UserRestAPI extends UserUtil {
  static BaseOptions options = new BaseOptions(
    baseUrl: WSFunctions.baseURL,
    connectTimeout: 5000,
    receiveTimeout: 10000,
  );

  Dio dio = new Dio(options);

  Future<UserModel> getUserInformation(userid) async {
      FormData formData = new FormData.fromMap(await super.getUserInfoByFieldBody(userid));
      final response = await dio.post(WSFunctions.baseURL, data: formData);

      print(response.data);
      if(response.statusCode == 200) {
        return UserModel.fromJSON(response.data[0]);
      }

      return UserModel();
  }

  Future<int> getUserFromSite(token) async {
    FormData formData = new FormData.fromMap(super.getUserBody(token));
    final response = await dio.post(WSFunctions.baseURL, data: formData);

    print(response.data);
    if(response.statusCode == 200) {
      return response.data['userid'];
    }

    return 0;
  }
}