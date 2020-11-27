import 'package:fleetdownloader/appTheme.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget button(String label, Function onPressed,
      {Color textColor = Colors.white,
      Color btnColor = AppColor.primary,
      bool isSquare = false,
      bool isBold = false,
      double borderRadius = 49.0}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 44,
        width: 156,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(color: btnColor),
        child: Center(
          child: Text('$label',
              style: textStyle.copyWith(color: textColor, fontSize: 18)),
        ),
      ),
    );
  }
}
