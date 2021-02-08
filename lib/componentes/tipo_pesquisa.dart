import 'package:findCep/util/app_routes.dart';
import 'package:flutter/material.dart';

class TipoPesquisa extends StatelessWidget {
  // final Function(int ) setTipoPesquisa;
  //TipoPesquisa(this.setTipoPesquisa);

  void _selectTipoPesquisa(BuildContext context, String rota) {
    Navigator.of(context).pushNamed(rota);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: double.infinity*0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Pesquisar por:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 200,
                              child: RaisedButton(
                  onPressed: () => _selectTipoPesquisa(
                      context, AppRoutes.PAINEL_BUSCA_CEP),
                  child: Text('CEP'),
                ),
              ),
              Text(
                'ou',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 200,
                              child: RaisedButton(
                  onPressed: () => _selectTipoPesquisa(context,
                      AppRoutes.SCREEN_BUSCA_ENDERECO_AUTOCOMPLETE),
                  child: Text('Endereço'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
