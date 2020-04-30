class Sincronizar {
  int ID;
  String FECHA;
  String ID_USUARIO;
  int ID_OFICINA;
  String NOMBRE;
  int ROLL;
  int INIT;
  int CLOSED;
  String FECHADELMOVIL;
  int ID_SYNC;

  Sincronizar(
      {ID,
      FECHA,
      ID_USUARIO,
      ID_OFICINA,
      NOMBRE,
      ROLL,
      INIT,
      CLOSED,
      FECHADELMOVIL,
      ID_SYNC});

  // named constructor
  Sincronizar.fromJson(Map<String, dynamic> json)
      : ID = json['ID'],
        FECHA = json['FECHA'],
        ID_USUARIO = json['ID_USUARIO'],
        ID_OFICINA = json['ID_OFICINA'],
        NOMBRE = json['NOMBRE'],
        ROLL = json['ROLL'],
        INIT = json['INIT'],
        CLOSED = json['CLOSED'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  // method
  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'FECHA': FECHA,
      'ID_USUARIO': ID_USUARIO,
      'ID_OFICINA': ID_OFICINA,
      'NOMBRE': NOMBRE,
      'ROLL': ROLL,
      'INIT': INIT,
      'CLOSED': CLOSED,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class User {
  String ID_USUARIO;
  int ID_OFICINA = 0;
  String NOMBRE;
  int ROLL = 0;
  String PASS;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;

  User(
      {ID_USUARIO,
      ID_OFICINA,
      NOMBRE,
      ROLL,
      PASS,
      FECHA,
      FECHADELMOVIL,
      ID_SYNC});

  // named constructor
  User.fromJson(Map<String, dynamic> json)
      : ID_USUARIO = json['ID_USUARIO'],
        ID_OFICINA = json['ID_OFICINA'],
        NOMBRE = json['NOMBRE'],
        ROLL = json['ROLL'],
        PASS = json['PASS'],
        FECHA = json['FECHA'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  // method
  Map<String, dynamic> toMap() {
    return {
      'ID_USUARIO': ID_USUARIO,
      'ID_OFICINA': ID_OFICINA,
      'NOMBRE': NOMBRE,
      'ROLL': ROLL,
      'PASS': PASS,
      'FECHA': FECHA,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class Parametros {
  int ID_PARAMETRO = 0;
  String DET_PARAMETRO;
  String VAL_PARAMETRO;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;

  Parametros(
      {ID_PARAMETRO,
      DET_PARAMETRO,
      VAL_PARAMETRO,
      FECHA,
      FECHADELMOVIL,
      ID_SYNC});

  // named constructor
  Parametros.fromJson(Map<String, dynamic> json)
      : ID_PARAMETRO = json['ID_PARAMETRO'],
        DET_PARAMETRO = json['DET_PARAMETRO'],
        VAL_PARAMETRO = json['VAL_PARAMETRO'],
        FECHA = json['FECHA'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  // method
  Map<String, dynamic> toMap() {
    return {
      'ID_PARAMETRO': ID_PARAMETRO,
      'DET_PARAMETRO': DET_PARAMETRO,
      'VAL_PARAMETRO': VAL_PARAMETRO,
      'FECHA': FECHA,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class Metas {
  int ORDEN;
  String IND;
  String CATEGORIA;
  int MCANT_CREDITOS;
  int MCANT_CREDITOS_DOL;
  int MCANT_CREDITOS_COR;
  int MCANT_CREDITOS_DOL1;
  double MMON_CREDITOS_COR;
  int HCANT_CREDITOS;
  int HCANT_CREDITOS_DOL;
  double HMON_CREDITOS_COR;
  String ESTADO;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;

  Metas(
      {this.ORDEN,
      this.IND,
      this.CATEGORIA,
      this.MCANT_CREDITOS,
      this.MCANT_CREDITOS_DOL,
      this.MCANT_CREDITOS_COR,
      this.MCANT_CREDITOS_DOL1,
      this.MMON_CREDITOS_COR,
      this.HCANT_CREDITOS,
      this.HCANT_CREDITOS_DOL,
      this.HMON_CREDITOS_COR,
      this.ESTADO,
      this.FECHA,
      this.FECHADELMOVIL,
      this.ID_SYNC});

  Metas.fromJson(Map<String, dynamic> json)
      : ORDEN = json['ORDEN'],
        IND = json['IND'],
        CATEGORIA = json['CATEGORIA'],
        MCANT_CREDITOS = json['MCANT_CREDITOS'],
        MCANT_CREDITOS_DOL = json['MCANT_CREDITOS_DOL'],
        MCANT_CREDITOS_COR = json['MCANT_CREDITOS_COR'],
        MCANT_CREDITOS_DOL1 = json['MCANT_CREDITOS_DOL1'],
        MMON_CREDITOS_COR = json['MMON_CREDITOS_COR'],
        HCANT_CREDITOS = json['HCANT_CREDITOS'],
        HCANT_CREDITOS_DOL = json['HCANT_CREDITOS_DOL'],
        HMON_CREDITOS_COR = json['HMON_CREDITOS_COR'],
        ESTADO = json['ESTADO'],
        FECHA = json['FECHA'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  Map<String, dynamic> toMap() {
    return {
      'ORDEN': ORDEN,
      'IND': IND,
      'CATEGORIA': CATEGORIA,
      'MCANT_CREDITOS': MCANT_CREDITOS,
      'MCANT_CREDITOS_DOL': MCANT_CREDITOS_DOL,
      'MCANT_CREDITOS_COR': MCANT_CREDITOS_COR,
      'MCANT_CREDITOS_DOL1': MCANT_CREDITOS_DOL1,
      'MMON_CREDITOS_COR': MMON_CREDITOS_COR,
      'HCANT_CREDITOS': HCANT_CREDITOS,
      'HCANT_CREDITOS_DOL': HCANT_CREDITOS_DOL,
      'HMON_CREDITOS_COR': HMON_CREDITOS_COR,
      'ESTADO': ESTADO,
      'FECHA': FECHA,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class Cobros {
  int ID_USUARIO;
  String CODIGO_OPERACION;
  int ID_MONEDA;
  int CODIGO_CLIENTE;
  String NOM_CLIENTE;
  int NUM_CUOTA_MORA;
  String FEC_PRIMERA_CUOTA_MORA;
  int DIAS_MORA;
  double MONTO_CAPITAL;
  double MONTO_INTERES;
  double MONTO_DESCUENTOS;
  double MONTO_CARGOS;
  double MONTO_MORA;
  double MONTO_PENAL;
  double TOTAL;
  String ESTADO;
  double ABONO_HOY;
  String CATEGORIA;
  String ID_CARTERA;
  String ESTADO_CUOTA;
  String FECHA_ULT_VEN;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;

  Cobros(
      {this.ID_USUARIO,
      this.CODIGO_OPERACION,
      this.ID_MONEDA,
      this.CODIGO_CLIENTE,
      this.NOM_CLIENTE,
      this.NUM_CUOTA_MORA,
      this.FEC_PRIMERA_CUOTA_MORA,
      this.DIAS_MORA,
      this.MONTO_CAPITAL,
      this.MONTO_INTERES,
      this.MONTO_DESCUENTOS,
      this.MONTO_CARGOS,
      this.MONTO_MORA,
      this.MONTO_PENAL,
      this.TOTAL,
      this.ESTADO,
      this.ABONO_HOY,
      this.CATEGORIA,
      this.ID_CARTERA,
      this.ESTADO_CUOTA,
      this.FECHA_ULT_VEN,
      this.FECHA,
      this.FECHADELMOVIL,
      this.ID_SYNC});

  Cobros.fromJson(Map<String, dynamic> json)
      : ID_USUARIO = json['ID_USUARIO'],
        CODIGO_OPERACION = json['CODIGO_OPERACION'],
        ID_MONEDA = json['ID_MONEDA'],
        CODIGO_CLIENTE = json['CODIGO_CLIENTE'],
        NOM_CLIENTE = json['NOM_CLIENTE'],
        NUM_CUOTA_MORA = json['NUM_CUOTA_MORA'],
        FEC_PRIMERA_CUOTA_MORA = json['FEC_PRIMERA_CUOTA_MORA'],
        DIAS_MORA = json['DIAS_MORA'],
        MONTO_CAPITAL = json['MONTO_CAPITAL'],
        MONTO_INTERES = json['MONTO_INTERES'],
        MONTO_DESCUENTOS = json['MONTO_DESCUENTOS'],
        MONTO_CARGOS = json['MONTO_CARGOS'],
        MONTO_MORA = json['MONTO_MORA'],
        MONTO_PENAL = json['MONTO_PENAL'],
        TOTAL = json['TOTAL'],
        ESTADO = json['ESTADO'],
        ABONO_HOY = json['ABONO_HOY'],
        CATEGORIA = json['CATEGORIA'],
        ID_CARTERA = json['ID_CARTERA'],
        ESTADO_CUOTA = json['ESTADO_CUOTA'],
        FECHA_ULT_VEN = json['FECHA_ULT_VEN'],
        FECHA = json['FECHA'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  Map<String, dynamic> toMap() {
    return {
      'ID_USUARIO': ID_USUARIO,
      'CODIGO_OPERACION': CODIGO_OPERACION,
      'ID_MONEDA': ID_MONEDA,
      'CODIGO_CLIENTE': CODIGO_CLIENTE,
      'NOM_CLIENTE': NOM_CLIENTE,
      'NUM_CUOTA_MORA': NUM_CUOTA_MORA,
      'FEC_PRIMERA_CUOTA_MORA': FEC_PRIMERA_CUOTA_MORA,
      'DIAS_MORA': DIAS_MORA,
      'MONTO_CAPITAL': MONTO_CAPITAL,
      'MONTO_INTERES': MONTO_INTERES,
      'MONTO_DESCUENTOS': MONTO_DESCUENTOS,
      'MONTO_CARGOS': MONTO_CARGOS,
      'MONTO_MORA': MONTO_MORA,
      'MONTO_PENAL': MONTO_PENAL,
      'TOTAL': TOTAL,
      'ESTADO': ESTADO,
      'ABONO_HOY': ABONO_HOY,
      'CATEGORIA': CATEGORIA,
      'ID_CARTERA': ID_CARTERA,
      'ESTADO_CUOTA': ESTADO_CUOTA,
      'FECHA_ULT_VEN': FECHA_ULT_VEN,
      'FECHA': FECHA,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class DetalledeCobros {
  String NOMBRE_COMPLETO;
  String CEDULA;
  String DIR_CLIENTE;
  String TELEFONO1;
  String CODIGO_OPERACION;
  int ID_CLIENTE;
  String NOM_MONEDA;
  String FRECUENCIA;
  String NOM_CARTERA;
  int TOTAL_CUOTAS;
  int CUOTAS_PAGADAS;
  int CUOTAS_PENDIENTES;
  int CUOTAS_MORA;
  String FEC_ULT_PAGO;
  String FEC_PRIMERA_CUOTA_MORA;
  int NUM_CUOTA_MORA;
  int DIAS_MORA;
  double MONTO_MORA;
  double MONTO_INTERES;
  double MONTO_DESCUENTOS;
  double MONTO_PENAL;
  double MONTO_CARGOS;
  double MONTO_CAPITAL;
  double TOTAL;
  double ABONO_HOY;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;

  DetalledeCobros(
      {this.NOMBRE_COMPLETO,
      this.CEDULA,
      this.DIR_CLIENTE,
      this.TELEFONO1,
      this.CODIGO_OPERACION,
      this.ID_CLIENTE,
      this.NOM_MONEDA,
      this.FRECUENCIA,
      this.NOM_CARTERA,
      this.TOTAL_CUOTAS,
      this.CUOTAS_PAGADAS,
      this.CUOTAS_PENDIENTES,
      this.CUOTAS_MORA,
      this.FEC_ULT_PAGO,
      this.FEC_PRIMERA_CUOTA_MORA,
      this.NUM_CUOTA_MORA,
      this.DIAS_MORA,
      this.MONTO_MORA,
      this.MONTO_INTERES,
      this.MONTO_DESCUENTOS,
      this.MONTO_PENAL,
      this.MONTO_CARGOS,
      this.MONTO_CAPITAL,
      this.TOTAL,
      this.ABONO_HOY,
      this.FECHA,
      this.FECHADELMOVIL,
      this.ID_SYNC});

  DetalledeCobros.fromJson(Map<String, dynamic> json)
      : NOMBRE_COMPLETO = json['NOMBRE_COMPLETO'],
        CEDULA = json['CEDULA'],
        DIR_CLIENTE = json['DIR_CLIENTE'],
        TELEFONO1 = json['TELEFONO1'],
        CODIGO_OPERACION = json['CODIGO_OPERACION'],
        ID_CLIENTE = json['ID_CLIENTE'],
        NOM_MONEDA = json['NOM_MONEDA'],
        FRECUENCIA = json['FRECUENCIA'],
        NOM_CARTERA = json['NOM_CARTERA'],
        TOTAL_CUOTAS = json['TOTAL_CUOTAS'],
        CUOTAS_PAGADAS = json['CUOTAS_PAGADAS'],
        CUOTAS_PENDIENTES = json['CUOTAS_PENDIENTES'],
        CUOTAS_MORA = json['CUOTAS_MORA'],
        FEC_ULT_PAGO = json['FEC_ULT_PAGO'],
        FEC_PRIMERA_CUOTA_MORA = json['FEC_PRIMERA_CUOTA_MORA'],
        NUM_CUOTA_MORA = json['NUM_CUOTA_MORA'],
        DIAS_MORA = json['DIAS_MORA'],
        MONTO_MORA = json['MONTO_MORA'],
        MONTO_INTERES = json['MONTO_INTERES'],
        MONTO_DESCUENTOS = json['MONTO_DESCUENTOS'],
        MONTO_PENAL = json['MONTO_PENAL'],
        MONTO_CARGOS = json['MONTO_CARGOS'],
        MONTO_CAPITAL = json['MONTO_CAPITAL'],
        TOTAL = json['TOTAL'],
        ABONO_HOY = json['ABONO_HOY'],
        FECHA = json['FECHA'],
        FECHADELMOVIL = json['FECHADELMOVIL'],
        ID_SYNC = json['ID_SYNC'];

  Map<String, dynamic> toMap() {
    return {
      'NOMBRE_COMPLETO': NOMBRE_COMPLETO,
      'CEDULA': CEDULA,
      'DIR_CLIENTE': DIR_CLIENTE,
      'TELEFONO1': TELEFONO1,
      'CODIGO_OPERACION': CODIGO_OPERACION,
      'ID_CLIENTE': ID_CLIENTE,
      'NOM_MONEDA': NOM_MONEDA,
      'FRECUENCIA': FRECUENCIA,
      'NOM_CARTERA': NOM_CARTERA,
      'TOTAL_CUOTAS': TOTAL_CUOTAS,
      'CUOTAS_PAGADAS': CUOTAS_PAGADAS,
      'CUOTAS_PENDIENTES': CUOTAS_PENDIENTES,
      'CUOTAS_MORA': CUOTAS_MORA,
      'FEC_ULT_PAGO': FEC_ULT_PAGO,
      'FEC_PRIMERA_CUOTA_MORA': FEC_PRIMERA_CUOTA_MORA,
      'NUM_CUOTA_MORA': NUM_CUOTA_MORA,
      'DIAS_MORA': DIAS_MORA,
      'MONTO_MORA': MONTO_MORA,
      'MONTO_INTERES': MONTO_INTERES,
      'MONTO_DESCUENTOS': MONTO_DESCUENTOS,
      'MONTO_PENAL': MONTO_PENAL,
      'MONTO_CARGOS': MONTO_CARGOS,
      'MONTO_CAPITAL': MONTO_CAPITAL,
      'TOTAL': TOTAL,
      'ABONO_HOY': ABONO_HOY,
      'FECHA': FECHA,
      'FECHADELMOVIL': FECHADELMOVIL,
      'ID_SYNC': ID_SYNC,
    };
  }
}

class Pagos{
  int ID_PAGO;
  int ID_PAGO_MES;
  int ID_OFICINA;
  int ID_USUARIO;
  int ID_MONEDA;
  String CODIGO_OPERACION;
  String FACTURA;
  int CODIGO_CLIENTE;
  String FECHA_PAGO;
  double MONTO_PAGO;
  String ABONO_EXTRA;
  String PENDIENTE;
  String CATEGORIA;
  String CATEGORIA_DPAG;
  String TELEFONO_SMS;
  String OBSERVACION;
  String ESTADO;
  String PERMIT_IMP;
  int CANT_IMP;
  String FECHA;
  String FECHADELMOVIL;
  int ID_SYNC;
  int ID_PAGO_ONLINE;

  Pagos({
    this.ID_PAGO,
    this.ID_PAGO_MES,
    this.ID_OFICINA,
    this.ID_USUARIO,
    this.ID_MONEDA,
    this.CODIGO_OPERACION,
    this.FACTURA,
    this.CODIGO_CLIENTE,
    this.FECHA_PAGO,
    this.MONTO_PAGO,
    this.ABONO_EXTRA,
    this.PENDIENTE,
    this.CATEGORIA,
    this.CATEGORIA_DPAG,
    this.TELEFONO_SMS,
    this.OBSERVACION,
    this.ESTADO,
    this.PERMIT_IMP,
    this.CANT_IMP,
    this.FECHA,
    this.FECHADELMOVIL,
    this.ID_SYNC
  });

  Pagos.fromJson(Map<String, dynamic> json)
      : ID_PAGO=json['ID_PAGO'],
        ID_PAGO_MES=json['ID_PAGO_MES'],
        ID_OFICINA=json['ID_OFICINA'],
        ID_USUARIO=json['ID_USUARIO'],
        ID_MONEDA=json['ID_MONEDA'],
        CODIGO_OPERACION=json['CODIGO_OPERACION'],
        FACTURA=json['FACTURA'],
        CODIGO_CLIENTE=json['CODIGO_CLIENTE'],
        FECHA_PAGO=json['FECHA_PAGO'],
        MONTO_PAGO=json['MONTO_PAGO'],
        ABONO_EXTRA=json['ABONO_EXTRA'],
        PENDIENTE=json['PENDIENTE'],
        CATEGORIA=json['CATEGORIA'],
        CATEGORIA_DPAG=json['CATEGORIA_DPAG'],
        TELEFONO_SMS=json['TELEFONO_SMS'],
        OBSERVACION=json['OBSERVACION'],
        ESTADO=json['ESTADO'],
        PERMIT_IMP=json['PERMIT_IMP'],
        CANT_IMP=json['CANT_IMP'],
        FECHA=json['FECHA'],
        FECHADELMOVIL=json['FECHADELMOVIL'],
        ID_SYNC=json['ID_SYNC']
  ;

  Map<String, dynamic> toMap() {
    return {
      'ID_PAGO':ID_PAGO,
      'ID_PAGO_MES':ID_PAGO_MES,
      'ID_OFICINA':ID_OFICINA,
      'ID_USUARIO':ID_USUARIO,
      'ID_MONEDA':ID_MONEDA,
      'CODIGO_OPERACION':CODIGO_OPERACION,
      'FACTURA':FACTURA,
      'CODIGO_CLIENTE':CODIGO_CLIENTE,
      'FECHA_PAGO':FECHA_PAGO,
      'MONTO_PAGO':MONTO_PAGO,
      'ABONO_EXTRA':ABONO_EXTRA,
      'PENDIENTE':PENDIENTE,
      'CATEGORIA':CATEGORIA,
      'CATEGORIA_DPAG':CATEGORIA_DPAG,
      'TELEFONO_SMS':TELEFONO_SMS,
      'OBSERVACION':OBSERVACION,
      'ESTADO':ESTADO,
      'PERMIT_IMP':PERMIT_IMP,
      'CANT_IMP':CANT_IMP,
      'FECHA':FECHA,
      'FECHADELMOVIL':FECHADELMOVIL,
      'ID_SYNC':ID_SYNC,
    };
  }
}
