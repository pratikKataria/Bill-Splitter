import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_screen.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseScreen extends StatefulWidget {
  final String name;

  const AddExpenseScreen(this.name, {Key key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  List<Expenses> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(20.0),
            header(),
            Container(
              margin: EdgeInsets.only(left: 40.0, top: 20.0),
              child: Text("${widget?.name} (${totalExpense()} Rs.)", style: textStyleDarkHeavy24px700),
            ),
            verticalSpace(10.0),
            Row(
              children: [
                horizontalSpace(40.0),
                Text("Expenses", style: mainTextStyle),
                Spacer(),
                InkWell(
                    onTap: () {
                      expenses.add(Expenses());
                      setState(() {});
                    },
                    child: Text("+ New", style: textStyleRedRegular14px700w)),
                horizontalSpace(20.0),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ...expenses
                      .map((e) => Container(
                            padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 20.0),
                            margin: EdgeInsets.only(left: 40.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.colorSecondaryLight,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorPrimaryLight,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text("Title", style: mainTextStyle),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          obscureText: false,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          textCapitalization: TextCapitalization.none,
                                          style: subTextStyle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter title",
                                            hintStyle: subTextStyle,
                                            isDense: true,
                                            suffixStyle: TextStyle(color: AppColors.textColor),
                                          ),
                                          onChanged: (String val) {
                                            e.label = val;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpace(10.0),
                                verticalSpace(10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 60.0,
                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorPrimaryLight,
                                          borderRadius: BorderRadius.circular(6.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            verticalSpace(8.0),
                                            Text("Quantity", style: mainTextStyle),
                                            Expanded(
                                              child: TextFormField(
                                                obscureText: false,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                textCapitalization: TextCapitalization.none,
                                                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                                keyboardType: TextInputType.number,
                                                style: subTextStyle,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "def: 1",
                                                  hintStyle: subTextStyle,
                                                  isDense: true,
                                                  suffixStyle: TextStyle(color: AppColors.textColor),
                                                ),
                                                onChanged: (String val) {
                                                  try {
                                                    e.qty = int.parse(val);
                                                  } catch (e) {
                                                    e.qty = 0;
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(10.0),
                                    Expanded(
                                      child: Container(
                                        height: 60.0,
                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorPrimaryLight,
                                          borderRadius: BorderRadius.circular(6.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            verticalSpace(8.0),
                                            Text("Price", style: mainTextStyle),
                                            Expanded(
                                              child: TextFormField(
                                                obscureText: false,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                textCapitalization: TextCapitalization.none,
                                                style: subTextStyle,
                                                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Enter Price",
                                                  hintStyle: subTextStyle,
                                                  isDense: true,
                                                  suffixStyle: TextStyle(color: AppColors.textColor),
                                                ),
                                                onChanged: (String val) {
                                                  try {
                                                    e.cost = int.parse(val);
                                                  } catch (e) {
                                                    e.price = 0;
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, expenses);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimaryLight,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 45.0,
                  width: 200.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(child: Text("Add", style: textStylePrimary16px700w)),
                ),
              ),
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  int totalExpense() {
    int totalExpense = 0;
    expenses.forEach((element) {
      totalExpense += (element.cost * element.qty);
    });
    return totalExpense;
  }

  Container header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SplitBillScreen("")));
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
