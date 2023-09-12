import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog(
      {super.key, this.titulo, this.texto, this.actions = const []});
  final String? titulo;
  final String? texto;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titulo!,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      content: Text(
        texto!,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      actions: actions.isNotEmpty
          ? actions
          : [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
    );
  }
}
