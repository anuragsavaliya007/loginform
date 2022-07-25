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

  List<Map<String, Object?>> l = [];

  bool status = false;
  @override
  void initState() {
    super.initState();


    getalldata();

  }

  getalldata() async {


    Database db = await Dbhelper().creatdatabase();
    String qry = "SELECT * FROM Loginpage";
    l = await db.rawQuery(qry);

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
            leading: Text("${m['id']}"),
            title: Text("${m['firstname']}"),
          );

      },): Center(child: Text("No Data Found"),)) : Center(child: CircularProgressIndicator(),),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return firstpage();
        },));
      },),



    );
  }

}
