import 'package:findCep/componentes/botao_ver_no_mapa.dart';
import 'package:findCep/componentes/painel_resultado.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PainelBuscaCep extends StatefulWidget {
  // final Function(String) getData;
  // PainelBuscaCep(this.getData);
  @override
  _PainelBuscaCepState createState() => _PainelBuscaCepState();
}

class _PainelBuscaCepState extends State<PainelBuscaCep> {
  Map<String, dynamic> dataCep;

  Future<String> getJSONDataCep(String cep) async {
    var response = await http.get(
        Uri.encodeFull("https://viacep.com.br/ws/$cep/json/"),
        headers: {"Accept": "application/json"}).then((value) {
      Map<String, dynamic> data = json.decode(value.body);
      if (data['erro'] == true) {
        print('Erro');
        setState(() {
          _cepNaoEncontrado = true;
        });
      } else {
        setState(() {
          dataCep = data;
          print(dataCep);
          _exibirResultado = true;
          _cepNaoEncontrado = false;
        });
        print('Then :${value.body}');
      }
    });

    return "Dados obtidos com sucesso";
  }

  final TextEditingController cepController = TextEditingController();
  bool _exibirResultado = false;
  bool _cepNaoEncontrado = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Para Pesquisar Endereço, informe o CEP:',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              MaskedTextField(
                maskedTextFieldController: cepController,
                mask: "xx.xxx.xxx",
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputDecoration: new InputDecoration(
                    hintText: "xx.xxx.xxx", labelText: "CEP"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              color: Colors.white,
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                if (cepController.text.isNotEmpty &&
                    cepController.text.length == 10) {
                  String cep = cepController.text.replaceAll('.', '');
                  print(cep);
                  getJSONDataCep(cep);
                } else {
                  return;
                }
              },
              icon: Icon(
                Icons.search,
                color: Colors.blue[900],
              ),
              label: Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
        ),
        _cepNaoEncontrado
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        'Cep não encontrado !',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ],
                ),
              )
            : _exibirResultado
                ? PainelResultado(dataCep)
                : Center(),
        if (_exibirResultado && !_cepNaoEncontrado)
          BotaoVerNoMapa(
              '${dataCep['logradouro']},${dataCep['localidade']},${dataCep['uf']}')
      ],
    ));
  }
}
