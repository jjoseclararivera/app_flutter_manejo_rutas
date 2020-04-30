import 'dart:io';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';

class Salir extends StatelessWidget {
static const String routeName = "/exit";

 @override
 Widget build(BuildContext context) {
 // ConfirmAction result;

  return Scaffold(
    appBar: AppBar(
      title: Text("Salir ${userglobal.NOMBRE}"),
    ),
      drawer: getDrawer(context),
    body:
    Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
      const SizedBox(height: 60),
      Text(
          'Salir de la app',
          style: TextStyle(fontSize: 20)
      ),
      Container(
      margin: EdgeInsets.all(20.0),
      child: FlatButton(
          onPressed: () {
            exit(0);
          },
          //color: Colors.redAccent,
          padding: EdgeInsets.all(20.0),
          child: Image.asset('assets/images/salir.png',width:100,height: 100,)
      ),
    ),]
      )
 ));
 }
}

enum ConfirmAction { CANCEL, ACCEPT }


Future<ConfirmAction> asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Salir de App Cobranza?'),
        content: const Text(
            'Si sales de la app debes volver a ingresar tus credenciales'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancelar'),
            onPressed: () {
              return(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('Aceptar'),
            onPressed: () {
               return(ConfirmAction.ACCEPT);
              // Route route = MaterialPageRoute(builder: (bc) => Login());
              //Navigator.of(context).push(route);
          },
          )
        ],
      );
    },
  );
}