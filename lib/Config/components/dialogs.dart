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
  sucessDialog(
      {required String title,
      required String description,
      required BuildContext context}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    );
  }
}
