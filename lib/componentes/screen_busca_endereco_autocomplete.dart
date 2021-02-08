import 'package:findCep/componentes/Text_endereco.dart';
import 'package:findCep/componentes/botao_ver_no_mapa.dart';

import 'package:flutter/material.dart';
import './address_search.dart';
import './place_service.dart';
import 'package:uuid/uuid.dart';

class ScreenBuscaEnderecoAutocomplete extends StatefulWidget {
  @override
  _ScreenBuscaEnderecoAutocompleteState createState() =>
      _ScreenBuscaEnderecoAutocompleteState();
}

class _ScreenBuscaEnderecoAutocompleteState
    extends State<ScreenBuscaEnderecoAutocomplete> {
  String _tituloBusca = 'Informe o endereço';
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  String _uf = '';
  bool _ativarBotaoVerNoMapa = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return 
       Container(
       
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Card(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: GestureDetector(
                    child: ListTile(
                        title: Text(
                          '$_tituloBusca',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(
                          Icons.map,
                          color: Colors.blue[900],
                        )),
                    onTap: () async {
                      // generate a new token here
                      final sessionToken = Uuid().v4();
                      final Suggestion result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      // This will change the text displayed in the TextField
                      if (result != null) {
                        final placeDetails =
                            await PlaceApiProvider(sessionToken)
                                .getPlaceDetailFromId(result.placeId);
                        setState(() {
                          _ativarBotaoVerNoMapa = true;
                          _tituloBusca = result.description;
                          _controller.text = result.description;
                          _streetNumber = placeDetails.streetNumber;
                          _street = placeDetails.street;
                          _city = placeDetails.city;
                          _zipCode = placeDetails.zipCode;
                          _uf = placeDetails.uf;
                        });
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 50.0),
              Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_ativarBotaoVerNoMapa)
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextEndereco('CEP: $_zipCode'),
                                  TextEndereco('Estado: $_uf'),
                                  TextEndereco('Cidade: $_city'),
                                  TextEndereco('Rua: $_street'),
                                  TextEndereco('Numero:$_streetNumber'),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40.0, left: 7, right: 7),
                            child: BotaoVerNoMapa('$_street,$_city-$_uf'),
                          )
                        ],
                      )
                  ],
                ),
              )
              //
            ],
          ),
        ),
      );
  }
}
