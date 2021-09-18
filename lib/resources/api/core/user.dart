import 'package:dio/dio.dart';
import '/models/user/user.dart';
import '/resources/api/util/user_util.dart';

class UserRestAPI extends UserUtil {
  Dio dio = new Dio();

  Future<User> getUserInformation(userid) async {
      FormData formData = new FormData.fromMap(await super.getUserInfoByField(userid));
      final response = await dio.post(super.baseURL, data: formData);

      print(response.data);
      if(response.statusCode == 200) {
        return User.fromJSON(response.data[0]);
      }

      return User();
  }

  Future<int> getUserFromSite(token) async {
    FormData formData = new FormData.fromMap(super.getUser(token));
    final response = await dio.post(super.baseURL, data: formData);

    print(response.data);
    if(response.statusCode == 200) {
      return response.data['userid'];
    }

    return 0;
  }
}