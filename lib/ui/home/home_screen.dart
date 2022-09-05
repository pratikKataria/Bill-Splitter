import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/res/Images.dart';
import 'package:bill_splitter/ui/core/login/login_screen.dart';
import 'package:bill_splitter/ui/home/home_presenter.dart';
import 'package:bill_splitter/ui/splitBill/model/split_request.dart';
import 'package:bill_splitter/ui/splitBill/split_bill_screen.dart';
import 'package:bill_splitter/ui/viewSplit/view_split_screen.dart';
import 'package:bill_splitter/ui/widgets/user_note_widget.dart';
import 'package:bill_splitter/user/AuthUser.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  final TextEditingController groupTextController = TextEditingController();

  String userName = "";
  HomePresenter presenter;
  List<SplitRequest> listOfGroups = [];

  @override
  void initState() {
    super.initState();
    getUserName();
    presenter = HomePresenter(this);
    presenter.getAllGroups();
  }

  Future<void> getUserName() async {
    userName = (await AuthUser.getInstance().getCurrentUser())?.userCredentials?.name;
    setState(() {});
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
            verticalSpace(5.0),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10.0),
                          Text("Welcome", style: textStylePrimary22px700w),
                          Text("${userName}", style: textStyle14px500w),
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    Container(
                      height: 90.0,
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
                          Text("${calcTotalBalance()} Rs.", style: textStyleDarkHeavy24px700),
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
                    ...listOfGroups
                        .map((e) => InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewScreen(e)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${e?.groupName}", style: textStyleSubText14px600w),
                                        Text("${e?.groupTotal}", style: textStyle14px500w),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${e?.totalPeople} people added to the split", style: textStyle14px500w),
                                        Text("${e?.splitPerHead} Rs./head", style: textStyle14px500w),
                                      ],
                                    ),
                                    Text("Group created by ${e?.createdby}", style: textStyle14px500w),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
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
                  InkWell(
                    onTap: () {
                      logout();
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(Images.kIconPerson, height: 34.0),
                          verticalSpace(5.0),
                          Text("Account", style: textStylePrimary14px500w),
                        ],
                      ),
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

  int calcTotalBalance() {
    int total = 0;
    if (listOfGroups.isNotEmpty) {
      listOfGroups.forEach((element) {
        total += element.groupTotal;
      });
    }
    return total;
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Stack(
            children: [
              AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: Duration(milliseconds: 400),
                child: Container(
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SplitBillScreen(groupTextController.text.toString())));
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
              ),
              Positioned(
                right: 0.0,
                child: Image.asset(Images.kImageDialog, height: 150.0),
              ),
            ],
          );
        });
  }

  void logout() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Stack(
            children: [
              Container(
                height: Utility.screenHeight(context) * 0.20,
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
                    Text('${userName}', style: textStyleDarkHeavy24px700),
                    verticalSpace(28.0),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          await AuthUser.getInstance().logout();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimaryLight,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          height: 45.0,
                          width: 200.0,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Center(child: Text("Logout", style: textStylePrimary16px700w)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: Image.asset(Images.kImageLogout, height: 150.0),
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
            width: 50,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Group", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: groupTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter group name",
                hintStyle: subTextStyle,
                isDense: true,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onAllGroupsFetched(List<SplitRequest> listOfUsers) {
    listOfGroups.clear();
    listOfGroups.addAll(listOfUsers);
    setState(() {});
  }

  @override
  void onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
