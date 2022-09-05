import 'dart:io';
import 'dart:ui';

import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/LottieResource.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Utility.dart';

class Dialogs {
  static ProgressDialog pd;

  static void ackAlert(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonn'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                /*  Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, Constants.OTPSCREEN);*/
              },
            ),
          ],
        );
      },
    );
  }

  static void showLoader(
    BuildContext context,
    String description,
    String title,
  ) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 2.0,
              sigmaX: 2.0,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 250,
                width: Utility.screenWidth(context),
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$title',
                        style: textStylePrimary16px700w,
                      ),
                      verticalSpace(5.0),
                      Text(
                        '$description',
                        style: textStyleDarkRegular14px600w,
                      ),
                      SizedBox(
                        height: 170.0,
                        child: Lottie.asset(LottieResource.kLoader),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
    /* showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
          titlePadding: EdgeInsets.all(0),
          content: InkWell(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Lottie.asset(LottieResource.kLoader),
            ),
            onTap: () {
              Navigator.pop(context);
              listener.onClick();
            },
          ),
        );
      },
    );*/
  }

  static Future<void> hideLoader(BuildContext context) async {
    await Navigator.pop(context);
  }

  static void showProgressDialod(BuildContext context) {
    if (pd == null) {
      pd = new ProgressDialog(context, type: ProgressDialogType.Normal);
    }
    pd.style(message: "Loading..");
    pd.show();
  }

  static void hideProgressDialog(BuildContext context) {
    if (pd != null) {
      pd.hide();
    }
  }

  static Widget buildProgressIndicator(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }

  static Future<bool> exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Do you want to exit this application?'),
              content: new Text('Press Yes to leave...'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => exit(0),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static void showNonMendetoryUpdate(BuildContext context, String message, ClickInterface interface) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonn'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.pop(context);
//                StoreRedirect.redirect();
//                 StoreRedirect.redirect(
//                     androidAppId: "com.fonn.fonnapp", iOSAppId: "1513700647");
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                interface.onClick();
              },
            ),
          ],
        );
      },
    );
  }

  static void showMendetoryUpdate(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonn'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.pop(context);
                // StoreRedirect.redirect(
                //     androidAppId: "com.fonn.fonnapp", iOSAppId: "1513700647");
              },
            ),
          ],
        );
      },
    );
  }


}

abstract class ClickInterface {
  void onClick();
}

/*
AlertDialog(
backgroundColor: AppColors.colorPrimary,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.all(Radius.circular(10))),
contentPadding: EdgeInsets.all(0),
titlePadding: EdgeInsets.all(0),
title: Container(
width: Utility.screenWidth(context),
height: 50,
decoration: BoxDecoration(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10), topRight: Radius.circular(10)),
color: AppColors.colorPrimary,
),
alignment: Alignment.center,
child: Text(title,
style: TextStyle(
color: AppColors.white,
fontFamily: kFontFamily,
fontWeight: FontWeight.bold,
fontSize: 18)),
),
content: Stack(
children: <Widget>[
Container(
color: AppColors.white,
margin: EdgeInsets.only(bottom: 50),
child: SingleChildScrollView(
child: Container(
width: Utility.screenWidth(context),
padding: EdgeInsets.all(10),
),
),
),
Positioned(
bottom: 0,
left: 0,
right: 0,
child: InkWell(
child: Container(
width: Utility.screenWidth(context),
height: 50,
decoration: BoxDecoration(
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(10),
bottomRight: Radius.circular(10)),
color: AppColors.colorPrimary,
),
alignment: Alignment.center,
child: Text(
"Close",
style: TextStyle(
color: AppColors.white,
fontFamily: kFontFamily,
fontWeight: FontWeight.bold,
fontSize: 18),
),
),
onTap: () {
Navigator.pop(context);
listener.onClick();
},
),
),
],
),
)*/
