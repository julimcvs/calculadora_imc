import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

enum Sexo { MASCULINO, FEMININO }

class _CalculadoraImcState extends State<CalculadoraImc> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  Sexo? sexo = Sexo.MASCULINO;
  bool calculoRealizado = false;
  String calculo = '0';
  String resultado = 'Abaixo do peso';
  String nome = '';

  calcularImc() {
    var pesoStr = pesoController.text;
    var alturaStr = alturaController.text;

    double peso = double.tryParse(pesoStr) ?? 0.0;
    double altura = double.tryParse(alturaStr) ?? 0.0;

    if (peso > 0 && altura > 0) {
      double imc = peso / (altura * altura);
      setState(() {
        nome = nomeController.text;
        calculo = imc.toStringAsFixed(2);
        calculoRealizado = true;
        resultado = interpretarImc(imc);
      });
    }
  }

  String interpretarImc(double imc) {
    if (imc <= 18) {
      return "Abaixo do Peso";
    } else if (imc < 24) {
      return "Normal";
    } else if (imc < 29) {
      return "Sobrepeso";
    } else if (imc < 34) {
      return "Obesidade";
    } else if (imc < 39) {
      return "Obesidade Grau 2";
    } else {
      return "Obesidade Mórbida";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 86, 155, 1),
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
              fontSize: 20, color: Color.fromRGBO(246, 246, 246, 1.0)),
        ),
        leading: const Icon(
          Icons.menu,
          color: Color.fromRGBO(246, 246, 246, 1.0),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !calculoRealizado,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.person,
                              color: Color.fromRGBO(56, 68, 85, 1)),
                          hintText: 'Digite seu nome',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(32, 32, 32, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(25.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(41, 86, 155, 1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: MaskedTextField(
                        mask: "###.###.###-##",
                        decoration: InputDecoration(
                          labelText: 'CPF',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.credit_card,
                              color: Color.fromRGBO(56, 68, 85, 1)),
                          hintText: 'Digite seu CPF',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(32, 32, 32, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(25.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(41, 86, 155, 1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                            fontSize: 20, color: Color.fromRGBO(56, 68, 85, 1)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: MaskedTextField(
                        mask: "#.##",
                        controller: alturaController,
                        decoration: InputDecoration(
                          labelText: 'Altura',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.accessibility,
                              color: Color.fromRGBO(56, 68, 85, 1)),
                          hintText: 'Digite sua altura',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(32, 32, 32, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(25.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(41, 86, 155, 1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                            fontSize: 20, color: Color.fromRGBO(56, 68, 85, 1)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: pesoController,
                        decoration: InputDecoration(
                          labelText: 'Peso',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.fitness_center,
                              color: Color.fromRGBO(56, 68, 85, 1)),
                          hintText: 'Digite seu peso',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(32, 32, 32, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(25.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(41, 86, 155, 1))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Color.fromRGBO(202, 202, 202, 1))),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 20, color: Color.fromRGBO(56, 68, 85, 1)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Masculino'),
                            leading: Radio<Sexo>(
                              activeColor: Color.fromRGBO(41, 86, 155, 1),
                              value: Sexo.MASCULINO,
                              groupValue: sexo,
                              onChanged: (Sexo? value) {
                                setState(() {
                                  sexo = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Feminino'),
                            leading: Radio<Sexo>(
                              activeColor: Color.fromRGBO(41, 86, 155, 1),
                              value: Sexo.FEMININO,
                              groupValue: sexo,
                              onChanged: (Sexo? value) {
                                setState(() {
                                  sexo = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                      ElevatedButton(
                        onPressed: () => calcularImc(),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(41, 86, 155, 1),
                            onPrimary: const Color.fromRGBO(202, 202, 202, 1),
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(56, 68, 85, 1),
                            )),
                        child: const Text('Calcular IMC'),
                      ),
                  ],
                )
            ),
            Center(
              child: Visibility(
                visible: calculoRealizado,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '$nome, aqui estão os resultados do seu IMC:',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'IMC: $calculo',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Resultado: $resultado',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(56, 68, 85, 1)
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          calculoRealizado = false;
                        }),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(41, 86, 155, 1),
                            onPrimary: const Color.fromRGBO(202, 202, 202, 1),
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(56, 68, 85, 1),
                            )),
                        child: const Text('Calcular novamente'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
