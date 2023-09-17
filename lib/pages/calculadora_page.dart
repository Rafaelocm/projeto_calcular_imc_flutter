import 'package:app_estudos_flutter/model/informacoes_pessoais_calculo.dart';
import 'package:app_estudos_flutter/repositories/informacoes_pessoais_repository.dart';
import 'package:app_estudos_flutter/shared/widgets/app_floating_action_button.dart';
import 'package:app_estudos_flutter/shared/widgets/app_images.dart';
import 'package:app_estudos_flutter/shared/widgets/app_alert_dialog.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_button.dart';
import 'package:app_estudos_flutter/shared/widgets/text.dart';
import 'package:app_estudos_flutter/shared/widgets/app_text_field.dart';
import 'package:app_estudos_flutter/shared/widgets/app_cores.dart';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  var informarcoesRepository = InformacoesPessoaisRepository();
  List<InformacoesPessoais> informacoesPessoais = [];
  var nomeController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var pesoController = TextEditingController(text: "");
  PageController pageController = PageController(initialPage: 0);
  double altura = 0;
  double peso = 0;
  String resultadoIMC = "";

  @override
  void initState() {
    super.initState();
    listarInformacoes();
  }

  void listarInformacoes() async {
    informacoesPessoais = await informarcoesRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCores.corPrimaria,
        title: const Text(
          "Calculadora IMC",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: AppFloatingActionButton(
        backgroundColor: AppCores.corSecundaria,
        icon: Icon(
          Icons.list,
          color: AppCores.corPrimaria,
        ),
        onPressed: () {
          if (informacoesPessoais.isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return const AppAlertDialog(
                    titulo: "Minha Calculadora",
                    texto: "Cadastre-se para verificar seu IMC",
                  );
                });
          } else {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    color: AppCores.corPrimaria,
                    child: ListView.builder(
                        itemCount: informacoesPessoais.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var informacoes = informacoesPessoais[index];
                          return Dismissible(
                            onDismissed: (direction) {
                              setState(() {
                                informarcoesRepository
                                    .removerInformacoes(informacoes);
                                informacoesPessoais.removeAt(index);
                              });
                            },
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            key: Key(informacoes.id.toString()),
                            direction: DismissDirection.startToEnd,
                            child: Wrap(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Olá ${informacoes.nome}, segue informações:",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "Altura: ${informacoes.altura}\nPeso: ${informacoes.peso}\nResultado IMC: ${informacoes.resultadoIMC}",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                });
          }
        },
      ),
      backgroundColor: AppCores.corPrimaria,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(AppImages.imageCalculadora, height: 150)),
              const AppTexto(texto: "Seja bem vindo a CalculadoraIMC"),
              AppTextField(
                obscuretext: false,
                texto: "Nome",
                controller: nomeController,
              ),
              AppTextField(
                obscuretext: false,
                textInputType: TextInputType.number,
                texto: "Altura",
                controller: alturaController,
              ),
              AppTextField(
                obscuretext: false,
                textInputType: TextInputType.number,
                texto: "Peso",
                controller: pesoController,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: AppTextButton(
                  onPressed: () async {
                    if (nomeController.text.isEmpty ||
                        nomeController.text.length > 10 ||
                        pesoController.text.isEmpty ||
                        alturaController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return const AppAlertDialog(
                            titulo: "Calculadora IMC",
                            texto: "Verifique os campos de informacões",
                          );
                        },
                      );
                    } else {
                      try {
                        altura = double.parse(alturaController.text);
                        peso = double.parse(pesoController.text);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return const AppAlertDialog(
                              titulo: "Calculadora IMC",
                              texto:
                                  "Verifique os campos de altura e peso, lembrando que só aceitamos valores númericos",
                            );
                          },
                        );
                        return;
                      }
                      if (altura == 0 || peso == 0) {
                        return;
                      } else {
                        setState(() {
                          informarcoesRepository.salvar(
                            InformacoesPessoais(0, nomeController.text, peso,
                                altura, resultadoIMC),
                          );
                          listarInformacoes();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Sucesso nas informações, clique no ícone ao lado para ver o resultado do seu cliente",
                            style: TextStyle(
                                fontSize: 16, color: Colors.blue[600]),
                          ),
                          backgroundColor: Colors.white,
                        ));
                        nomeController.clear();
                        pesoController.clear();
                        alturaController.clear();
                      }
                    }
                  },
                  color: AppCores.corSecundaria,
                  colorText: Colors.white,
                  label: "CALCULAR",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
