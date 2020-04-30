import 'dart:io';

import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';

class VersionNotEqual extends StatelessWidget {
  static const String routeName = "/versionnotequal";
  
  const VersionNotEqual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Necesita actualizar Version"),
      ),
      body: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                imgLogoEmpresa(),
                Container(child: Platform.isIOS ? imgLogoIOS() : imgAndroidDoctor()) ,
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text("El sistema necesita actualizar a la version: $VersionApp", style: TextStyle(color: Colors.black, fontSize: 15.0),)
              ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () {
                      exit(0);
                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: const Text('Salir',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                )),
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                )

        ]
    )),
    );
  }
}
