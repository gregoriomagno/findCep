import 'package:findCep/componentes/row_resultado.dart';
import 'package:flutter/material.dart';

class PainelResultado extends StatelessWidget {
  final Map<String, dynamic> dataCep;
  PainelResultado(this.dataCep);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Endereço encontrado! ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            //margin: EdgeInsets.all(20),
            // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                RowResultado('CEP: ', dataCep['cep']),
                RowResultado('UF: ', dataCep['uf']),
                RowResultado('Cidade: ', dataCep['localidade']),
                RowResultado('Bairro: ', dataCep['bairro']),
                RowResultado('Rua: ', dataCep['logradouro']),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
