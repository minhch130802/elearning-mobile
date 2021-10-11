import 'package:elearning_project/utilities/webservice_functions.dart';

import 'global_util.dart';

class UserUtil extends GlobalUtil {

  Future<Map<String, dynamic>> getUserInfoByFieldBody(userid) async {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': await super.getToken(),
      'wsfunction': WSFunctions.coreUserGetUsersByField,
      'field': 'id',
      'values[0]': userid
    };

    return body;
  }

  Map<String, dynamic> getUserBody(token) {
    Map<String, dynamic> body = {
      'moodlewsrestformat': 'json',
      'wstoken': token,
      'wsfunction': WSFunctions.coreWebserviceGetSiteInfo
    };

    return body;
  }
}