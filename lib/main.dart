import 'package:bill_splitter/ui/core/login/login_screen.dart';
import 'package:bill_splitter/ui/core/signup/signup_screen.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'util/Utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Utility.statusBarAndNavigationBarColor();
  await Utility.portrait();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Splitter',
      home: HomeScreen(),
    );
  }
}
