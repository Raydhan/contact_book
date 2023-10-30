import 'package:contact_book/first.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class demo2 extends StatefulWidget {
  int id;
  String name, contact;
  Database database;

  demo2(this.id, this.name, this.contact, this.database);

  @override
  State<demo2> createState() => _demo2State();
}

class _demo2State extends State<demo2> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    t1.text = widget.name;
    t2.text = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact_List"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
            cursorColor: Colors.black,
            controller: t1,
            decoration: InputDecoration(
              hintText: "Name",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          TextField(cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            maxLength: 10,
            controller: t2,
            decoration: InputDecoration(
              hintText: "Contact",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              prefix: Text("+91",style: TextStyle(color: Colors.black),),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () async {
              String name = t1.text;
              String contact = t2.text;

              String up =
                  "update student set name = '$name',contact = '$contact' where id = ${widget.id}";
              int t3 = await widget.database.rawUpdate(up);
              if (t3 == 1) {
                print("Data Updated");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return demo1(widget.database);
                    },
                  ),
                );
              } else {
                print("Data Not Updated");
              }
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
