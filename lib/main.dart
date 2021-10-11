import 'package:elearning_project/screens/app/splash_page.dart';
import 'package:elearning_project/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  FlutterDownloader.registerCallback(TestClass.callback);
  runApp(MyApp());
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning Mobile',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('vi', ''), // Spanish, no country code
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
      ),
      home: SplashPage(),
    );
  }
}