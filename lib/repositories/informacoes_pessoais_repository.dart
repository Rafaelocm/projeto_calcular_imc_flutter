import 'package:app_estudos_flutter/model/informacoes_pessoais.dart';

class InformacoesPessoaisRepository {
  List<InformacoesPessoais> informacoes = [];

  Future<void> adicionarPessoas(InformacoesPessoais informacoesPessoais) async {
    await Future.delayed(const Duration(milliseconds: 100));
    informacoes.add(informacoesPessoais);
  }

  Future<void> alterarInformacoes(String id, double peso, double altura) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var informacoesId = informacoes.firstWhere((infor) => infor.id == id);
    informacoesId.altura = altura;
    informacoesId.peso = peso;
  }

  Future<void> removerInformacoes(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    informacoes.removeWhere((infor) => infor.id == id);
  }

  Future<List<InformacoesPessoais>> listarInformacoes() async {
    Future.delayed(const Duration(milliseconds: 100));
    return informacoes;
  }
}
