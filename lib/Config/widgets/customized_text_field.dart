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
      height: 75,
      child: TextFormField(
        autocorrect: true,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        controller: textEditingController,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black, fontSize: 18),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
