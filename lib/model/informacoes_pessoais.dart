import 'package:flutter/material.dart';

class InformacoesPessoais {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _peso = 0;
  double _altura = 0;
  double _resultadoIMC = 0;

  InformacoesPessoais(this._nome, this._peso, this._altura, this._resultadoIMC);

  String get id => _id;
  String get nome => _nome;
  double get peso => _peso;
  double get altura => _altura;
  double get resultadoIMC => _resultadoIMC;

  set nome(String nome) {
    _nome = nome;
  }

  set peso(double peso) {
    _peso = peso;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set resultadoIMC(double resultadoIMC) {
    _resultadoIMC = resultadoIMC;
  }
}
