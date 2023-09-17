class CadastroUsuario {
  int _id = 0;
  String _email = "";
  String _senha = "";

  CadastroUsuario(this._id, this._email, this._senha);

  int get id => _id;

  String get email => _email;

  String get senha => _senha;

  set id(int id) {
    _id = id;
  }

  set email(String email) {
    _email = email;
  }

  set senha(String senha) {
    _senha = senha;
  }
}
