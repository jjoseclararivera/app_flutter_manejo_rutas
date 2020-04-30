import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:crecosaappcobranza/clases/models.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ListCobros extends StatefulWidget {
  static const String routeName = "/listcobros";
  const ListCobros({Key key, this.codCategoria}) : super(key: key);
  final String codCategoria;

  @override
  ListCobrosState createState() => ListCobrosState();
}

class ListCobrosState extends State<ListCobros> {
  DatabaseHelper db = DatabaseHelper();
  List<Cobros> cobroList;
  int count = 0;
  final formatter = new NumberFormat("#,###.00");
  TextEditingController editingController = TextEditingController();

 

  @override
  Widget build(BuildContext context) {
  
    if (cobroList == null) {
      cobroList = List<Cobros>();
      updateListView();
    }

    return Scaffold(
      appBar: getAppBar("Cobros de"),
      body: getTodoListViewSeach(),
      drawer: getDrawer(context),
    );
  }

  void updateListView() {

    final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      
      String pwhereString = 'CATEGORIA = ?';
      List<dynamic> pwhereArgs = [widget.codCategoria.toString()];
      Future<List<Cobros>> cobroFuture = db.cobros_getRowsByWhere(pwhereString, pwhereArgs);
      
     // Future<List<Cobros>> cobroFuture = db.cobros_getList();
      cobroFuture.then((list) {
        setState(() {
          this.cobroList = list;
          this.count = this.cobroList.length;
        });
      });
    });
  }

  void filterSearchResults(String query) {
     final Future<Database> dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      /*
      String pwhereString = 'CATEGORIA = ? AND NOM_CLIENTE LIKE ?';
      List<dynamic> pwhereArgs = [widget.codCategoria.toString(), "%" + query + "%"];
      */
       String pwhereString = 'NOM_CLIENTE LIKE ?';
      List<dynamic> pwhereArgs = ["%" + query + "%"];
      Future<List<Cobros>> cobroFuture = db.cobros_getRowsByWhere(pwhereString, pwhereArgs);
      cobroFuture.then((list) {
        setState(() {
          this.cobroList = list;
          this.count = this.cobroList.length;
        });
      });
    });


  }

  Container getTodoListViewSeach(){
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                 onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Buscar",
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: getTodoListView(),
            )
            ]
            )
            );

  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count == null ? 0 : count,
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      itemBuilder: (BuildContext context, int position) {
        return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                   children: <Widget>[
                      Card(
                        color: (position % 2) == 0 ? Colors.white : Colors.grey[100],
                        elevation: 4.0,
                        child: ListTile(
                          title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                          Text("Credito: " + this.cobroList[position].CODIGO_OPERACION,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                          Text("Cliente: " + this.cobroList[position].NOM_CLIENTE,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                         // new Divider(),
                                          Text("Abono:   " + this.cobroList[position].ABONO_HOY.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                          Text("Cartera: " + this.cobroList[position].CATEGORIA.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                        ],
                                  ),
                          subtitle:
                                Column(
                                children: <Widget>[
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                          Text("Fecha ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                          new Divider(),
                                          Text("Cuotas",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                               new Divider(),
                                          Text("Dias  ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                               new Divider(),
                                          Text("Saldo ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                           Text("Extra ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                        ],
                                  ),
                                  new Divider(),
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                          Text(this.cobroList[position].FEC_PRIMERA_CUOTA_MORA.toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                          new Divider(),
                                          Text(this.cobroList[position].NUM_CUOTA_MORA.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                               new Divider(),
                                          Text(this.cobroList[position].DIAS_MORA.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                               new Divider(),
                                          Text((formatter.format(this.cobroList[position].TOTAL)).toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                          Text((formatter.format(this.cobroList[position].TOTAL - this.cobroList[position].ABONO_HOY)).toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                        ],
                                  ),
                                  ],
                                  ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(
                                  Icons.attach_money,
                                  size: 35,
                                  color: (position % 2) == 0
                                      ? Colors.lightBlueAccent
                                      : Colors.lightBlueAccent,
                                ),
                                onTap: () {
                                  showAlertDialog(
                                      context,
                                      this.cobroList[position].NOM_CLIENTE.toString(),
                                      "Pagar este credito");
                                },
                              ),
                            ],
                          ),
                          ),
                      )  
          ],
        ));
      },
    );
  }
}
