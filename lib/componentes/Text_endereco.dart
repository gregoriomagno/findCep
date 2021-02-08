import 'package:flutter/material.dart';

class TextEndereco extends StatelessWidget {
  final String texto;
  
  TextEndereco(this.texto);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
          child: Text('$texto',style: TextStyle(
        fontSize: 18,
        color: Colors.black
      ),
        
      ),
    );
  }
}