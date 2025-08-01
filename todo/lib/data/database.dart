

import 'package:hive_flutter/hive_flutter.dart'; 

class TodoDatabase {

  // List todoList = [
  //   ['Make a todo app', false],
  // ];
  List todoList = [];
  
  //reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time running the app
  void createInitialData(){
    todoList = [
      ['Make a todo app', false],
    ];
  }

  //load the data from the database
  void loadData(){
    todoList = _myBox.get('TODOLIST');
  }

  //update the database
  void updateData(){
    _myBox.put('TODOLIST', todoList);
  }
}