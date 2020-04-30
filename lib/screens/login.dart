import 'package:crecosaappcobranza/screens/toggleactionInit.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:crecosaappcobranza/services/httprequest.dart';
import 'package:crecosaappcobranza/screens/sincronizarinit.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final String routeName = "/Login";
  @override
  _LoginState createState() => new _LoginState();
}
class _LoginState extends State<Login> {

  TextEditingController myControlleruser = TextEditingController();
  TextEditingController myControllerpass = TextEditingController();
  final double varMargen = 10.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.lightGreen,
                      width: 2,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(30),
          ),

          margin: EdgeInsets.fromLTRB(10,80,10,80),
          child: Form(
              child: Column(
              children: <Widget>[
              imgLogoEmpresa(),
              Container(  
                    margin: EdgeInsets.all(varMargen),
                    child: TextFormField(
                      controller: myControlleruser,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          icon: Icon(Icons.people),
                          hintText: 'Digite su usuario',
                          labelText: 'Usuario',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)) )
                          ),
                    )
                    ),
              Container(
                   margin: EdgeInsets.all(varMargen),
                  child: TextFormField(
                    controller: myControllerpass,
                    obscureText: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        )),
                  )
                  ),
              Container(
                margin: EdgeInsets.all(varMargen),
                child: RaisedButton(
                  onPressed: () {
                    ButtonPressIngresar(this.context, myControlleruser, myControllerpass);
                  },
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                  ),
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ingresar  ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("ONLINE MODE", style: TextStyle(color: Colors.blue, fontSize: 15.0),)
             ),
             Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("Number Version: $VersionApp", style: TextStyle(color: Colors.black, fontSize: 10.0),)
             )
            ],
          ))),
    )
    );
  }
}

void ButtonPressIngresar(BuildContext context, TextEditingController myControlleruser, TextEditingController myControllerpass) async {

  HttpRequest http = new HttpRequest();
  var result = await http.UserGetRequest(myControlleruser.text.trim().toString(), myControllerpass.text.trim());
  print ("Resultado: $result");

  if (result.toInt()==okHttpSuccessfull) {
    print("user: $result");
    SetSession(myControlleruser.text.trim().toString());
    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => ToggleActionInit(),
    ));
    varGlobalAllOk = false;
  }
  else
    showAlertDialog(context, "Incorrecto", "Usuario o Password incorrecto");

}


