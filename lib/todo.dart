import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/text.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List todos = [];
  String input = "";




  @override
  initState() {
    super.initState();
    // todos.add("Item1");
    getList_Data();
  }

  getList_Data() async {
    var storage = await SharedPreferences.getInstance();
    todos.add(storage.getStringList('save_list'));
  }

  setList_Data(String n) async {
    var storage = await SharedPreferences.getInstance();
    todos.add(storage.setStringList('save_list', n));
  }

  removeList_Data() async {
    var storage = await SharedPreferences.getInstance();
    todos.add(storage.remove('save_list'));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff888080),
      appBar: AppBar(
        title: Text("100만원 모으면 뭐 할지 리스트 작성"),backgroundColor: Color(0xff888080)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Add Todolist"),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FloatingActionButton(onPressed: (){
                        setState(() {
                          setList_Data(input);
                        });
                        Navigator.of(context).pop();	// input 입력 후 창 닫히도록
                      },
                          child: Text("Add"))
                    ]
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(	// 삭제 버튼 및 기능 추가
                key: Key(todos[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      title: Text(todos[index]),
                      trailing: IconButton(icon: Icon(
                          Icons.delete,
                          color: Colors.red
                      ),
                          onPressed: () {
                            setState(() {
                              todos.removeAt(index);
                            });
                          }),
                    )
                ));
          }),
    );
  }
}