import 'package:app_estudos_flutter/model/cadastro_usuario.dart';
import 'package:app_estudos_flutter/pages/cadastro_usuario_page.dart';
import 'package:app_estudos_flutter/pages/calculadora_page.dart';
import 'package:app_estudos_flutter/repositories/cadastro_usuario_repository.dart';
import 'package:app_estudos_flutter/shared/widgets/app_cores.dart';
import 'package:app_estudos_flutter/shared/widgets/app_images.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_button.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_field.dart';
import 'package:app_estudos_flutter/shared/widgets/text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usuarioCadastrado = <CadastroUsuario>[];
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController senhaController = TextEditingController(text: "");
  CadastroUsuarioRepository cadastroUsuarioRepository =
      CadastroUsuarioRepository();
  bool loginCorreto = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ObterDados();
  }

  Future<void> ObterDados() async {
    usuarioCadastrado = await cadastroUsuarioRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCores.corPrimaria,
      appBar: AppBar(
        backgroundColor: AppCores.corPrimaria,
        title: const Text("Calculadora IMC"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Image.asset(
                  AppImages.imageCalculadora,
                  height: 150,
                ),
              ),
              const AppTexto(texto: "Realize o seu Login"),
              AppTextField(
                  texto: "Email",
                  obscuretext: false,
                  controller: emailController),
              AppTextField(
                  texto: "Senha",
                  obscuretext: true,
                  controller: senhaController),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: AppTextButton(
                  label: "Entrar",
                  color: AppCores.corSecundaria,
                  colorText: Colors.white,
                  onPressed: () async {
                    ObterDados();
                    for (var element in usuarioCadastrado) {
                      if (emailController.text == element.email &&
                          senhaController.text == element.senha) {
                        loginCorreto = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Login realizado com sucesso")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CalculadoraPage(),
                            ));
                      }
                    }
                    emailController.clear();
                    senhaController.clear();
                    if (loginCorreto == false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Login/Senha incorreto")));
                      emailController.clear();
                      senhaController.clear();
                    }
                  },
                ),
              ),
              AppTextButton(
                label: "Cadastrar",
                colorText: AppCores.corSecundaria,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext bc) {
                      return const CadastroUsuarioPage();
                    },
                  ));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
