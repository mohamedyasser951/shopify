import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String hintText;
  const CustomeTextField({
    Key? key,
    required this.textEditingController,
    this.validator,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          // contentPadding: EdgeInsets.only(top: 5,left: 15),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }
}
