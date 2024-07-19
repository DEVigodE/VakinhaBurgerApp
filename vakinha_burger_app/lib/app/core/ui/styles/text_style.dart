import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;
  // Avoid self instance
  TextStyles._();
  static TextStyles get i => _instance ??= TextStyles._();

  String get font => 'MPLUS1P';

  TextStyle get textTin => TextStyle(fontWeight: FontWeight.w100, fontFamily: font);

  TextStyle get textLight => TextStyle(fontWeight: FontWeight.w300, fontFamily: font);

  TextStyle get textRegular => TextStyle(fontWeight: FontWeight.normal, fontFamily: font);

  TextStyle get textMedium => TextStyle(fontWeight: FontWeight.w500, fontFamily: font);

  TextStyle get textSemiBold => TextStyle(fontWeight: FontWeight.w600, fontFamily: font);

  TextStyle get textBold => TextStyle(fontWeight: FontWeight.bold, fontFamily: font);

  TextStyle get textExtraBold => TextStyle(fontWeight: FontWeight.w800, fontFamily: font);

  TextStyle get textBlack => TextStyle(fontWeight: FontWeight.w900, fontFamily: font);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14, color: Colors.white);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
