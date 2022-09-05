import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/LottieResource.dart';
import 'package:bill_splitter/ui/core/login/login_screen.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  final bool authResult;

  const SplashScreen(this.authResult, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      if (authResult) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 170.0,
                child: Lottie.asset(LottieResource.kSplitLogo),
              ),
            ),
            Text("Hassle free bill management", style: textStyleDark14px700w)
          ],
        ),
      ),
    );
  }
}
