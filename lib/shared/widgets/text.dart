import 'package:flutter/material.dart';

class Texto extends StatelessWidget {
  const Texto({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Text(texto,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }
}
