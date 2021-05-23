import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: CustomColors.PrimaryColor,
      accentColor: CustomColors.PrimaryColor,
    );
  }

  // 4
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
      accentColor: CustomColors.PrimaryColor,
    );
  }
}
