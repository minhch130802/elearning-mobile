import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalUtil {

  final storage = new FlutterSecureStorage();

  Future<String> getToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> getUserId() async {
    return await storage.read(key: 'userid') ?? '0';
  }
}