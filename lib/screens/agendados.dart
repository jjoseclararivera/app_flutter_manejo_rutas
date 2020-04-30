import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';

class Agendados extends StatelessWidget {
  static const String routeName = "/agendados";

  const Agendados({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobranza',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Agendados de ${userglobal.NOMBRE}"),
          centerTitle: true,
        ),
        drawer: getDrawer(context),
        body:Center(child: Text('AGENDADOS', style: TextStyle(fontSize: 20))),
      ),

    );
  }
}
