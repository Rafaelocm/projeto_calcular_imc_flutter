import 'package:flutter/material.dart';

class AppTexto extends StatelessWidget {
  const AppTexto({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700));
  }
}
