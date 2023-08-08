import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final void Function()? onPressed;
  final Color color;
  final double width;

  const CustomButton(
      {super.key,
      required this.widget,
      required this.onPressed,
      this.width = double.infinity,
      this.color = const Color(0xFFDB3022)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: onPressed,
        child: widget
      ),
    );
  }
}
