import 'package:app_estudos_flutter/database/sqlite_bda.dart';
import 'package:app_estudos_flutter/model/cadastro_usuario.dart';

class CadastroUsuarioRepository {
  Future<List<CadastroUsuario>> obterDados() async {
    List<CadastroUsuario> cadastroUsuario = [];
    var db = await SQLiteBDA().obterBancoDeDados();
    var result = await db.rawQuery('SELECT id, email, senha FROM usuario');
    for (var usuario in result) {
      cadastroUsuario.add(CadastroUsuario(int.parse(usuario["id"].toString()),
          usuario["email"].toString(), usuario["senha"].toString()));
    }
    return cadastroUsuario;
  }

  Future<void> salvar(CadastroUsuario cadastroUsuario) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    db.rawInsert('INSERT INTO usuario(email, senha) VALUES(?,?)', [
      cadastroUsuario.email,
      cadastroUsuario.senha,
    ]);
  }

  Future<void> atualizar(CadastroUsuario cadastroUsuario) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    db.rawUpdate('UPDATE usuario SET email = ?, senha = ? WHERE id = ?',
        [cadastroUsuario.email, cadastroUsuario.senha]);
  }

  Future<void> deletar(CadastroUsuario cadastroUsuario) async {
    var db = await SQLiteBDA().obterBancoDeDados();
    db.rawDelete('DELETE FROM usuario WHERE id = ?', [cadastroUsuario.id]);
  }
}
