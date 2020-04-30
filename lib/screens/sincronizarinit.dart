import 'package:crecosaappcobranza/services/global.dart';
import 'package:crecosaappcobranza/screens/toggleactionInit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SincronizarInit extends StatefulWidget {
  static const String routeName = "/sincronizarinicial";

  @override
  State<StatefulWidget> createState() => _SincronizarInitState();
}

class _SincronizarInitState extends State<SincronizarInit> {
  bool togglevalue = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Recibir Datos datos"),
        ),
        // drawer: getDrawer(context),
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
                          ),
                      ),
                      Row(
                        mainAxisSize : MainAxisSize.min,
                        children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                              child: Text(
                                  togglevalue ? "Desactivar": "Activar....",
                              style: TextStyle(color: togglevalue ? Colors.green: Colors.red, fontSize:20.0)
                          ),
                          
                      ),
                       Icon(
                                  Icons.sync,
                                  color: togglevalue ? Colors.green.withOpacity(0.5): Colors.red.withOpacity(0.5),
                                  size: 25,
                                ),
                      AnimatedContainer(
                          margin: EdgeInsets.all(20),
                          duration: Duration(milliseconds: 500),
                          height: 40.0,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: togglevalue ? Colors.green: Colors.red,
                            border:togglevalue ?  Border.all(color: Colors.green.withOpacity(0.5),width: 3): Border.all(color: Colors.red.withOpacity(0.5),width: 3)
                          ),
                          child: Stack(
                              children: <Widget>[
                                AnimatedPositioned(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                    top: 3.0,
                                    left: togglevalue ? 60.0 : 0.00,
                                    right: togglevalue ? 0.0 : 60.0,
                                    child: InkWell(
                                        onTap: toggleButton,
                                        child: AnimatedSwitcher(
                                            duration: Duration(milliseconds: 500),
                                            transitionBuilder:
                                                (Widget child, Animation<double> animation){
                                              return RotationTransition(
                                                  child: child, turns: animation);
                                            },
                                            child: togglevalue ? Icon(Icons.check_circle, color:Colors.white, size: 30.0, key: UniqueKey()) : Icon(Icons.check_circle_outline, color:Colors.white, size: 30.0, key: UniqueKey())
                                        )
                                    )
                                )]
                          )

                      ),
                      
                        ],

                      ),
                     
                      Container(
                        margin: EdgeInsets.all(20),
                        child: RaisedButton(
                          onPressed: () {
                            if (togglevalue)
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => ToggleActionInit(),

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
                          child: Text("Presione Sincronizar recibir la información",
                              style: TextStyle(color: Colors.black, fontSize: 10.0)
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
