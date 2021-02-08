import 'package:findCep/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class BotaoVerNoMapa extends StatelessWidget {
  final String endereco;

  BotaoVerNoMapa(this.endereco);
  Future<Coordinates> _setLatLog(String enderco) async {
    final query = enderco;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    //print("${first.featureName} : ${first.coordinates}");
    print("${first.coordinates}");
    Coordinates _latLog = first.coordinates;
    return _latLog;
  }

  void _googleMaps(BuildContext context, String rota, String endereco) {
    _setLatLog(endereco).then((value) {
      print("chamada google maps $value");
      Navigator.of(context).pushNamed(rota, arguments: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: double.infinity,
          child: RaisedButton.icon(
            icon: Icon(Icons.map_outlined),
            textColor: Colors.blue[900],
            color: Colors.white,
            label: const Text('Ver no Maps'),
            onPressed: () {
              
              _googleMaps(
                  context, AppRoutes.SCREEN_GOOGLE_MAPS, endereco) ;
            },
          )),
    );
  }
}
