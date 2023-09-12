import 'package:app_estudos_flutter/pages/page_um.dart';
import 'package:flutter/material.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    //Valores padrões de estilização para a aplicação
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      //Chama o HomePage na página principal
      home: const MyWidget(),
    );
  }
}
