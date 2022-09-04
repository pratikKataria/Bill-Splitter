import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/core/core_presenter.dart';
import 'package:bill_splitter/ui/core/core_view.dart';
import 'package:bill_splitter/ui/core/login/login_screen.dart';
import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> implements CoreView {
  final subTextStyle = textStyle12px500w;
  final mainTextStyle = textStyleSubText12px600w;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  CorePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CorePresenter(this);
    presenter.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Image.asset(Images.kImageLogin, height: 250),
              Text("Welcome", style: textStylePrimary22px700w),
              verticalSpace(5.0),
              Text("Hassle free bill management", style: textStyleSubText12px600w),
              verticalSpace(20.0),
              nameField(),
              verticalSpace(20.0),
              emailField(),
              verticalSpace(20.0),
              passwordField(),
              verticalSpace(20.0),
              InkWell(
                onTap: () {
                  presenter.createUser(nameTextController.text.toString(), emailTextController.text.toString(), otpTextController.text.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimaryLight,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 45.0,
                  width: 200.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(child: Text("Signup", style: textStylePrimary16px700w)),
                ),
              ),
              verticalSpace(10.0),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 25.0,
                  width: 150.0,
                  child: Center(child: Text("Login", style: textStyle12px500w)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container nameField() {
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
            child: Text("Name", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: nameTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your name",
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
                hintText: "Enter your email",
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
     Utility.showSuccessToastB(context, "New Id Created");
     var currentUser = await AuthUser.getInstance().getCurrentUser();
     currentUser.userCredentials = r;
     AuthUser.getInstance().login(currentUser);

     Navigator.pop(context);
     Navigator.pop(context);
     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
