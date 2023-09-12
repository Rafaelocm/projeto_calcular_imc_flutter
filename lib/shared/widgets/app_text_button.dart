import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.color,
      this.colorText});

  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: colorText),
        ),
      ),
    );
  }
}
