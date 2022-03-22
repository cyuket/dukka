import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class FlushBarNotification {
  static Future<void> showError({
    required BuildContext context,
    required String message,
  }) {
    return Flushbar<dynamic>(
      flushbarPosition: FlushbarPosition.TOP,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      borderRadius: BorderRadius.circular(7),
    ).show(context);
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String message,
  }) {
    return Flushbar<dynamic>(
      flushbarPosition: FlushbarPosition.TOP,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      borderRadius: BorderRadius.circular(7),
    ).show(context);
  }

  static dynamic showInfoMessage({
    required BuildContext context,
    String title = '',
    required String message,
  }) {
    FlushbarHelper.createInformation(
      message: message,
      title: title,
    ).show(context);
  }
}
