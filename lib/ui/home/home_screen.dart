import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Text("Welcome"),
                  Text("Pratik katariya"),
                ],
              ),
            ),
            Container(
              height: 210.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerRight,
                  image: AssetImage(Images.kImageHome),
                ),
              ),
              child: Center(
                child: Container(
                  height: 110.0,
                  color: AppColors.black,
                  margin: EdgeInsets.symmetric(horizontal: 80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Balance"),
                      Text("0 Rs"),
                      Row(
                        children: [
                          Text("Amount to be Paid:"),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Amount to be Received:"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
                            children: [
                              Text("Goa Trip"),
                              Text("2000 Rs."),
                            ],
                          ),
                          Row(
                            children: [
                              Text("10 people added to the split"),
                              Text("200 Rs./head"),
                            ],
                          ),
                          Text("27 Mar 2022"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(Images.kImageLogin, height: 34.0),
                        Text("Groups"),
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
                          Image.asset(Images.kImageLogin, height: 34.0),
                          Text("Create Group"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset(Images.kImageLogin, height: 34.0),
                        Text("Account"),
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
                      onTap: () {

                      },
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

// void showDetailDialog(BuildContext context) {
//   AlertDialog alert = AlertDialog(
//     contentPadding: EdgeInsets.all(0.0),
//     backgroundColor: Colors.transparent,
//     content: Wrap(
//       children: [
//         Column(
//           children: [
//             Container(
//               height: 310.0,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(Images.kImageDialog),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
}
