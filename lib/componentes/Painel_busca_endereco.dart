import 'package:findCep/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PainelBuscaEndereco extends StatefulWidget {
  @override
  _PainelBuscaEnderecoState createState() => _PainelBuscaEnderecoState();
}

class _PainelBuscaEnderecoState extends State<PainelBuscaEndereco> {
  final TextEditingController ufController = TextEditingController();

  final TextEditingController localidadeController = TextEditingController();

  final TextEditingController bairroController = TextEditingController();

  final TextEditingController logradouroController = TextEditingController();

  List<dynamic> data;
  

  Future<String> getJSONDataEnd(String endereco) async {
    var response = await http.get(
        Uri.encodeFull("https://viacep.com.br/ws/$endereco/json/"),
        headers: {"Accept": "application/json"}).then((value) {
      data = json.decode(value.body);
      _resultadoBuscaEndereco(
          context, AppRoutes.SCREEN_BUSCA_ENDERECO_RESULTADO);
    });

    return "Dados obtidos com sucesso";
  }

  void _resultadoBuscaEndereco(BuildContext context, String rota) {
    Navigator.of(context).pushNamed(
      rota,
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar Por Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Informe o Endereço',
              style: TextStyle(fontSize: 18),
            ),
           
            TextField(
              decoration: InputDecoration(labelText: 'UF'),
              controller: ufController,
            ),

            TextField(
              decoration: InputDecoration(labelText: 'Localidade'),
              controller: localidadeController,
              
            ),

            TextField(
              decoration: InputDecoration(labelText: 'logradouro'),
              controller: logradouroController,
            ),
            RaisedButton.icon(
              onPressed: () {
                String _endereco =
                    '${ufController.text}/${localidadeController.text}/${logradouroController.text}';
                getJSONDataEnd(_endereco);
              },
              icon: Icon(Icons.search),
              label: Text('Buscar'),
            )
          ],
        ),
      ),
    );
  }
}
