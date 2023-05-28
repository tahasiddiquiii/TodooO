import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoflutter/data/database.dart';
import 'package:todoflutter/util/dialog_box.dart';
import 'package:todoflutter/util/todo_tile.dart';
import 'package:todoflutter/util/wavy_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box("mybox");

  @override
  void initState() {
    // if there is no current task list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDataBase();

    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value;
    });
    db.updateDataBase();
  }

  // create a new task
  final _newtaskNameController = TextEditingController();
  void createNewTodo() {
    // show alert dialog for user to enter the new task details
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _newtaskNameController,
          hintText: 'Enter Task..',
          onSave: saveNewTodo,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new task
  void saveNewTodo() {
    // add new task to todays task list
    setState(() {
      db.toDoList.add([_newtaskNameController.text, false]);
    });

    // clear textfield
    _newtaskNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // cancel new task
  void cancelDialogBox() {
    // clear textfield
    _newtaskNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open Todo Edit to edit
  void openTodoEdit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _newtaskNameController,
          hintText: db.toDoList[index][0],
          onSave: () => saveExistingTodo(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing task with a new name
  void saveExistingTodo(int index) {
    setState(() {
      db.toDoList[index][0] = _newtaskNameController.text;
    });
    _newtaskNameController.clear();
    Navigator.pop(context);
    db.updateDataBase();
  }

  // delete task
  void deleteTodo(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 57, 69),
      appBar: const WavyAppBar(),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: createNewTodo,
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // list of task
          ListView.builder(
            padding: EdgeInsets.only(
              bottom: 120,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                editTapped: (context) => openTodoEdit(index),
                deleteTapped: (context) => deleteTodo(index),
                deleteFunction: (context) {},
              );
            },
          )
        ],
      ),
    );
  }
}
