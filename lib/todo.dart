import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_save_smoking/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('todo_box');
  runApp(MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff0D3257)),
      home: Todo()));
}

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  late Box<Task> tasksBox;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box('todo_box');
  }



  void onAddTask() {
    if(_textEditingController.text.isEmpty) {
      final newTask = Task(_textEditingController.text = "값이 없음", false);
      tasksBox.add(newTask);
      Navigator.pop(context);
      _textEditingController.clear();
      return;
    }
    else if (_textEditingController.text.isNotEmpty) {
      final newTask = Task(_textEditingController.text, false);
      tasksBox.add(newTask);
      Navigator.pop(context);
      _textEditingController.clear();
      return;
    }



  }

  void onUpdateTask(int index, Task task) {
    tasksBox.putAt(index, Task(task.title, task.completed));
    return;
  }

  void onDeleteTask(int index) {
    tasksBox.deleteAt(index);
    return;
  }




  void _login() {
    onAddTask();
  }

  bool _isValid() {
    return (_textEditingController.text.length >= 2);
  }
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff888080),
        title: Text('100만원 생기면 뭐하지?', ),
        brightness: Brightness.dark,
      ),
      body:ValueListenableBuilder(
        valueListenable: tasksBox.listenable(),
        builder: (context, value, child) {
          if (tasksBox.length > 0 && tasksBox.values.isNotEmpty) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  Task task;
                  if(tasksBox.get(index) == null)
                    {
                      tasksBox.delete(index);
                      task = Task("값이 없음", false);
                      tasksBox.add(task);
                    }
                  else if(tasksBox.get(index) != null)
                  {
                    
                  }
                  return ListTile(
                    title: Text(task.title),
                    leading: Checkbox(
                        activeColor: Color(0x800d3257),
                        value: task.completed,
                        onChanged: (bool? value) => onUpdateTask(index, task)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onDeleteTask(index),
                    ),
                  );
                },
              itemCount: tasksBox.length,
              separatorBuilder: (context, index) => Divider(),
            );
          }

          else {
            return EmptyList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff888080),
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('하고 싶은 사고 싶은 것을 기록해 보세요'),
              content: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: "입력해 주세요"),
                autofocus: true,
                validator: (String? value){
                  if ((value == null)) {
                    return _textEditingController.text = "값이 없음";
                  } else {
                    return _textEditingController.text = value;
                  }
                },

              ),
              actions: [
                TextButton(onPressed: () => onAddTask(), child: Text('SAVE'))
              ],
            );
          },
        ),
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Icon(Icons.inbox_outlined,
                  size: 80.0, color: Color(0xff0D3257))),
          Container(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              "Don't have any tasks",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
