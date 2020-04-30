import 'dart:io';

import 'package:crecosaappcobranza/clases/models.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:crecosaappcobranza/screens/toggleaction.dart';
import 'package:flutter/material.dart';

class SincronizarFinal extends StatefulWidget {
  static const String routeName = "/sincronizarfinal";

  @override
  State<StatefulWidget> createState() => _SincronizarFinalState();
}

class _SincronizarFinalState extends State<SincronizarFinal> {
  bool togglevalue = false;
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Enviar datos"),
      ),
      drawer: getDrawer(context),
      body: Container(
    margin: EdgeInsets.all(20.0),
    child: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                imgLogoEmpresa(),
                Container(
                    margin: EdgeInsets.all(15.0),
                    child: Text("Estimado, ${userglobal.NOMBRE}",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0)
                    )
                ),
                Container(
                    color: Colors.yellow.withOpacity(0.5),
                    //margin: EdgeInsets.all(15.0),
                    child: Text("Al usted cambiar el estado del boton\n"
                        "debe estar seguro que hizo una\n"
                        "revision completa de todas las operaciones del dia\n"
                        "estas se enviaran a la CENTRAL DE CRECOSA",
                        style: TextStyle(color: Colors.red, fontSize: 20.0)
                    )
                ),
                AnimatedContainer(
            margin: EdgeInsets.fromLTRB(0, 20, 0,20),
            duration: Duration(milliseconds: 1000),
            height: 50.0,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: togglevalue? Colors.greenAccent: Colors.redAccent.withOpacity(0.7),
            ),
            child: Stack(
                children: <Widget>[
            AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 3.0,
            left: togglevalue ? 100.0 : 0.00,
            right: togglevalue ? 0.0 : 100.0,
            child: InkWell(
                onTap: toggleButton,
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation){
                      return RotationTransition(
                          child: child, turns: animation);
                    },
                    child: togglevalue ? Icon(Icons.check_circle, color:Colors.green, size: 45.0, key: UniqueKey()) : Icon(Icons.remove_circle_outline, color:Colors.green, size: 45.0, key: UniqueKey())
                )
            )
        )]
    )
      ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () {
                      if (togglevalue)
                      
                      // validar que este en modo LoginOff
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ToggleAction(),

                      ));
                      },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: const Text('Sincronizar ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                )),
                          ),
                          Icon(
                            Icons.sync,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                    margin: EdgeInsets.all(15.0),
                    child: Text("Presione Sincronizar enviar la información",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0)
                    )
                ),
            ]
          )
          )
      )
    );
  }
  void toggleButton(){
    setState(() {
      togglevalue = !togglevalue;
      print("togglevalue: $togglevalue");
    });
  }

}
