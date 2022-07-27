import 'package:flutter/material.dart';
import 'package:loginform/Dbhelper.dart';
import 'package:loginform/firastpage.dart';
import 'package:sqflite/sqflite.dart';


class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {

  List<Map<String, Object?>> l = List.empty(growable: true);
  Database? db;
  bool status = false;
  @override
  void initState() {
    super.initState();


    getalldata();

  }

  getalldata() async {


    db = await Dbhelper().creatdatabase();
    String qry = "SELECT * FROM Loginpage";
    List<Map<String, Object?>> x = await db!.rawQuery(qry);
    l.addAll(x);

    status = true;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("View Page")),
      body: status ? (l.length>0 ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {

          Map m = l[index];
          return ListTile(
            onLongPress: () {

              showDialog(context: context, builder: (context) {

                return AlertDialog(
                  title: Text("Delete"),
                  content: Text("Ary you sure to delete data"),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                      int id = m['id'];

                      String qry = "DELETE FROM Loginpage WHERE  id= '$id'";
                      db!.rawDelete(qry);
                      l.removeAt(index);
                      setState(() {

                      });

                    }, child: Text("Yes")),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text("No"))
                  ],
                );

              },);

            },
            leading: Text("${m['id']}"),
            title: Text("${m['firstname']}"),
            trailing: IconButton(onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return firstpage("update",map: m,);
              },));

            }, icon: Icon(Icons.edit)),
          );

      },): Center(child: Text("No Data Found"),)) : Center(child: CircularProgressIndicator(),),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return firstpage("insert");
        },));
      },child: Icon(Icons.add)),



    );
  }

}
