import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/utils/dialog_box.dart';
import 'package:todoapp/utils/todo_tile.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // refrence the hive box
  final _myBox = Hive.box('mybox');
  // text controller
  final _controller = TextEditingController();
  // list of doto task
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this the 1st time ever opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // There already exists data
      db.loadData();
    }
    super.initState();
  }

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

// save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

// create a new Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[200],
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        leading: const Icon(Icons.menu),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
