import 'package:findCep/componentes/Painel_busca_endereco.dart';

import 'package:findCep/componentes/screen_google_maps.dart';
import 'package:findCep/componentes/tipo_pesquisa.dart';
import 'package:findCep/util/app_routes.dart';
import 'package:flutter/material.dart';
import './componentes/screen_busca_endereco_autocomplete.dart';

import 'componentes/painel_busca_cep.dart';

main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[900],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: FindCep(),
      routes: {
        AppRoutes.PAINEL_BUSCA_CEP: (ctx) => PainelBuscaCep(),
        AppRoutes.PAINEL_BUSCA_ENDERECO: (ctx) => PainelBuscaEndereco(),
        AppRoutes.SCREEN_GOOGLE_MAPS: (ctx) => ScreenGoogleMaps(),
        AppRoutes.SCREEN_BUSCA_ENDERECO_AUTOCOMPLETE: (ctx) =>
            ScreenBuscaEnderecoAutocomplete(),
      },
    ));

class FindCep extends StatefulWidget {
  @override
  _FindCepState createState() => _FindCepState();
}
 

class _FindCepState extends State<FindCep> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.blue[900],
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            centerTitle: true,
            title: Text('FindCep'),
            bottom: TabBar(
              tabs: [
                Tab(
                 // icon: Icon(Icons.search),
                  text: 'Cep',
                ),
                Tab(
                 // icon: Icon(Icons.search),
                  text: 'Endereço',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
             PainelBuscaCep(),
             ScreenBuscaEnderecoAutocomplete(),
            ],
          )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.all(15),
          //       child: TipoPesquisa(),
          //     ),
          //   ],
          // )
          ),
    );
  }
}
