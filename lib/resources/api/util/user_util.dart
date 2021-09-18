import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'util.dart';

class UserUtil extends GlobalUtil {

  final String _getSiteInfo = 'core_webservice_get_site_info';
  final String _getUserInfoByField = 'core_user_get_users_by_field';

  Future<Map<String, dynamic>> getUserInfoByField(userid) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '${await super.getToken()}',
      'wsfunction': '${this._getUserInfoByField}',
      'field': 'id',
      'values[0]': userid
    };

    return body;
  }

  Map<String, dynamic> getUser(token) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': '$token',
      'wsfunction': '${this._getSiteInfo}'
    };

    return body;
  }
}