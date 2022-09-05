import 'package:bill_splitter/ui/core/login/login_screen.dart';
import 'package:bill_splitter/ui/core/signup/signup_screen.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_screen.dart';
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
      title: 'Bill Splitter',
      home: checkAuthUser(authResult),
      theme: new ThemeData(
        primaryColor: Colors.white,
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
    );
  }
  checkAuthUser(authResult) {
    if (authResult) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }

}
