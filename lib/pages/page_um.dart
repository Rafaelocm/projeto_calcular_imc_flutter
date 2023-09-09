import 'package:app_estudos_flutter/model/informacoes_pessoais.dart';

import 'package:app_estudos_flutter/repositories/informacoes_pessoais_repository.dart';
import 'package:app_estudos_flutter/shared/widgets/app_images.dart';
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
  double resultadoIMC = 0;
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
        backgroundColor: const Color.fromARGB(206, 74, 2, 122),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            if (informacoesPessoais.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      title: const Text(
                        "Calculadora IMC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      content: const Text(
                        "Cadastre-se para verificar seu IMC",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Ok",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ],
                    );
                  });
            } else {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      color: const Color.fromARGB(206, 74, 2, 122),
                      child: ListView.builder(
                          itemCount: informacoesPessoais.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var informacoes = informacoesPessoais[index];
                            return Wrap(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FloatingActionButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Calculadora IMC",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    content: const Text(
                                                      "Tem certeza? Feche e abra novamente a lista para atualizar os cadastros",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "Cancelar",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.red),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await informarcoesRepository
                                                                .removerInformacoes(
                                                                    informacoes
                                                                        .id);
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "Confirmar",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )),
                                                    ],
                                                  );
                                                });
                                          },
                                          backgroundColor: Colors.transparent,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text(
                                            "Olá ${informacoes.nome}, segue informações:\n\nAltura: ${informacoes.altura}\nPeso: ${informacoes.peso}\nResultado IMC: ${informacoes.resultadoIMC}\n",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: .7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  });
            }
          },
          child: const Icon(
            Icons.info,
            color: Color.fromARGB(206, 74, 2, 122),
          )),
      backgroundColor: const Color.fromARGB(206, 74, 2, 122),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Image.asset(AppImages.imageCalculadora, height: 150),
                const SizedBox(
                  height: 30,
                ),
                const Text("Olá, bem vindo a Calculadora de IMC",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: nomeController,
                  onChanged: (value) {
                    if (value.length > 10) {
                      showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return AlertDialog(
                              title: const Text(
                                "Calculadora IMC",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Text(
                                "Permitido apenas 10 caracteres no campo, foram digitados o total de ${value.length} caracteres!",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            );
                          });
                    }
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    label: const Text("Nome"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: alturaController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    label: const Text("Altura"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (value) {
                    try {
                      altura = double.parse(value);
                    } catch (e) {
                      Exception(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: pesoController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    label: const Text("Peso"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (value) {
                    try {
                      peso = double.parse(pesoController.text);
                    } catch (e) {
                      Exception(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 215, 218, 50)),
                    ),
                    onPressed: () async {
                      if (nomeController.text.isEmpty ||
                          nomeController.text.length > 10 ||
                          pesoController.text.isEmpty ||
                          alturaController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return AlertDialog(
                              title: const Text(
                                "Calculadora IMC",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: const Text(
                                "Verifique os campos de informações",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
                              return AlertDialog(
                                title: const Text(
                                  "Calculadora IMC",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                content: const Text(
                                  "Verifique os campos de altura e peso, lembrando que só aceitamos valores numéricos",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        if (altura == 0 || peso == 0) {
                          return;
                        } else {
                          resultadoIMC = peso / (altura * altura);
                          await informarcoesRepository.adicionarPessoas(
                            InformacoesPessoais(
                              nomeController.text,
                              peso,
                              altura,
                              resultadoIMC.roundToDouble(),
                            ),
                          );
                          setState(() {});
                          nomeController.text = "";
                          pesoController.text = "";
                          alturaController.text = "";
                        }
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
