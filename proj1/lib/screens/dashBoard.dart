import 'package:flutter/material.dart';
import 'package:proj1/screens/detailsScreen.dart';
import 'package:proj1/screens/fun.dart';
import '../model/stuClass.dart';
import '../db/dBase.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({ Key? key }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

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

    Dbase.instance.queryAllRows().then((value) {
      setState(() {
        value?.forEach((element) {
          stuList.add(StuClass(
              id: element['id'], 
              name: element["name"],
              clgname: element["clgname"],
              branch: element["branch"],
              year: element["year"],
            )
          );
        });
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text("Dash Board")),
      body: Column(
        children:[
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: stuList.isEmpty
                    ? Container()
                    : ListView.builder(
                      itemCount: stuList.length,
                      itemBuilder: (ctx, index) {
                        if (index == stuList.length) return Container();
                        return ListTile(
                          title: Text(stuList[index].name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _delete(stuList[index].id),
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  stuList[index]
                                ),
                              ),
                            );
                          },
                        );
                      }),
              ),
            )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => Fun()
                  )
                );
              },
        child: Icon(Icons.add,),
      ),
    );
  }
    void _delete(int? id) async {
    await Dbase.instance.delete(id!);
    setState(() {
      stuList.removeWhere((element) => element.id == id);
    });
  }
}