import 'package:flutter/material.dart';

class XMColor {
  static Color themeColor = const Color(0xff019EDB);

  static Color darkThemeColor = const Color(0xff0074BD);

  static Color contentColor = const Color(0xffF8F8F8);

  static Color navColor = Colors.white;

  static Color grayColor = const Color(0xff999999);

  static Color blueColor = const Color(0xff1DACFF);

  static Color get modelBgColor => const Color.fromRGBO(0, 0, 0, .4);

  static Color lineColor = const Color(0xffE6E6E6);

  //keep
  static Color deepGray = const Color(0xff564f5f);
  static Color kgray = const Color(0xff999999);
  static Color lightGray = const Color(0xff9a9a9a);
  static Color bgGray = const Color(0xfffafafa);
  static Color black_3 = const Color(0xff333333);
  static Color vipColor = const Color(0xffefd297);

  static Color paper = const Color(0xFFF5F5F5);
  static Color darkGray = const Color(0xFF333333);
  static Color gray = const Color(0xFF888888);

  static Color getColor(List rgbs) {
    return Color.fromARGB(1, rgbs[0], rgbs[1], rgbs[2]);
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}