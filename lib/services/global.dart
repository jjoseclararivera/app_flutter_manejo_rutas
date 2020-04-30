import 'dart:io';
import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:crecosaappcobranza/clases/models.dart';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

User userglobal = new User();
String urlApi = "http://3.134.192.114:9081/api/";
// String urlApi = "http://192.168.1.110:81/api/";
String VersionApp = "1.0";
bool varGlobalAllOk = false;
int okHttpSuccessfull = 200;
int okHttpNotFound = 400;
String fecModule;
String fecMovil;
String fecSystem =  DateTime.now().toString().substring(0,10);
int nextSync=0;
int isConectadoInternet = 0;
int idSync=0;
String platformImei = 'Unknown';
String uniqueId = "Unknown";


void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

Future<int> CheckToConnectInternet() async {
  if (await DataConnectionChecker().hasConnection)
    return 1;
  else
    return 0;
}


Widget imgLogoEmpresa(){
  return Container(
      margin: EdgeInsets.all(5.0),
      height: 70.0,
      width: 150.0,
      child: 
        Platform.isIOS ? Image.asset('assets/images/crecocsalogoios.png'):Image.asset('assets/images/crecocsalogoandroid.png')
        
  );
}

Widget imgNoWifiSignal(){
  return Container(
      margin: EdgeInsets.all(5.0),
      child: Image.asset('assets/images/nowifisignal.png')
  );
}

Widget imgAndroidDoctor(){
  return Container(
      margin: EdgeInsets.all(5.0),
      child: Image.asset('assets\images\doctorandroid.png')
  );
}

Widget imgLogoIOS(){
  return Container(
      margin: EdgeInsets.all(5.0),
      child: Image.asset('assets\images\ioslogo.png')
  );
}

void SetSession(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

void SessionActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString("token");
    if (!token.contains(userglobal.ID_USUARIO))
        exit(0);
  }

void showAlertDialog(BuildContext context ,String title, String message) {

  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(message),
  );

  showDialog(
      context: context,
      builder: (_) => alertDialog
  );
}

AppBar getAppBar(String mytitle){
  String titlefinal = mytitle;
  return AppBar(
    title: Text(titlefinal),
    centerTitle: true,
    
  //   textTheme: ThemeData(
  //   // Define the default brightness and colors.
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.lightBlue[800],
  //   accentColor: Colors.cyan[600],

  //   // Define the default font family.
  //   fontFamily: 'Georgia',

  //   // Define the default TextTheme. Use this to specify the default
  //   // text styling for headlines, titles, bodies of text, and more.
  //   textTheme: TextTheme(
  //     headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //     title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //     body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  //   ),
  // )

  );
}


Drawer getDrawer(BuildContext context) {

  var header = UserAccountsDrawerHeader(

      accountName: Text("Hola, ${userglobal.NOMBRE}", style: TextStyle(fontSize: 12, color: Colors.blue,)),
      accountEmail: Text("Version: $VersionApp;  Fecha Modulo: $fecModule", style: TextStyle(fontSize: 12, color: Colors.blue)),
      decoration: BoxDecoration(
        // const Color(0xff7c94b6)
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('assets/images/crecocsalogo.png'),
          fit: BoxFit.scaleDown,
        ),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ));

  ListTile getItem(Icon icon, String descripcion, String route, TextStyle style) {
    return ListTile(
      leading: icon,
      title: Text(
        descripcion,
        style: style,
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  ListView getItemsList() {
    return ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          header,
          new Divider(),
          Card(
              color: Colors.grey[100],
              child: getItem(Icon(Icons.create_new_folder, color: Colors.blueAccent, size: 30,), 'ASIGNACION', '/home', TextStyle(color: Colors.blueAccent))
          ),
          Card(
              color: Colors.white,
              child: getItem(Icon(Icons.playlist_add_check, color: Colors.blueAccent, size: 30,), 'COBROS DEL DIA', '/abonos', TextStyle(color: Colors.blueAccent))
          ),
          Card(
              color: Colors.grey[100],
              child: getItem(Icon(Icons.view_agenda, color: Colors.blueAccent, size: 30,), 'AGENDADO', '/agendados', TextStyle(color: Colors.blueAccent))
          ),
          new Divider(),
          Card(
              color: Colors.white,
              child: getItem(Icon(Icons.sync, color: Colors.blueAccent, size: 30,), 'ENVIAR DATA..', '/sincronizarfinal', TextStyle(color: Colors.blueAccent))
          ),
          new Divider(),
          Card(
              color: Colors.grey[100],
              child:getItem(Icon(Icons.exit_to_app, color: Colors.blueAccent, size: 30,), 'SALIR', '/exit', TextStyle(color: Colors.blueAccent))
          ),

        ]
    );
  }
  return Drawer(child: getItemsList());
}


