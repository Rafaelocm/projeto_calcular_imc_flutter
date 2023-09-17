import 'package:app_estudos_flutter/database/sqlite_bda.dart';
import 'package:app_estudos_flutter/model/informacoes_pessoais_calculo.dart';

class InformacoesPessoaisRepository {
  Future<List<InformacoesPessoais>> obterDados() async {
    List<InformacoesPessoais> informacoes = [];
    var db = await SQLiteBDA().obterBancoDeDados();
    var infor = await db.rawQuery(
        'SELECT id, nome, peso, altura, resultadoIMC FROM informacoes');

    for (var element in infor) {
      informacoes.add(InformacoesPessoais(
        int.parse(element["id"].toString()),
        element["nome"].toString(),
        double.parse(element["peso"].toString()),
        double.parse(element["altura"].toString()),
        element["resultadoIMC"].toString(),
      ));
    }

    return informacoes;
  }

  Future<void> salvar(InformacoesPessoais informacoesPessoais) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    informacoesPessoais.verificarResultado();
    db.rawInsert(
        'INSERT INTO informacoes(nome, peso, altura, resultadoIMC) VALUES(?,?,?,?)',
        [
          informacoesPessoais.nome,
          informacoesPessoais.peso,
          informacoesPessoais.altura,
          informacoesPessoais.resultadoIMC
        ]);
  }

  Future<void> atualizar(InformacoesPessoais informacoesPessoais) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    db.rawUpdate(
        'UPDATE informacoes SET nome = ?, peso = ?, altura = ?, resultadoIMC = ? WHERE id = ?',
        [
          informacoesPessoais.nome,
          informacoesPessoais.peso,
          informacoesPessoais.altura,
          informacoesPessoais.resultadoIMC
        ]);
  }

  Future<void> removerInformacoes(
      InformacoesPessoais informacoesPessoais) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    db.rawDelete(
        'DELETE FROM informacoes WHERE id = ?', [informacoesPessoais.id]);
  }
}
