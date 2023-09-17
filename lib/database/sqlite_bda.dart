import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: 'CREATE TABLE IF NOT EXISTS informacoes(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, peso REAL, altura REAL, resultadoIMC TEXT);',
  2: 'CREATE TABLE IF NOT EXISTS usuario(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, senha TEXT);'
};

class SQLiteBDA {
  static Database? db;
  Future<Database> iniciarBancoDeDados() async {
    var db = openDatabase(
      path.join(await getDatabasesPath(), 'database_app_calc'),
      version: scripts.length,
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint(scripts[i]!);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          await db.execute(scripts[newVersion]!);
          debugPrint(scripts[i]!);
        }
      },
    );
    return db;
  }

  Future<Database> obterBancoDeDados() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }
}
