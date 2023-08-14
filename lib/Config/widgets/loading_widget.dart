import 'package:commerceapp/Config/constants/colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: AppColors.grayColor),
    );
  }
}
