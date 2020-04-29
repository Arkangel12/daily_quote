import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:flutter/material.dart';

class ImageStatusWidget extends StatelessWidget {
  final String message;

  const ImageStatusWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.pinkLight,
        ),
        child: Text(
          message,
          style: AppStyles.smallBodySemiBold.apply(color: AppColors.white),
        ),
      ),
    );
  }
}