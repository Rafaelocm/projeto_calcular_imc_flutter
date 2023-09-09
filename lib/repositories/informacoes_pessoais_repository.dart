import 'package:app_estudos_flutter/model/informacoes_pessoais_calculo.dart';

class InformacoesPessoaisRepository {
  List<InformacoesPessoais> informacoes = [];

  Future<void> adicionarPessoas(InformacoesPessoais informacoesPessoais) async {
    await Future.delayed(const Duration(milliseconds: 300));
    verificarResultado(informacoesPessoais);
    informacoes.add(informacoesPessoais);
  }

  void verificarResultado(InformacoesPessoais informacoesPessoais) {
    informacoesPessoais.resultadoIMCValor = informacoesPessoais.peso /
        (informacoesPessoais.altura * informacoesPessoais.altura);
    if (informacoesPessoais.resultadoIMCValor < 18.5) {
      informacoesPessoais.resultadoIMC = "Abaixo do peso";
    } else if (informacoesPessoais.resultadoIMCValor >= 18.6 &&
        informacoesPessoais.resultadoIMCValor <= 24.9) {
      informacoesPessoais.resultadoIMC = "Peso ideial (parabéns)";
    } else if (informacoesPessoais.resultadoIMCValor >= 25 &&
        informacoesPessoais.resultadoIMCValor <= 29.9) {
      informacoesPessoais.resultadoIMC = "Levemente acima do peso";
    } else if (informacoesPessoais.resultadoIMCValor >= 30 &&
        informacoesPessoais.resultadoIMCValor <= 34.9) {
      informacoesPessoais.resultadoIMC = "Obesidade grau I";
    } else if (informacoesPessoais.resultadoIMCValor >= 35 &&
        informacoesPessoais.resultadoIMCValor <= 39.9) {
      informacoesPessoais.resultadoIMC = "Obesidade grau II(severa)";
    } else if (informacoesPessoais.resultadoIMCValor >= 40) {
      informacoesPessoais.resultadoIMC = "Obesidade III (mórbida)";
    }
  }

  Future<void> alterarInformacoes(String id, double peso, double altura) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var informacoesId = informacoes.firstWhere((infor) => infor.id == id);
    informacoesId.altura = altura;
    informacoesId.peso = peso;
  }

  Future<void> removerInformacoes(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    informacoes.removeWhere((infor) => infor.id == id);
  }

  Future<List<InformacoesPessoais>> listarInformacoes() async {
    Future.delayed(const Duration(milliseconds: 300));
    return informacoes;
  }
}
