

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
      padding: EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.flag, color: AppColors.colorSecondary),
          horizontalSpace(10.0),
          Expanded(
            child: Text(
              "User with Bill splitter account would be able To see their split others are added as guest",
              style: textStyleSecondary12px600w,
            ),
          )
        ],
      ),
    );
  }
}
