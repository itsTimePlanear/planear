import 'package:flutter/cupertino.dart';

class AppSizes {
  AppSizes._();
  static double ratioOfHorizontal(BuildContext context, double i) {
    //가로 비율
    return MediaQuery.of(context).size.width * i;
  }

  static double ratioOfVertical(BuildContext context, double i) {
    //세로 비율
    return MediaQuery.of(context).size.height * i;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
