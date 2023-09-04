import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  // refrence the box
  final _myBox = Hive.box('mybox');

  // run this if this is the 1st time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Do Code", false],
      ["Meet a Friend", false]
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
