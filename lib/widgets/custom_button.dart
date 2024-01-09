import 'package:flutter/material.dart';
import 'package:taskproject/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.onTap,
    this.height,
    required this.title,
    this.bgColor,
    this.textColor,
  });

  final double width;
  final VoidCallback onTap;
  final double? height;
  final String title;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: onTap,
      child: Ink(
        width: width,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          border: Border.all(color: AppColors.primaryColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
