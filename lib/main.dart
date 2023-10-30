import 'package:contact_book/first.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
    debugShowCheckedModeBanner: false,
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  Database? database;

  get() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contactbook.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, contact TEXT)');
    });
  }

  @override
  void initState() {
    super.initState();

    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Book"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        TextField(
          cursorColor: Colors.black,
          controller: t1,
          decoration: const InputDecoration(
            labelText: "Name",
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.black26,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            // counterText: "Hello",
            hintText: "Enter Name",
            counterStyle: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: 20,),
        TextField(maxLength: 10,
          cursorColor: Colors.black,
          controller: t2,
          decoration: const InputDecoration(
            labelText: "Contact",
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.black26,
            hintText: "Enter Contact",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            prefix: Text(
              "+91",
              style: TextStyle(color: Colors.black),
            ),
            counterStyle: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            String name = t1.text;
            String contact = t2.text;

            String q = "insert into student values(null,'$name','$contact')";
            int t;
            t = await database!.rawInsert(q);
            print(t);

            t1.text = "";
            t2.text = "";
          },
          child: Text("Submit"),
          style: ElevatedButton.styleFrom(primary: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return demo1(database!);
              },
            ));
          },
          child: Text("View List"),
          style: ElevatedButton.styleFrom(primary: Colors.black),
        ),
      ]),
    );
  }
}
