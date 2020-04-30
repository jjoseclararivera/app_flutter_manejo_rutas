import 'dart:convert';
import 'dart:io';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:http/http.dart' as http;
import 'package:crecosaappcobranza/clases/models.dart';


class ToggleActionInit extends StatefulWidget {
  const ToggleActionInit({Key key}) : super(key: key);

  @override
  _ToggleActionInitState createState() => _ToggleActionInitState();
}

class _ToggleActionInitState extends State<ToggleActionInit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: getAppBar("Conectando..."),
        body: buildContainer()
        );
  }

  Container buildContainer() {
    return Container(
        child: FutureBuilder(
            future: getDatos(),
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
                    child: Text('Result: ${snapshot.data}'),
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
                    child: Text('Esperando resultado...'),
                  )
                ];
              }else{
                children = <Widget>[
                  const SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {},
                    child: const Text(
                        'Finalizado',
                        style: TextStyle(fontSize: 20)
                    ),
                  ),
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

  Future<String> getDatos() async {
    // await Future.delayed(Duration(milliseconds: 5000), () {
      int result1 = await metas_getRequest();
      int result2 = await cobros_getRequest();
      int result3 = await detalledecobros_getRequest();
      int result4 = await sincronizar_getRequest();

      print('Datos Recibidos...metas:$result1 cobros:$result2 detallecobros:$result3');

      Finalizar((result1==200 && result2==200 && result3==200 && result4==200));
      return 'Datos Recibidos...metas:$result1 cobros:$result2 detallecobros:$result3';
   // });
  }

  Future<int> sincronizar_getRequest() async {
    DatabaseHelper db = new DatabaseHelper();
    int resultado = 0;
    
    try{
    
        Sincronizar sincronizar= new Sincronizar();
        sincronizar.ID = nextSync;
        sincronizar.FECHA = fecModule;
        sincronizar.ID_USUARIO = userglobal.ID_USUARIO;
        sincronizar.ID_OFICINA=userglobal.ID_OFICINA;
        sincronizar.NOMBRE = userglobal.NOMBRE;
        sincronizar.ROLL = userglobal.ROLL;
        sincronizar.INIT=1;
        sincronizar.CLOSED=0;
        sincronizar.FECHADELMOVIL=fecSystem;
        sincronizar.ID_SYNC = nextSync;
        db.sincronizar_insert(sincronizar);

        resultado = okHttpSuccessfull;
        print('Sincronizacion agregado con exito!!!');

      }catch(ex){
        resultado = okHttpNotFound;
        print(ex.message);
      }

    return resultado;
  }

  Future<int> detalledecobros_getRequest() async {
    DatabaseHelper db = new DatabaseHelper();
    String url = urlApi + "Pagos?id_usuario=${userglobal.ID_USUARIO}&id_gestor=${userglobal.ID_USUARIO}&busquera=ALL&bandera=3";
    http.Response response2 = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    int resultado = 0;

    var myCobrosdet;
    if (response2.statusCode == okHttpSuccessfull) {
      try{
        myCobrosdet = json.decode(response2.body);

         print("json detcobros: ${myCobrosdet.length}");
        for(var itemjson in myCobrosdet) {
          DetalledeCobros detalle = new DetalledeCobros();
          detalle = DetalledeCobros.fromJson(itemjson);
          detalle.FECHA = fecModule;
          detalle.FECHADELMOVIL = fecSystem;
          detalle.ID_SYNC = nextSync;
          db.detalledecobros_insert(detalle);
        }
        resultado = okHttpSuccessfull;
        print('Detalle de detalle de cobro agregado con exito!!!');

      }catch(ex){
        resultado = okHttpNotFound;
        print(ex.message);
      }
    } else {
      resultado = okHttpNotFound;
      print('Cobros NO PASO!!!');
    }
    return resultado;
  }

  Future<int> cobros_getRequest() async {
    DatabaseHelper db = new DatabaseHelper();
    String url = urlApi + "Pagos?id_usuario=${userglobal.ID_USUARIO}&id_gestor=${userglobal.ID_USUARIO}&busquera=&bandera=ALL";
    http.Response response2 = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    int resultado = 0;

    var myCobros;
    if (response2.statusCode == okHttpSuccessfull) {
      try{
        myCobros = json.decode(response2.body);
        print("json cobros: ${myCobros.length}");
        for(var itemjson in myCobros) {
          Cobros cobro = new Cobros();
          cobro = Cobros.fromJson(itemjson);
          cobro.FECHA = fecModule;
          cobro.FECHADELMOVIL = fecSystem;
          cobro.ID_SYNC = nextSync;
          db.cobros_insert(cobro);
        }
        resultado = okHttpSuccessfull;
        print('Cobros agregado con exito!!!');

      }catch(ex){
        resultado = okHttpNotFound;
        print(ex.message);
      }
    } else {
      resultado = okHttpNotFound;
      print('Cobros NO PASO!!!');
    }
    return resultado;
  }

  Future<int> metas_getRequest() async {
    DatabaseHelper db = new DatabaseHelper();
    String url = urlApi + "Metas?fecha=$fecModule&agrup=2&val=${userglobal.ID_USUARIO}";
    http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    int resultado = 0;

    var myMetas;
    if (response.statusCode == okHttpSuccessfull) {
        try{
          myMetas = json.decode(response.body);
           print("json cobros: ${myMetas.length}");
          for(var itemjson in myMetas){
            Metas mimetas = new Metas();
            mimetas = Metas.fromJson(itemjson);
            mimetas.FECHA = fecModule;
            mimetas.FECHADELMOVIL = fecSystem;
            mimetas.ID_SYNC = nextSync;
            db.metas_insert(mimetas);
          }
          resultado = okHttpSuccessfull;
          print('Metas agregado con exito!!!');

        }catch(ex){
          resultado = okHttpNotFound;
          print(ex.message);
        }
      } else {
      resultado = okHttpNotFound;
      print('Metas NO PASO!!!');
    }
    return resultado;

  }

  //Future<AlertDialog> Finalizar() async{
AlertDialog Finalizar(bool result) {
    AlertDialog alertDialogExit = AlertDialog(
      title: result ? Text('Exito'): Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            result  ?
            Text('Proceso finalizado con Exito !!!')
                : Text('Proceso tuvo un error contacte a la oficina'),
            result  ?
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 50,
                      ):Icon(
                            Icons.not_interested,
                            color: Colors.red,
                            size: 50,
                          ),
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
