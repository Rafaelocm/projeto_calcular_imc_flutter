import 'package:app_estudos_flutter/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //Utilizado para carregar os binds do flutter
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Myapp());
}
