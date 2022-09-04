import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/widgets/user_note_widget.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserNoteWidget(),
            verticalSpace(10.0),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          verticalSpace(10.0),
                          Text("Welcome", style: textStylePrimary22px700w),
                          Text("Pratik katariya", style: textStyle14px500w),
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    Container(
                      height: 130.0,
                      width: Utility.screenWidth(context) * 0.9,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimaryLight,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Balance", style: textStyleRegular16px500px),
                          Text("0 Rs", style: textStyleDarkHeavy24px700),
                          verticalSpace(10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount to be Paid:", style: textStyle12px500w),
                              Text("0 Rs", style: textStyleRed12px500w),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount to be Received:", style: textStyle12px500w),
                              Text("0 Rs", style: textStyleGreen12px500w),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(right: 0, child: Image.asset(Images.kImageHome, height: 134.0)),
              ],
            ),
            Container(
              height: 30.0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Goa Trip", style: textStyleSubText14px600w),
                              Text("2000 Rs.", style: textStyle14px500w),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("10 people added to the split", style: textStyle14px500w),
                              Text("200 Rs./head", style: textStyle14px500w),
                            ],
                          ),
                          Text("27 Mar 2022", style: textStyle14px500w),
                        ],
                      ),
                    ),
                    verticalSpace(10.0),
                    line(),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 25.0, left: 25.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(Images.kIconGroup, height: 28.0, width: 28.0),
                        verticalSpace(5.0),
                        Text("Groups", style: textStylePrimary14px500w),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _modalBottomSheetMenu(context);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(Images.kIconCreateGroup, height: 60.0),
                          verticalSpace(10.0),
                          Text("Create Group", style: textStylePrimary14px500w),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset(Images.kIconPerson, height: 34.0),
                        verticalSpace(5.0),
                        Text("Account", style: textStylePrimary14px500w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Stack(
            children: [
              Container(
                height: Utility.screenHeight(context) * 0.30,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                margin: const EdgeInsets.only(top: 90.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      topLeft: Radius.circular(24.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          horizontalSpace(10.0),
                          Text('Create Group', style: textStyleDarkHeavy24px700),
                        ],
                      ),
                    ),
                    verticalSpace(28.0),
                    emailField(),
                    verticalSpace(28.0),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.colorPrimaryLight,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        height: 45.0,
                        width: 200.0,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(child: Text("Create")),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: Image.asset(Images.kImageDialog, height: 150.0),
              ),
            ],
          );
        });
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
                hintText: "Enter email or phone",
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
}
