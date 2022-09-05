import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/addExpense/add_expense.dart';
import 'package:bill_splitter/ui/core/signup/model/user_response.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_presenter.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_view.dart';
import 'package:bill_splitter/ui/widgets/user_note_widget.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

class SplitBillScreen extends StatefulWidget {
  final String groupName;

  const SplitBillScreen(this.groupName, {Key key}) : super(key: key);

  @override
  State<SplitBillScreen> createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> implements SplitBillView {
  final subTextStyle = textStyleSubText12px500w;
  final mainTextStyle = textStyle12px500w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  List<GuestFriend> firends = [];
  List<UserResponse> listOfUserss = [];
  SplitRequest splitRequest = SplitRequest();

  SplitBillPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = SplitBillPresenter(this);
    presenter.getAllUsers(context);
    addGroupMetaData();
  }

  Future<void> addGroupMetaData() async {
    splitRequest.groupName = widget?.groupName;
    splitRequest.createdby = (await AuthUser().getCurrentUser()).userCredentials.name;
    splitRequest.totalPeople = 1;
    splitRequest.groupTotal = 0;
    splitRequest.splitPerHead = 0;
  }

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
                          Text("${widget.groupName}", style: textStyle14px500w),
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
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(24.0), topLeft: Radius.circular(24.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total bill", style: textStyleRegular16px500px),
                            Text("${calculateTotalBill()} Rs", style: textStyleDarkHeavy24px700),
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
                Text("${((firends?.length) ?? 0)}", style: textStyleDarkHeavy24px700),
                Text(" People", style: textStyleRegular16px500px),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                horizontalSpace(45.0),
                Text("Split per head", style: textStyle12px500w),
                horizontalSpace(6.0),
                Text("${(calculateTotalBill() / ((firends?.length == 0 ? 1 : firends.length))).toStringAsFixed(2)} Rs.",
                    style: textStyleDarkHeavy18px700),
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
                    child: Text("+ New", style: textStyleRedRegular14px700w)),
                horizontalSpace(20.0),
              ],
            ),
            verticalSpace(20.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 40.0),
                child: ListView(
                  children: [
                    ...firends
                        .map((e) => Container(
                              padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 20.0),
                              margin: EdgeInsets.only(bottom: 20.0),
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
                                      Text("${e?.name ?? ""}", style: textStyleDark16px600w),
                                      InkWell(
                                        onTap: () async {
                                          List<Expenses> exp = await Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => AddExpenseScreen(e.name)));
                                          if (e.expenses == null) e.expenses = [];
                                          e.expenses.addAll(exp);
                                          print("${e.expenses}");
                                          setState(() {});
                                        },
                                        child: Text("+ Expense", style: textStyleSecondary12px700w),
                                      ),
                                    ],
                                  ),
                                  ...e?.expenses
                                          ?.map((ex) => Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${ex.label}", style: textStyle12px500w),
                                                  Text("${ex.cost} / ${ex.qty} Qty", style: textStyleSecondary12px700w),
                                                ],
                                              ))
                                          ?.toList() ??
                                      [],
                                  verticalSpace(5.0),
                                  line(),
                                  verticalSpace(5.0),
                                  Row(
                                    children: [
                                      Text("Per head", style: textStyle12px500w),
                                      Spacer(),
                                      Text(
                                          "${(calculateTotalBill() / ((firends?.length == 0 ? 1 : firends.length))).toStringAsFixed(2)} Rs.",
                                          style: textStylePrimary14px600w),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  splitRequest.guestFriend = firends;
                  splitRequest.groupTotal = calculateTotalBill();
                  splitRequest.splitPerHead =
                      double.parse((calculateTotalBill() / (firends.length)).toStringAsFixed(2));
                  splitRequest.totalPeople = firends.length;
                  presenter.createGroup(context, splitRequest);
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

  int calculateTotalBill() {
    int total = 0;
    if (firends != null) {
      firends.forEach((element) {
        if (element.expenses == null || element.expenses.isEmpty) {
          return;
        }

        element.expenses.forEach((element) {
          total += (element.cost * element.qty);
        });
      });
    }

    return total;
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
        builder: (
          builder,
        ) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState2) {
            return Stack(
              children: [
                AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: Duration(milliseconds: 400),
                  child: Container(
                    height: Utility.screenHeight(context) * 0.50,
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
                        Text('Add from Accounts', style: textStyle14px500w),
                        verticalSpace(10.0),
                        Container(
                          height: 40.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...listOfUserss
                                  .map((e) => InkWell(
                                        onTap: () {
                                          String s = e.name;
                                          bool contains = firends.any((item) => item.name == s);
                                          GuestFriend guestFriend = GuestFriend();
                                          guestFriend.name = s;
                                          guestFriend.uid = e.uid;

                                          if (contains)
                                            Utility.showErrorToastB(context, "Already added");
                                          else
                                            firends.insert(0, guestFriend);

                                          setState2(() {});
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                          margin: EdgeInsets.only(right: 20.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.colorPrimaryLight,
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                          child: Center(child: Text("${e?.name}", style: textStyle12px500w)),
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                        verticalSpace(20.0),
                        Text('Add by name', style: textStyle14px500w),
                        verticalSpace(10.0),
                        emailField(setState2),
                        verticalSpace(20.0),
                        Text('Added', style: textStyle14px500w),
                        verticalSpace(10.0),
                        Container(
                          height: 40.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...firends
                                  .map((e) => Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                        margin: EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorSecondaryLight,
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(e?.name ?? "", style: textStyle12px500w),
                                              horizontalSpace(10.0),
                                              InkWell(
                                                onTap: () {
                                                  firends.remove(e);
                                                  setState2(() {});
                                                  setState(() {});
                                                },
                                                child: Icon(Icons.remove_circle_outline_rounded,
                                                    color: AppColors.colorSecondary, size: 24.0),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                        verticalSpace(20.0),
                        // Center(
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: AppColors.colorPrimaryLight,
                        //         borderRadius: BorderRadius.circular(12.0),
                        //       ),
                        //       height: 45.0,
                        //       width: 200.0,
                        //       padding: EdgeInsets.symmetric(horizontal: 20.0),
                        //       child: Center(child: Text("Create", style: textStylePrimary16px700w)),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: Image.asset(Images.kImageAddFriend, height: 150.0),
                ),
              ],
            );
          });
        });
  }

  Container emailField(StateSetter setState2) {
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
          InkWell(
            onTap: () {
              String s = emailTextController.text.toString();
              bool contains = firends.any((item) => item.name == s);
              GuestFriend guestFriend = GuestFriend();
              guestFriend.name = s;

              if (contains)
                Utility.showErrorToastB(context, "Already added");
              else
                firends.insert(0, guestFriend);

              emailTextController.clear();
              setState2(() {});
              setState(() {});
            },
            child: Container(
              color: AppColors.colorPrimaryLight,
              child: Icon(Icons.add),
            ),
          ),
          horizontalSpace(10.0),
        ],
      ),
    );
  }

  @override
  void onError(String message) {}

  @override
  void onAllUserFetched(List<UserResponse> listOfUsers) {
    listOfUserss.clear();
    listOfUserss.addAll(listOfUsers);
    setState(() {});
  }
}
