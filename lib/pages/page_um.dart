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
                flex: 1,
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
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Nome",
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        floatingLabelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                  TextField(
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: "Data de Nascimento",
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          floatingLabelStyle: TextStyle(
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
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
