import 'package:crecosaappcobranza/clases/datahelper.dart';
import 'package:crecosaappcobranza/clases/models.dart';
import 'package:crecosaappcobranza/screens/listcobros.dart';
import 'package:crecosaappcobranza/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class Home extends StatefulWidget {
static const String routeName = "/home";

@override
State<StatefulWidget> createState() =>HomeState();
}


class HomeState extends State<Home> {

DatabaseHelper db = DatabaseHelper();
List<Metas> metaList;
int count=0;

@override
Widget build(BuildContext context) {

  if(metaList == null){
    metaList = List<Metas>();
    updateListView();
  }

return Scaffold(
    appBar: getAppBar("Metas de"),
    body: getTodoListView(),
    drawer: getDrawer(context),
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
        
    //   },
    //   tooltip: 'Add Persona',
    //   child: Icon(Icons.add),
    // ),
  );
}

void updateListView() {
  final Future<Database> dbFuture = db.initializeDatabase();
  dbFuture.then((database) {
    Future<List<Metas>> HomeFuture = db.metas_getList();
    HomeFuture.then((list) {
      setState(() {
        this.metaList = list;
        this.count = this.metaList.length;
      });
    });
  }
  );
}

ListView getTodoListView() {

  return ListView.builder(
    itemCount: count==null ? 0: count,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int position) {
      return  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                   children: <Widget>[
                     Card(
        color: (position % 2) == 0 ? Colors.white: Colors.white,
        elevation: 2.0,
        child: ListTile(
           leading: CircleAvatar(
             backgroundColor: (position % 2) == 0 ? Colors.lightBlueAccent : Colors.lightBlueAccent,
             child: Text(this.metaList[position].MCANT_CREDITOS.toString(),
             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
           ),
          title: 
          Column(
            children: <Widget>[
                 Text(this.metaList[position].CATEGORIA,
              style: TextStyle(fontWeight: FontWeight.bold)),
                 

            ]
          ),
       
          subtitle: 
          Column(
          children: <Widget>[
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("CANTIDAD DE CREDITOS A RECUPERAR",
                style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("COR",textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.normal)),
              Text("DOL",textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.normal)),
              Text("TOTAL",textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(this.metaList[position].MCANT_CREDITOS_COR.toString(),textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.metaList[position].MCANT_CREDITOS_DOL.toString(),textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.metaList[position].MCANT_CREDITOS.toString(),textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          ],),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.view_comfy, color:(position % 2) == 0 ? Colors.lightBlueAccent : Colors.lightBlueAccent,),
                onTap: () {
                  //showSnackBar(context, this.metaList[position].CATEGORIA.toString());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>ListCobros(codCategoria: this.metaList[position].IND)
                  ));
                },
              ),
            ],
          ),
          // onTap: () {
          //   debugPrint("ListTile Tapped");
          //   navigateToDetail(this.metaList[position], 'Edit Persona');
          // },
        ),
      )
                   ]
                )
      )
      ;
    },
  );
}


}



