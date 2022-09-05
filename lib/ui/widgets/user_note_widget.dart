

import 'package:bill_splitter/res/AppColors.dart';
import 'package:bill_splitter/res/Fonts.dart';
import 'package:bill_splitter/util/Utility.dart';
import 'package:flutter/material.dart';

class UserNoteWidget extends StatelessWidget {
  const UserNoteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorPrimaryLight,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.flag, color: AppColors.colorSecondary),
          horizontalSpace(10.0),
          Expanded(
            child: Text(
              "User with Split It account would be able To see their split, Others user are added as guest",
              style: textStyleSecondary12px600w,
            ),
          )
        ],
      ),
    );
  }
}
