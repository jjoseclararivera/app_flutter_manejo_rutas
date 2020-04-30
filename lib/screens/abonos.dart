import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';

class Abonos extends StatelessWidget {
  static const String routeName = "/abonos";

  const Abonos({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobranza',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cobros de ${userglobal.NOMBRE}"),
          centerTitle: true,
        ),
        drawer: getDrawer(context),
        body:Center(child: Text('COBROS DEL DIA', style: TextStyle(fontSize: 20))),
      ),

    );
  }
}
