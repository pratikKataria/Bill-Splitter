import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/ui/splash/splash_screen.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'util/Utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Utility.statusBarAndNavigationBarColor();
  await Utility.portrait();

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();

  runApp(MyApp(authResult));
}

class MyApp extends StatelessWidget {
  final bool authResult;

  MyApp(this.authResult);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split It ',
      home: checkAuthUser(authResult),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: AppColors.white,
      ),
    );
  }

  checkAuthUser(authResult) {
    return SplashScreen(authResult);
  }
}
