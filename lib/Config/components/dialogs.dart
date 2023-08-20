import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void snackBarWidget(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
  ));
}

class CustomDialog {
  static animatedDialog(
      {required String title,
      required String description,
      bool isError = true,
      required BuildContext context}) {
    return AwesomeDialog(
      context: context,
      dialogType: isError ? DialogType.error : DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      btnCancelOnPress: isError ? () {} : null,
      btnOkOnPress: isError ? null : () {},
    )..show();
  }
}
