import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:crecosaappcobranza/clases/models.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:crecosaappcobranza/screens/agendados.dart';
import 'package:crecosaappcobranza/screens/home.dart';
import 'package:crecosaappcobranza/screens/login.dart';
import 'package:crecosaappcobranza/screens/loginoff.dart';
import 'package:crecosaappcobranza/screens/checkinternetout.dart';
import 'package:crecosaappcobranza/screens/abonos.dart';
import 'package:crecosaappcobranza/screens/salir.dart';
import 'package:crecosaappcobranza/screens/sincronizarfinal.dart';
import 'package:crecosaappcobranza/screens/versionnotequal.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(PlatformView());
}

class PlatformView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Cobro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bienvenido'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggleflush = false;

  Future<void> flushAll() async {
    DatabaseHelper _db = new DatabaseHelper();

    String pwhereString = 'INIT = ? AND CLOSED = ?';
    List<dynamic> pwhereArgs = [1, 0];
    List<Sincronizar> syncCount = await _db.sincronizar_getRowByWhere(pwhereString, pwhereArgs);
    int x = syncCount.length.toInt();

    if (x>0){
      idSync = syncCount[0].ID.toInt();
      fecModule = syncCount[0].FECHA;
      fecMovil = syncCount[0].FECHADELMOVIL;
      var cantparam = await _db.parametros_getRowsCount();
      var cantuser = await _db.user_getRowsCount();
      var cantmetas = await _db.metas_getRowsCount();
      var cantcobros = await _db.cobros_getRowsCount();
      var cantdetcobros = await _db.detalledecobros_getRowsCount();
      var cantsync = await _db.sincronizar_getRowsCount();

      await _db.parametros_deleteAll();
      await _db.user_deleteAll();
      await _db.metas_deleteAll();
      await _db.cobros_deleteAll();
      await _db.detalledecobros_deleteAll();
      await _db.sincronizar_deleteAll();
      exit(0);
    }else
      showSnackBar(context, "La base de datos esta vacia");
  }

  Future<void> appInit() async {

    CircularProgressIndicator();
    DatabaseHelper db = new DatabaseHelper();

    //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // flush();
    // Calculo del proximo sincronizacion
    var cantsincronizar = await db.sincronizar_getRowsCount();
    nextSync = cantsincronizar.toInt();
    nextSync = nextSync +1;

    print ('New Sync: $nextSync');

    String pwhereString = 'INIT = ? AND CLOSED = ?';
    List<dynamic> pwhereArgs = [1, 0];
    List<Sincronizar> syncCount = await db.sincronizar_getRowByWhere(pwhereString, pwhereArgs);
    var result = await CheckToConnectInternet();
    isConectadoInternet = result.toInt();
    int x = syncCount.length.toInt();

    if (x>0){
      idSync = syncCount[0].ID.toInt();
      fecModule = syncCount[0].FECHA;
      fecMovil = syncCount[0].FECHADELMOVIL;
    }
    else
      idSync=0;

    print("Conectado a Internet: $result");
    print("Sincronizado: $idSync");

    if (idSync > 0) {
        print("Going LoginOff");
        runApp(LoginOffline());
      }
    else if(isConectadoInternet == 1) {
      print("Going LoginOnline");
      runApp(LoginOnline());
    }
    else
      runApp((new MaterialApp(home: CheckInternetOut())));

  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    imgLogoEmpresa(),
              Container(
                margin: EdgeInsets.fromLTRB(60, 20, 60,20),
                child: RaisedButton(
                  onPressed: appInit,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Platform.isIOS
                              ? const Text('Continuar ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ))
                              : const Text('Continuar ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )),
                        ),
                        Icon(
                          Platform.isIOS ? Icons.arrow_forward_ios:Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]))),
      );
}

class LoginOnline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cobranzas Online"),
            centerTitle: true,
          ),
          body: Login()),
      routes: <String, WidgetBuilder>{
        Home.routeName: (BuildContext context) => Home(),
        Abonos.routeName: (BuildContext context) => Abonos(),
        Agendados.routeName: (BuildContext context) => Agendados(),
        SincronizarFinal.routeName: (BuildContext context) => SincronizarFinal(),
        Salir.routeName: (BuildContext context) => Salir(),
      },
    );
  }
}

class VersioWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Actualizar Versión"),
            centerTitle: true,
          ),
          body: VersionNotEqual()
          ),
      routes: <String, WidgetBuilder>{
        Home.routeName: (BuildContext context) => Home(),
        Abonos.routeName: (BuildContext context) => Abonos(),
        Agendados.routeName: (BuildContext context) => Agendados(),
        SincronizarFinal.routeName: (BuildContext context) => SincronizarFinal(),
        Salir.routeName: (BuildContext context) => Salir(),
      },
    );
  }
}

class LoginOffline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cobranzas OffLine"),
            centerTitle: true,
          ),
          body: LoginOff()),
      routes: <String, WidgetBuilder>{
        Home.routeName: (BuildContext context) => Home(),
        Abonos.routeName: (BuildContext context) => Abonos(),
        Agendados.routeName: (BuildContext context) => Agendados(),
        SincronizarFinal.routeName: (BuildContext context) => SincronizarFinal(),
        Salir.routeName: (BuildContext context) => Salir(),
      },
    );
  }
}
