import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/core/core_view.dart';
import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/core/signup/signup_screen.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:bill_splitter/user/CurrentUser.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core_presenter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements CoreView {
  final subTextStyle = textStyle12px500w;
  final mainTextStyle = textStyleSubText12px600w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  CorePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CorePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset(Images.kImageLogin, height: 250),
                  Text("Welcome Back!", style: textStylePrimary22px700w),
                  verticalSpace(5.0),
                  Text("Hassle free bill management", style: textStyleSubText12px600w),
                  verticalSpace(60.0),
                  emailField(),
                  verticalSpace(10.0),
                  passwordField(),
                  verticalSpace(20.0),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      presenter.loginUser(context, emailTextController.text.toString());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimaryLight,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 45.0,
                      width: 200.0,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(child: Text("Login", style: textStylePrimary16px700w)),
                    ),
                  ),
                  verticalSpace(10.0),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Center(child: Text("Create Account", style: textStyle12px500w)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container emailField() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Email", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: emailTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter email",
                hintStyle: subTextStyle,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }

  Container passwordField() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Password", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              // obscureText: true,
              textAlign: TextAlign.left,
              controller: otpTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter password",
                hintStyle: subTextStyle,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onNewUserCreated(UserResponse r) async {
    Utility.showSuccessToastB(context, "Logged in successfully");
    CurrentUser currentUser = CurrentUser();
    currentUser.userCredentials = r;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void onError(String message) {
    Utility.showErrorToastC(context, message);
  }
}
