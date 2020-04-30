import 'dart:io';

import 'package:crecosaappcobranza/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleAction extends StatefulWidget {
  const ToggleAction({Key key}) : super(key: key);

  @override
  _ToggleActionState createState() => _ToggleActionState();
}

class _ToggleActionState extends State<ToggleAction> {
//}
//class ToggleActionOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.deepPurple,
//          title: Text(
//            'Future Builder',
//          ),
//        ),
        body: buildContainer()
    );
  }

  Container buildContainer() {
    return Container(
        child: FutureBuilder(
            future: sendFutureDatos(),
            initialData: "Espere...",

            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Resultado: ${snapshot.data}'),
                  )
                ];
              }
              else if (snapshot.hasError){
                children = <Widget>[
                  Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }else{
                children = <Widget>[
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Finalizado...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }
        )
    );
  }

  Future<String> sendFutureDatos() async {
    await Future.delayed(Duration(milliseconds: 5000), () {
      print("Enviando datos 1...");
      return 'Enviando datos 1...';
    });

    Finalizar();
  }

  AlertDialog Finalizar(){

    AlertDialog alertDialogExit = AlertDialog(
      title: Text('Proceso Finalizado'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Proceso finalizado'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Aceptar'),
          onPressed: () {
            exit(0);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (_) => alertDialogExit
    );

  }

}
