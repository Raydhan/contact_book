import 'package:contact_book/main.dart';
import 'package:contact_book/second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class demo1 extends StatefulWidget {
  Database database;

  demo1(this.database);

  @override
  State<demo1> createState() => _demo1State();
}

class _demo1State extends State<demo1> {
  List name = [];
  List contact = [];
  List id = [];

  get() async {
    String qry = "select * from student";
    List<Map> list = [];
    list = await widget.database.rawQuery(qry);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View List"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            name.clear();
            contact.clear();
            id.clear();
            List<Map>? test = [];
            if (snapshot.hasData) {
              test = snapshot.data as List<Map>?;
              test!.forEach((element) {
                id.add(element['id']);
                name.add(element['name']);
                contact.add(element['contact']);
              });
            }
            return ListView.builder(
              itemCount: id.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    name[index],
                  ),
                  subtitle: Text(contact[index]),
                  // tileColor: Colors.green,
                  // textColor: Colors.white,
                  leading: Text(
                    id[index].toString(),
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () async {
                          String del =
                              "delete from student where id = ${id[index]}";
                          int q1 = await widget.database.rawDelete(del);
                          print(q1);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return demo2(id[index], name[index],
                                    contact[index], widget.database);
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          fixedSize: Size(80, 40),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return demo();
              },
            ),
          );
        },
        child: Text("Add"),
      ),
    );
  }
}
