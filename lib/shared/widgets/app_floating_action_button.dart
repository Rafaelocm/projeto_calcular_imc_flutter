import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton(
      {super.key,
      required this.icon,
      this.backgroundColor,
      this.mini = false,
      required this.onPressed});
  final Icon? icon;
  final Color? backgroundColor;
  final bool mini;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
