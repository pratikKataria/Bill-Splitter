import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:bill_splitter/ui/widgets/user_note_widget.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

class SplitBillScreen extends StatefulWidget {
  const SplitBillScreen({Key key}) : super(key: key);

  @override
  State<SplitBillScreen> createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> {
  final subTextStyle = textStyleSubText12px500w;
  final mainTextStyle = textStyle12px500w;

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
            verticalSpace(8.0),
            header(),
            verticalSpace(12.0),
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 55.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10.0),
                          Text("Goa Trip", style: textStyle14px500w),
                          Text("Created by you", style: textStyle14px500w),
                        ],
                      ),
                    ),
                    verticalSpace(15.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 80.0,
                        width: Utility.screenWidth(context) * 0.9,
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: AppColors.colorPrimaryLight,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), topLeft: Radius.circular(24.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total bill", style: textStyleRegular16px500px),
                            Text("0 Rs", style: textStyleDarkHeavy24px700),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(right: 20, child: Image.asset(Images.kImageSplitBill, height: 140.0)),
              ],
            ),
            verticalSpace(2.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                horizontalSpace(45.0),
                Text("Split between ", style: textStyleRegular16px500px),
                Text("0", style: textStyleDarkHeavy24px700),
                Text(" People", style: textStyleRegular16px500px),
              ],
            ),
            verticalSpace(25.0),
            Row(
              children: [
                horizontalSpace(45.0),
                Text("Friends", style: mainTextStyle),
                Spacer(),
                InkWell(
                    onTap: () {
                      _modalBottomSheetMenu(context);
                    },
                    child: Text("Add New", style: textStyleRedRegular14px700w)),
                horizontalSpace(20.0),
              ],
            ),
            verticalSpace(20.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 40.0),
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondaryLight,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Deepak (400 Rs.)", style: textStyle14px500w),
                              Text("+ Expense", style: textStyleSecondary12px700w),
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimaryLight,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 45.0,
                  width: 200.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(child: Text("Submit Request", style: textStylePrimary16px700w)),
                ),
              ),
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  Container header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios),
          horizontalSpace(10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Split the bill", style: textStyle14px500w),
              Text("Enjoy together, happy to share", style: textStyle12px500w),
            ],
          ),
        ],
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
                height: Utility.screenHeight(context) * 0.60,
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                margin: const EdgeInsets.only(top: 90.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      topLeft: Radius.circular(24.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add Friends', style: textStyle20px600w),
                    verticalSpace(20.0),
                    Text('Add from list', style: textStyle14px500w),
                    verticalSpace(10.0),
                    Container(
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: AppColors.colorPrimaryLight, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Center(child: Text("Anil", style: textStyle12px500w)),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    Text('Add by name', style: textStyle14px500w),
                    verticalSpace(10.0),
                    emailField(),
                    verticalSpace(20.0),
                    Text('Added', style: textStyle14px500w),
                    verticalSpace(10.0),
                    Container(
                      height: 40.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: AppColors.colorSecondaryLight,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Text("Anil", style: textStyle12px500w),
                                  horizontalSpace(10.0),
                                  Icon(Icons.remove_circle_outline_rounded, color: AppColors.colorSecondary, size: 24.0)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimaryLight,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          height: 45.0,
                          width: 200.0,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Center(child: Text("Create", style: textStylePrimary16px700w)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: Image.asset(Images.kImageAddFriend, height: 150.0),
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
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Add Name", style: mainTextStyle),
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
                hintText: "Enter name ",
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
