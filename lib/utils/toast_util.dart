import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastUtil {
  basic(String message, BuildContext context) {
    showToast(
      message,
      context: context,
      fullWidth: true,
      backgroundColor: const Color(0xB70FA958),
      duration: const Duration(seconds: 1),
      animation: StyledToastAnimation.none,
      animDuration: const Duration(microseconds: 1),
      textStyle: const TextStyle(fontSize: 10, color: Colors.white),
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  } //EX: ToastUtil().basic('message', context);
}
