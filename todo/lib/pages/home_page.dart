import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'package:todo/components/dialog_box.dart';
import 'package:todo/components/todo_tile.dart';
import 'package:todo/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the box
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //if this is the first time opening the app, create default data
  if(_myBox.get('TODOLIST')  == null){
    db.createInitialData();
  }else{
    //there already exist data == not first time opening or using the app
    db.loadData();
  }

    super.initState();
  }
  
  //text Controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void saveNewTodo() {
    setState(() {
      String userInput = _controller.text;
      if (userInput.isNotEmpty) {
        db.todoList.add([userInput, false]);
        _controller.clear();
        Navigator.pop(context);
      }
    });
    db.updateData();
  }

  void addNewTodo() {
    //open a modal?
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSaved: saveNewTodo,
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
  //delete a todo

  void deleteTodo(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO DO', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTodo,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTodo: (context) => deleteTodo(index),
          );
        },
      ),
    );
  }
}
