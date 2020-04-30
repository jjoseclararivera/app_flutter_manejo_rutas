import 'package:crecosaappcobranza/services/global.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database;

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  // Future<Database> get database async {
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'cobranza8.db';
    // Open/create the database at a given path
    var dbDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
    return dbDatabase;
  }

  // CREACION DE TABLES
  void _createTables(Database db, int newVersion) async {
    String sql;
    // tabla: Sincronizar
    sql = "CREATE TABLE Sincronizar("
        "ID INTEGER, FECHA TEXT, ID_USUARIO TEXT, ID_OFICINA INTEGER, NOMBRE TEXT, ROLL INTEGER, " 
        "INIT INTEGER, CLOSED INTEGER, FECHADELMOVIL TEXT,  ID_SYNC INTEGER"
        ")";
    await db.execute(sql);

    // tabla: User
    sql = "CREATE TABLE User(ID_USUARIO TEXT, ID_OFICINA INTEGER, "
        "NOMBRE TEXT, ROLL INTEGER, PASS TEXT, FECHA TEXT, FECHADELMOVIL TEXT,  ID_SYNC INTEGER"
        ")";
    await db.execute(sql);

    // tabla: Parametros
    sql = "CREATE TABLE Parametros(ID_PARAMETRO INTEGER, "
           "DET_PARAMETRO TEXT, VAL_PARAMETRO TEXT, FECHA TEXT, FECHADELMOVIL TEXT,  ID_SYNC INTEGER"
           ")";
       await db.execute(sql);

       // tabla: Metas
     sql = "CREATE TABLE Metas("
           "ORDEN INTEGER,  IND TEXT, CATEGORIA TEXT,   MCANT_CREDITOS INTEGER,  MCANT_CREDITOS_DOL INTEGER, MCANT_CREDITOS_COR INTEGER,"
           "MCANT_CREDITOS_DOL1 INTEGER, MMON_CREDITOS_COR REAL, HCANT_CREDITOS INTEGER,  HCANT_CREDITOS_DOL INTEGER,  HMON_CREDITOS_COR REAL,"
           "ESTADO TEXT, FECHA TEXT, FECHADELMOVIL TEXT,  ID_SYNC INTEGER"
            ")";
       await db.execute(sql);

       sql = "CREATE TABLE Cobros("
           "ID_USUARIO INTEGER,"
           "CODIGO_OPERACION TEXT,"
           "ID_MONEDA INTEGER,"
           "CODIGO_CLIENTE INTEGER,"
           "NOM_CLIENTE TEXT,"
           "NUM_CUOTA_MORA INTEGER,"
           "FEC_PRIMERA_CUOTA_MORA TEXT,"
           "DIAS_MORA INTEGER,"
           "MONTO_CAPITAL REAL,"
           "MONTO_INTERES REAL,"
           "MONTO_DESCUENTOS REAL,"
           "MONTO_CARGOS REAL,"
           "MONTO_MORA REAL,"
           "MONTO_PENAL REAL,"
           "TOTAL REAL,"
           "ESTADO TEXT,"
           "ABONO_HOY REAL,"
           "CATEGORIA TEXT,"
           "ID_CARTERA TEXT,"
           "ESTADO_CUOTA TEXT,"
           "FECHA_ULT_VEN TEXT,"
           "FECHA TEXT, "
           "FECHADELMOVIL TEXT, "
           "ID_SYNC INTEGER"
           ")";
        await db.execute(sql);

        
       sql = "CREATE TABLE DETALLECOBROS ("
            "NOMBRE_COMPLETO TEXT,"
            "CEDULA TEXT,"
            "DIR_CLIENTE TEXT,"
            "TELEFONO1 TEXT,"
            "CODIGO_OPERACION TEXT,"
            "ID_CLIENTE INTEGER,"
            "NOM_MONEDA TEXT,"
            "FRECUENCIA TEXT,"
            "NOM_CARTERA INTEGER,"
            "TOTAL_CUOTAS INTEGER,"
            "CUOTAS_PAGADAS INTEGER,"
            "CUOTAS_PENDIENTES INTEGER,"
            "CUOTAS_MORA INTEGER,"
            "FEC_ULT_PAGO TEXT,"
            "FEC_PRIMERA_CUOTA_MORA TEXT,"
            "NUM_CUOTA_MORA INTEGER,"
            "DIAS_MORA INTEGER,"
            "MONTO_MORA REAL,"
            "MONTO_INTERES REAL,"
            "MONTO_DESCUENTOS REAL,"
            "MONTO_PENAL REAL,"
            "MONTO_CARGOS REAL,"
            "MONTO_CAPITAL REAL,"
            "TOTAL REAL,"
            "ABONO_HOY REAL,"
            "FECHA TEXT, FECHADELMOVIL TEXT, ID_SYNC INTEGER"
            ")";
        await db.execute(sql);

        sql = "CREATE TABLE PAGOS ("
        "ID_PAGO INTEGER,"
        "ID_PAGO_MES INTEGER,"
        "ID_OFICINA INTEGER,"
        "ID_USUARIO INTEGER,"
        "ID_MONEDA INTEGER,"
        "CODIGO_OPERACION TEXT,"
        "FACTURA TEXT,"
        "CODIGO_CLIENTE INTEGER,"
        "FECHA_PAGO TEXT,"
        "MONTO_PAGO REAL,"
        "ABONO_EXTRA TEXT,"
        "PENDIENTE TEXT,"
        "CATEGORIA TEXT,"
        "CATEGORIA_DPAG TEXT,"
        "TELEFONO_SMS TEXT,"
        "OBSERVACION TEXT,"
        "ESTADO TEXT,"
        "PERMIT_IMP TEXT,"
        "CANT_IMP INTEGER,"
        "FECHA TEXT,"
        "FECHADELMOVIL TEXT,"
        "ID_SYNC INTEGER,"
        "ID_PAGO_SERVER INTEGER,"
        "SEND INTEGER DEFAULT 0"
        ")";
        await db.execute(sql);

  }

  // ACTUALIZACION POR VERSIONES
  void _upgradeTables(Database db, int oldVersion, int newVersion) async {
    
  }

  // METODOS DE LA TABLA Sincronizar
  Future<List<Map<String, dynamic>>> sincronizar_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("Sincronizar", where: 'ID_SYNC = ?', whereArgs: [idSync], orderBy: 'FECHA ASC');
    return result;
  }

  Future<int> sincronizar_insert(Sincronizar cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("Sincronizar", cObject.toMap());
    return result;
  }

  Future<int> sincronizar_update(Sincronizar cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.update("Sincronizar", cObject.toMap(),where: 'ID_SYNC = ?', whereArgs: [cObject.ID_SYNC]);
    return result;
  }

  Future<int> sincronizar_delete(Sincronizar cObject) async {
    Database db = await _databaseHelper.database;
    int result = await db.delete("Sincronizar", where: 'ID_SYNC = ?', whereArgs: [cObject.ID_SYNC]);
    return result;
  }

  Future<int> sincronizar_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from Sincronizar where ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> sincronizar_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from Sincronizar');
    return x;
  }

  Future<int> sincronizar_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Sincronizar", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }
  
  Future<List<Sincronizar>> sincronizar_getRowByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Sincronizar", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<Sincronizar> cObjectList = List<Sincronizar>();
    Sincronizar sincronizar = new Sincronizar();
    for (int i = 0; i < count; i++) {
      sincronizar = Sincronizar.fromJson(cObjectMapList[i]);
      cObjectList.add(sincronizar);
    }
    return cObjectList;
  }

  Future<List<Sincronizar>> sincronizar_getList() async {
    var cObjectMapList = await sincronizar_getMapList();
    int count = cObjectMapList.length;
    List<Sincronizar> cObjectList = List<Sincronizar>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(Sincronizar.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA USER
  Future<List<Map<String, dynamic>>> user_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("User", where: 'ID_SYNC = ?', whereArgs: [idSync], orderBy: 'FECHA, ID_USUARIO ASC');
    return result;
  }

  Future<int> user_insert(User cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("User", cObject.toMap());
    return result;
  }

  Future<int> user_update(User cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.update("User", cObject.toMap(), where: 'ID_USUARIO = ? AND ID_SYNC= ?', whereArgs: [cObject.ID_USUARIO, cObject.ID_SYNC]);
    return result;
  }

  Future<int> user_delete(User cObject) async {
    Database db = await _databaseHelper.database;
    int result = await db.delete("User", where: 'ID_USUARIO = ? AND ID_SYNC= ?', whereArgs: [cObject.ID_USUARIO, cObject.ID_SYNC]);
    return result;
  }

  Future<int> user_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from User WHERE ID_SYNC= $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> user_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from User');
    return x;
  }

  Future<int> user_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("User", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }
  
  Future<User> user_getRowByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("User", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<User> cObjectList = List<User>();
    User user = new User();
    for (int i = 0; i < count; i++) {
      user = User.fromJson(cObjectMapList[i]);
      cObjectList.add(user);
    }
    if (count>0) {
      return cObjectList[0];
    }
    else
      return user;
  }

  Future<List<User>> user_getList() async {
    var cObjectMapList = await user_getMapList();
    int count = cObjectMapList.length;
    List<User> cObjectList = List<User>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(User.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA Parametros
  Future<List<Map<String, dynamic>>> parametros_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("Parametros",where: 'ID_SYNC = ?', whereArgs: [idSync], orderBy: 'ID_PARAMETRO ASC');
    return result;
  }

  Future<int> parametros_insert(Parametros cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("Parametros", cObject.toMap());
    return result;
  }

  Future<int> parametros_update(Parametros cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.delete("Parametros", where: 'ID_PARAMETRO = ? AND ID_SYNC= ?', whereArgs: [cObject.ID_PARAMETRO, cObject.ID_SYNC]);
    return result;
  }

  Future<int> parametros_delete(Parametros cObject) async {
    Database db = await _databaseHelper.database;
    int result = await db.update("Parametros", cObject.toMap(), where: 'ID_PARAMETRO = ? AND ID_SYNC= ?', whereArgs: [cObject.ID_PARAMETRO, cObject.ID_SYNC]);
    return result;
  }

  Future<int> parametros_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from Parametros where ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> parametros_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE FROM Parametros');
    return x;
  }

  Future<int> parametros_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Parametros", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }

  Future<Parametros> parametros_getRowByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Parametros", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<Parametros> cObjectList = List<Parametros>();
    Parametros parametros = new Parametros();
    for (int i = 0; i < count; i++) {
      parametros = Parametros.fromJson(cObjectMapList[i]);
      cObjectList.add(parametros);
    }
    if (count>0) {
      return cObjectList[0];
    }
    else
      return parametros;

  }

  Future<List<Parametros>> Parametros_getList() async {
    var cObjectMapList = await parametros_getMapList();
    int count = cObjectMapList.length;
    List<Parametros> cObjectList = List<Parametros>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(Parametros.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA METAS
  Future<List<Map<String, dynamic>>> metas_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("Metas",where: 'ID_SYNC= ?', whereArgs: [idSync], orderBy: 'FECHA ASC');
    return result;
  }

  Future<int> metas_insert(Metas cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("Metas", cObject.toMap());
    return result;
  }

  // Future<int> metas_update(Metas cObject) async {
  //   Database db = await _databaseHelper.database;
  //   var result = await db.update("Metas", cObject.toMap(),
  //       where: 'IND = ? AND ID_SYNC = ?', whereArgs: [cObject.IND, cObject.ID_SYNC]);
  //   return result;
  // }

  // Future<int> metas_delete(Metas cObject) async {
  //   Database db = await _databaseHelper.database;
  //   int result = await db.delete("Metas", where: 'IND = ? AND ID_SYNC = ?', whereArgs: [cObject.IND, cObject.ID_SYNC]);
  //   return result;
  // }

  Future<int> metas_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from Metas where ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> metas_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from Metas');
    return x;
  }

  Future<int> metas_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Metas", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }

  Future<Metas> metas_getRowByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Metas", where: whereString, whereArgs: whereArguments);

    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<Metas> cObjectList = List<Metas>();
    Metas metas = new Metas();
    for (int i = 0; i < count; i++) {
      metas = Metas.fromJson(cObjectMapList[i]);
      cObjectList.add(metas);
    }
    if (count>0) {
      return cObjectList[0];
    }
    else
      return metas;

  }

  Future<List<Metas>> metas_getList() async {
    var cObjectMapList = await metas_getMapList();
    int count = cObjectMapList.length;
    List<Metas> cObjectList = List<Metas>();
    for (int i = 0; i < count; i++) {
     cObjectList.add(Metas.fromJson(cObjectMapList[i])); 
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA Cobros
  Future<List<Map<String, dynamic>>> cobros_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("Cobros", where: 'ID_SYNC = ?', whereArgs: [idSync], orderBy: 'FECHA ASC');
    return result;
  }

  Future<int> cobros_insert(Cobros cObject) async {
    Database db = await _databaseHelper.database;
   // cObject.FEC_PRIMERA_CUOTA_MORA = cObject.FEC_PRIMERA_CUOTA_MORA.substring(0,10);
    if(cObject.FECHA_ULT_VEN == null){
      cObject.FECHA_ULT_VEN =   "";
    }
    var result = await db.insert("Cobros", cObject.toMap());
    return result;
  }

  // Future<int> cobros_update(Cobros cObject) async {
  //   Database db = await _databaseHelper.database;
  //   var result = await db.update("Cobros", cObject.toMap(), where: 'CODIGO_OPERACION = ? AND ID_SYNC = ?', whereArgs: [cObject.CODIGO_OPERACION, cObject.ID_SYNC]);
  //   return result;
  // }

  // Future<int> cobros_delete(Cobros cObject) async {
  //   Database db = await _databaseHelper.database;
  //   int result = await db.delete("Cobros",
  //       where: 'CODIGO_OPERACION = ? AND ID_SYNC = ?', whereArgs: [cObject.CODIGO_OPERACION, cObject.ID_SYNC]);
  //   return result;
//  }

  Future<int> cobros_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from Cobros WHERE ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> cobros_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from Cobros');
    return x;
  }

  Future<int> cobros_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Cobros", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }

  Future<List<Cobros>> cobros_getRowsByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("Cobros", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<Cobros> cObjectList = List<Cobros>();
    Cobros cobro = new Cobros();
    for (int i = 0; i < count; i++) {
      cobro = Cobros.fromJson(cObjectMapList[i]);
      cObjectList.add(cobro);
    }
      return cObjectList;

  }

  Future<List<Cobros>> cobros_getList() async {
    var cObjectMapList = await cobros_getMapList();
    int count = cObjectMapList.length;
    List<Cobros> cObjectList = List<Cobros>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(Cobros.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA Detalle de Cobros
  Future<List<Map<String, dynamic>>> detalledecobros_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("DETALLECOBROS", where: "IND_SYNC = ?", whereArgs: [idSync], orderBy: 'FECHA ASC');
    return result;
  }

  Future<int> detalledecobros_insert(DetalledeCobros cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("DETALLECOBROS", cObject.toMap());
    return result;
  }

  Future<int> detalledecobros_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from DETALLECOBROS where ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> detalledecobros_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from DETALLECOBROS');
    return x;
  }

  Future<int> detalledecobros_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("DETALLECOBROS", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }

  Future<List<DetalledeCobros>> detalledecobros_getRowsByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("DETALLECOBROS", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<DetalledeCobros> cObjectList = List<DetalledeCobros>();
    DetalledeCobros cobro = new DetalledeCobros();
    for (int i = 0; i < count; i++) {
      cobro = DetalledeCobros.fromJson(cObjectMapList[i]);
      cObjectList.add(cobro);
    }
      return cObjectList;

  }

  Future<List<DetalledeCobros>> detalledecobros_getList() async {
    var cObjectMapList = await pagos_getMapList();
    int count = cObjectMapList.length;
    List<DetalledeCobros> cObjectList = List<DetalledeCobros>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(DetalledeCobros.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }

  // METODOS DE LA TABLA Detalle del Pago
  Future<List<Map<String, dynamic>>> pagos_getMapList() async {
    Database db = await _databaseHelper.database;
    var result = await db.query("PAGOS", where: 'ID_SYNC = ?', whereArgs: [idSync] , orderBy: 'FECHA ASC');
    return result;
  }

  Future<int> pagos_insert(DetalledeCobros cObject) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert("PAGOS", cObject.toMap());
    return result;
  }

  Future<int> pagos_getRowsCount() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from PAGOS where: ID_SYNC = $idSync');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> pagos_deleteAll() async {
    Database db = await _databaseHelper.database;
    int x = await db.rawDelete('DELETE from PAGOS');
    return x;
  }

  Future<int> pagos_getCountByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("PAGOS", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    return count;
  }

  Future<List<Pagos>> pagos_getRowsByWhere(String pwhereString,List<dynamic> pwhereArgs) async {
    Database db = await _databaseHelper.database;
    String whereString = pwhereString;
    List<dynamic> whereArguments = pwhereArgs;
    var result = await db.query("PAGOS", where: whereString, whereArgs: whereArguments);
    var cObjectMapList = await result;
    int count = cObjectMapList.length;
    List<Pagos> cObjectList = List<Pagos>();
    Pagos cobro = new Pagos();
    for (int i = 0; i < count; i++) {
      cobro = Pagos.fromJson(cObjectMapList[i]);
      cObjectList.add(cobro);
    }
      return cObjectList;

  }

  Future<List<Pagos>> pagos_getList() async {
    var cObjectMapList = await pagos_getMapList();
    int count = cObjectMapList.length;
    List<Pagos> cObjectList = List<Pagos>();
    for (int i = 0; i < count; i++) {
      cObjectList.add(Pagos.fromJson(cObjectMapList[i]));
    }
    return cObjectList;
  }
  

}
