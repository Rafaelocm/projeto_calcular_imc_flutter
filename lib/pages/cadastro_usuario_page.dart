import 'package:app_estudos_flutter/model/cadastro_usuario.dart';
import 'package:app_estudos_flutter/pages/login_page.dart';
import 'package:app_estudos_flutter/repositories/cadastro_usuario_repository.dart';
import 'package:app_estudos_flutter/shared/widgets/app_cores.dart';
import 'package:app_estudos_flutter/shared/widgets/app_images.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_button.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_field.dart';
import 'package:app_estudos_flutter/shared/widgets/text.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioPage extends StatefulWidget {
  const CadastroUsuarioPage({super.key});

  @override
  State<CadastroUsuarioPage> createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  CadastroUsuarioRepository cadastroUsuarioRepository =
      CadastroUsuarioRepository();
  var cadastroUsuario = <CadastroUsuario>[];
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController senhaController = TextEditingController(text: "");
  bool emailCadastrado = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    cadastroUsuario = await cadastroUsuarioRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppCores.corPrimaria,
        title: const Text(
          "Calculadora IMC",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: AppCores.corPrimaria,
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
              const AppTexto(texto: "Realize o seu cadastro"),
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
                  label: "Salvar",
                  color: AppCores.corSecundaria,
                  colorText: Colors.white,
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        senhaController.text.length > 8) {
                      if (cadastroUsuario.isNotEmpty) {
                        for (var element in cadastroUsuario) {
                          if (emailController.text.toLowerCase() ==
                              element.email) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Email já cadastrado",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red)),
                              backgroundColor: Colors.white,
                            ));
                            emailController.clear();
                            senhaController.clear();
                            return;
                          }
                        }
                        await cadastroUsuarioRepository.salvar(CadastroUsuario(
                            0, emailController.text, senhaController.text));
                        carregarDados();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Usuario cadastrado com sucesso",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue)),
                          backgroundColor: Colors.white,
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      } else {
                        await cadastroUsuarioRepository.salvar(CadastroUsuario(
                            0, emailController.text, senhaController.text));
                        carregarDados();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Usuario cadastrado com sucesso",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue)),
                          backgroundColor: Colors.white,
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("verifique os campos informados",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                        backgroundColor: Colors.white,
                      ));
                    }
                  },
                ),
              ),
              AppTextButton(
                label: "voltar",
                colorText: AppCores.corSecundaria,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext bc) {
                      return const LoginPage();
                    },
                  ));
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
