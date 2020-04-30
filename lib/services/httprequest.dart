import 'dart:async';
import 'dart:convert';
import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:crecosaappcobranza/main.dart';
import 'package:http/http.dart' as http;
import 'package:crecosaappcobranza/clases/models.dart';

class HttpRequest {
  //Future<String> makePostRequest() async {
  // set up POST request arguments
  //String url = 'https://jsonplaceholder.typicode.com/posts';
  //Map<String, String> headers = {"Content-type": "application/json"};
  //String json = '{"title": "Hello", "body": "body text", "userId": 1}';

  // make POST request
  // Response response = await post(url, headers: headers, body: json);

  // check the status code for the result
  // int statusCode = response.statusCode;

  // this API passes back the id of the new item added to the body
  // String body = response.body;
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }

  //}

  Future<int> parametros_getRequest() async {
    DatabaseHelper db = new DatabaseHelper();
    String url = urlApi + "parametros";
    int resultado = 0;
    http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    //List<Parametros> listParametros;
    if (response.statusCode == okHttpSuccessfull) {
      List<Parametros> parametros;
      parametros = (json.decode(response.body) as List)
          .map((i) => Parametros.fromJson(i))
          .toList();
      
      print("json parametros: ${parametros.length}");

      for (int i = 0; i < parametros.length; i++) {
        Parametros param = parametros[i];
        param.FECHA = fecSystem;
        param.FECHADELMOVIL = fecSystem;
        param.ID_SYNC = nextSync;
        db.parametros_insert(param);
      }

      resultado = okHttpSuccessfull;
      print('Parametros agregado con exito !!!');
    } else {
      resultado = okHttpNotFound;
      print('Parametros NO PASO!!!');
    }
    return (resultado);
  }

  Future<int> UserGetRequest(String user, String pass) async { 
    DatabaseHelper db = new DatabaseHelper();
    String url = urlApi + "Usuarios?username=$user&pass=$pass";
    int resultado = 0;
    int insertparam = 0;

    http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    insertparam = await parametros_getRequest();
    userglobal = new User();
    
    if (response.statusCode == okHttpSuccessfull && insertparam == okHttpSuccessfull) {

      Parametros cHoy = new Parametros();
      // fecha de trabajo
      String pwhereString = 'DET_PARAMETRO = ? AND ID_SYNC = ?';
      List<dynamic> pwhereArgs = ["FECHA_HOY", nextSync];
      cHoy = await db.parametros_getRowByWhere(pwhereString, pwhereArgs);
      if (cHoy.VAL_PARAMETRO.isNotEmpty) {
        fecModule = cHoy.VAL_PARAMETRO;
      }

      pwhereString = 'DET_PARAMETRO = ? AND ID_SYNC = ?';
      pwhereArgs = ["VERSION_APP", nextSync];

      Parametros cVersion = await db.parametros_getRowByWhere(pwhereString, pwhereArgs);
      if (cVersion.VAL_PARAMETRO != VersionApp) {
        print("Version equivocada");
        VersioWrong();
      }else {
        User user = User.fromJson(jsonDecode(response.body));

        print("json user: 1");
        user.PASS = pass;
        user.FECHA = fecModule;
        user.FECHADELMOVIL = fecSystem;
        user.ID_SYNC = nextSync;
        userglobal = user;
        db.user_insert(user);
        print('Name: ${userglobal.NOMBRE}  y todo esta $resultado!!!');
      }
      resultado = okHttpSuccessfull;

    } else {
      resultado = okHttpNotFound;
      print('Result: $resultado !!!');
    }
    return (resultado);
  }
}
