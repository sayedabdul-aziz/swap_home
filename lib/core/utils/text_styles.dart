import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle headline({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
        fontSize: fontSize ?? 18, color: color, fontWeight: fontWeight);
  }

  static TextStyle title({
    Color? color,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
        fontSize: fontSize ?? 15, color: color, fontWeight: fontWeight);
  }

  static TextStyle body({
    Color? color,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
        fontSize: fontSize ?? 14, color: color, fontWeight: fontWeight);
  }

  static TextStyle small({
    Color? color,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
        fontSize: fontSize ?? 12, color: color, fontWeight: fontWeight);
  }
}
