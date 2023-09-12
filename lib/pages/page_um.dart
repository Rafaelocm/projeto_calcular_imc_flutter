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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var informarcoesRepository = InformacoesPessoaisRepository();
  List<InformacoesPessoais> informacoesPessoais = [];
  var nomeController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var pesoController = TextEditingController(text: "");
  PageController pageController = PageController(initialPage: 0);
  double altura = 0;
  double peso = 0;
  int page = 0;

  @override
  void initState() {
    super.initState();
    listarInformacoes();
  }

  void listarInformacoes() async {
    informacoesPessoais = await informarcoesRepository.listarInformacoes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCores.corPrimaria,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Calculadora IMC",
              textAlign: TextAlign.center,
            ),
          ],
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
                          return Wrap(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.white,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppFloatingActionButton(
                                          icon: Icon(Icons.delete,
                                              color: AppCores.corSecundaria),
                                          mini: true,
                                          backgroundColor: AppCores.corPrimaria,
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return AppAlertDialog(
                                                    titulo: "Calculadora IMC",
                                                    texto:
                                                        "Tem certeza? Feche e abra novamente a lista para atualizar os cadastros",
                                                    actions: [
                                                      TextButton(
                                                          child: const Text(
                                                            "Cancelar",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 16),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      TextButton(
                                                          child: const Text(
                                                            "confimar",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          onPressed: () async {
                                                            await informarcoesRepository
                                                                .removerInformacoes(
                                                                    informacoes
                                                                        .id);
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ],
                                                  );
                                                });
                                          }),
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
                                              "Altura: ${informacoes.altura}\nPeso: ${informacoes.peso}\nResultado IMC: ${informacoes.resultadoIMC}\nValor do IMC: ${informacoes.resultadoIMCValor.roundToDouble()}",
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
                texto: "Nome",
                controller: nomeController,
              ),
              AppTextField(
                textInputType: TextInputType.number,
                texto: "Altura",
                controller: alturaController,
              ),
              AppTextField(
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
                        await informarcoesRepository.adicionarPessoas(
                          InformacoesPessoais(
                              nomeController.text, peso, altura),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return const AppAlertDialog(
                              titulo: "Calculadora IMC",
                              texto:
                                  "Cadastrado com sucesso, para visualizar clique no ícone ao canto inferior direito",
                            );
                          },
                        );
                        setState(() {});
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
