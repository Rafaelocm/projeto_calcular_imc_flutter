class InformacoesPessoais {
  int _id = 0;
  String _nome = "";
  double _peso = 0;
  double _altura = 0;
  String _resultadoIMC = "";
  double _resultadoIMCValor = 0;

  InformacoesPessoais(
      this._id, this._nome, this._peso, this._altura, this._resultadoIMC);

  int get id => _id;
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

  set id(int id) {
    _id = id;
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

  void verificarResultado() {
    _resultadoIMCValor = _peso / (_altura * _altura);
    if (_resultadoIMCValor < 18.5) {
      _resultadoIMC = "Abaixo do peso";
    } else if (_resultadoIMCValor >= 18.6 && _resultadoIMCValor <= 24.9) {
      _resultadoIMC = "Peso ideial (parabéns)";
    } else if (_resultadoIMCValor >= 25 && _resultadoIMCValor <= 29.9) {
      _resultadoIMC = "Levemente acima do peso";
    } else if (_resultadoIMCValor >= 30 && _resultadoIMCValor <= 34.9) {
      _resultadoIMC = "Obesidade grau I";
    } else if (_resultadoIMCValor >= 35 && _resultadoIMCValor <= 39.9) {
      _resultadoIMC = "Obesidade grau II(severa)";
    } else if (_resultadoIMCValor >= 40) {
      _resultadoIMC = "Obesidade III (mórbida)";
    }
  }
}
