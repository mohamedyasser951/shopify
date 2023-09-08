import 'package:flutter/material.dart';

class ErrorItem extends StatelessWidget {
  final String errorMessage;
  const ErrorItem({super.key,required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
