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
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(top: 5,left: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
