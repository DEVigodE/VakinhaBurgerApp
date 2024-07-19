import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    final int length = message.length;
    if (length > 50) {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 3),
        CustomSnackBar.error(
          message: message,
          maxLines: 4,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white),
        ),
      );
    } else {
      showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: message));
    }
  }

  void showSuccess(String message) {
    final int length = message.length;
    if (length > 50) {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 3),
        CustomSnackBar.success(
          message: message,
          maxLines: 4,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white),
        ),
      );
    } else {
      showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: message));
    }
  }

  void showInfo(String message) {
    final int length = message.length;
    if (length > 50) {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 3),
        CustomSnackBar.info(
          message: message,
          maxLines: 4,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white),
        ),
      );
    } else {
      showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message: message));
    }
  }

  void showWarning(String message) {
    final int length = message.length;
    if (length > 50) {
      showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 3),
        CustomSnackBar.info(
          message: message,
          icon: const Icon(Icons.warning_rounded, color: Color(0x15000000), size: 120),
          backgroundColor: const Color(0xffE9D502),
          maxLines: 4,
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white),
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
          icon: const Icon(Icons.warning_rounded, color: Color(0x15000000), size: 120),
          backgroundColor: const Color(0xffE9D502),
        ),
      );
    }
  }
}
