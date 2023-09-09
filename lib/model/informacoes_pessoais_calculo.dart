import 'package:flutter/material.dart';

class InformacoesPessoais {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _peso = 0;
  double _altura = 0;
  String _resultadoIMC = "";
  double _resultadoIMCValor = 0;

  InformacoesPessoais(this._nome, this._peso, this._altura);

  String get id => _id;
  String get nome => _nome;
  double get peso => _peso;
  double get altura => _altura;
  double get resultadoIMCValor => _resultadoIMCValor;
  String get resultadoIMC => _resultadoIMC;

  set nome(String nome) {
    _nome = nome;
  }

  set peso(double peso) {
    _peso = peso;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set resultadoIMC(String resultadoIMC) {
    _resultadoIMC = resultadoIMC;
  }

  set resultadoIMCValor(double resultadoIMCValor) {
    _resultadoIMCValor = resultadoIMCValor;
  }
}
