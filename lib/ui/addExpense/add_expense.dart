import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/home/home_screen.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_screen.dart';
import 'package:bill_splitter/ui/widgets/user_note_widget.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key key}) : super(key: key);

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
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
            verticalSpace(20.0),
            header(),
            verticalSpace(25.0),

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
            verticalSpace(20.0),
            Row(
              children: [
                horizontalSpace(45.0),
                Text("Expenses", style: mainTextStyle),
                Spacer(),
                Text("Add New", style: textStyleRedRegular14px700w),
                horizontalSpace(20.0),
              ],
            ),
            Expanded(
              child: ListView(
                children: [],
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
              Text("Add Expense", style: textStyle14px500w),
              Text("Enjoy together, happy to share", style: textStyle12px500w),
            ],
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
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
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
                    Text('Create Group', style: textStyleDarkHeavy24px700),
                    verticalSpace(28.0),
                    emailField(),
                    verticalSpace(28.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SplitBillScreen()));
                        },
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
                child: Image.asset(Images.kImageDialog, height: 150.0),
              ),
            ],
          );
        });
  }

}
