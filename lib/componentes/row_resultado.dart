import 'package:flutter/material.dart';

class RowResultado extends StatelessWidget {
  final String titulo;
  final String dado;
  RowResultado(this.titulo, this.dado);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 180,
          height: 30,
          child: FittedBox(
            fit:BoxFit.contain,
            child: Text(
              dado,style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

