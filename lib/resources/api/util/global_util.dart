import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalUtil {
  final String baseURL = "https://elearning.tdmu.edu.vn/webservice/rest/server.php?";
  final storage = new FlutterSecureStorage();

  Future<String> getToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> getUserId() async {
    return await storage.read(key: 'userid') ?? '0';
  }
}