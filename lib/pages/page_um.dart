import 'package:app_estudos_flutter/shared/widgets/text.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  double altura = 0;
  var pesoController = TextEditingController(text: "");
  double resultadoIMC = 0;
  double peso = 0;
  DateTime? dataNascimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 74, 2, 122),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                child: Image.network(
                  "https://img.freepik.com/icones-gratis/calculadora_318-213109.jpg",
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Texto(texto: "Preencha os campos para calcularmos seu IMC"),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextField(
                  controller: nomeController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Nome",
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      floatingLabelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Data de Nascimento",
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    controller: dataNascimentoController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime.now());
                      if (data != null) {
                        dataNascimentoController.text = data.toString();
                        //salvando a data informada na variável do tipo DateTime
                        dataNascimento = data;
                      }
                    }),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  controller: alturaController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Altura",
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      floatingLabelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                  onChanged: (alturaController) {
                    if (alturaController.isNotEmpty) {
                      altura = double.parse(alturaController);
                    }
                  },
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: pesoController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Peso",
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    onChanged: (pesoController) {
                      if (pesoController.isNotEmpty) {
                        peso = double.parse(pesoController);
                      }
                    },
                  )),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 215, 218, 50))),
                    onPressed: () {
                      resultadoIMC = peso / (altura * altura);
                      showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                "App Calculo IMC",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              content: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "O seu IMC é: ${resultadoIMC.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Sair",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ))
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "Calcular IMC",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
