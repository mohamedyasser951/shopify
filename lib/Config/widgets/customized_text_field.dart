import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  const CustomeTextField({
    Key? key,
    required this.textEditingController,
    this.validator,
    required this.hintText,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: textEditingController,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(top: 5, left: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
