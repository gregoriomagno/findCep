import 'package:findCep/util/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class EnderecoItem extends StatelessWidget {
  final Map<String, dynamic> endereco;
  EnderecoItem(this.endereco);

  Future<Coordinates> _setLatLog(String enderco) async {
    final query = enderco;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    //print("${first.featureName} : ${first.coordinates}");
    print("${first.coordinates}");
    Coordinates _latLog = first.coordinates;
    return _latLog;
  }

  void _googleMaps(BuildContext context, String rota) {
    _setLatLog(
            "$endereco['logradouro']}, ${endereco['localidade']} -${endereco['uf']}")
        .then((value) {
      print("chamada google maps $value");
      Navigator.of(context).pushNamed(rota, arguments: value);
    });

    
  }

  @override
  Widget build(BuildContext context) {
    print('enderecoItem');
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ListTile(
        title: Text('CEP: ${endereco['cep']}'),
        subtitle: Text(
            '${endereco['logradouro']}, ${endereco['localidade']}-${endereco['uf']}'),
        trailing: IconButton(
            icon: Icon(Icons.map_outlined),
            onPressed: () {
              _googleMaps(
                context,
                AppRoutes.SCREEN_GOOGLE_MAPS,
              );
              //MapUtils.openMap(endereco['cep']);
            }),
      ),
    );
  }
}
