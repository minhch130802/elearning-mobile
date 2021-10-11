import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FileDownload {


  FlutterSecureStorage storage = new FlutterSecureStorage();
  String status = 'free';
  String saveDirectory = '/storage/emulated/0/Download/';

  Future<String> singleFileDownload(String fileUrl) async {
    var token = await storage.read(key: 'token');
    String result = await FlutterDownloader.enqueue(
      url: fileUrl + '&token=$token',
      savedDir: saveDirectory,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    ).onError((error, stackTrace){
      throw '$error';
    }) ?? '';
    return result;
  }

  Future<List<String>> multiFileDownload(List<String> fileUrl) async {
    List<String> result = [];



    return result;
  }
}