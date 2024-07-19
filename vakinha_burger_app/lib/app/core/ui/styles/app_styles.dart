import 'package:flutter/material.dart';

import 'colors_app.dart';
import 'text_style.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self instance
  AppStyles._();
  static AppStyles get i => _instance ??= AppStyles._();

  ButtonStyle get primartButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextStyles.i.textButtonLabel.copyWith(color: Colors.white),
      );
}

extension AppStylesExtensions on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
