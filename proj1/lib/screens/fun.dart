import 'package:flutter/material.dart';
import 'package:proj1/screens/dashBoard.dart';
import '../model/stuClass.dart';
import '../db/dBase.dart';

class Fun extends StatefulWidget {
  const Fun({ Key? key }) : super(key: key);

  @override
  State<Fun> createState() => _FunState();
}

class _FunState extends State<Fun> {

  TextEditingController name = new TextEditingController();
  TextEditingController clgname = new TextEditingController();
  TextEditingController branch = new TextEditingController();
  TextEditingController year = new TextEditingController();

  List<StuClass> stuList = [];
  
  // @override
  // void initState() {
  //   super.initState();
  //   Dbase.instance.queryAllRows().then((value) {
  //     setState(() {
  //       value?.forEach((element) {
  //         stuList.add(StuClass(
  //             id: element['id'], 
  //             name: element["name"],
  //             clgname: element["clgname"],
  //             branch: element["branch"],
  //             year: element["year"],
  //           )
  //         );
  //       });
  //     });
  //   }).catchError((error) {
  //     print(error);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Name"),
                controller: name,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter College Name"),
                controller: clgname,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Branch"),
                controller: branch,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Year"),
                controller: year,
              ),
            ),
            SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: (){
                _addToDb;
                Navigator.pop(context);
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => DashBoard())
                // );
              },
              child: Text("Add"),
            )

          ],
        ),
      ),
    );
  }
 
  void _addToDb() async {
    String nam = name.text;
    String clgnam = clgname.text;
    String branc = branch.text;
    String yea = year.text;
    var id = await Dbase.instance.insert(StuClass(name: nam, clgname: clgnam, branch: branc, year: yea));
    setState(() {
      stuList.insert(0, StuClass(id: id, name: nam, clgname: clgnam, branch: branc, year: yea));
    });
  }
}