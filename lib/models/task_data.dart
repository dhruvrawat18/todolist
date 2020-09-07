import 'package:flutter/foundation.dart';
import 'package:todolist/models/task.dart';
import 'dart:collection';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class Storage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> getLocalFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }
}

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  TaskData() {
    init();
  }

  void init() async {
    await readFromFile();
    notifyListeners();
  }

  Future readFromFile() async {
    try {
      final file = await Storage.getLocalFile('todoey.txt');

      if (file != null) {
        // Read the file
        String contents = await file.readAsString();
        Map jsonMap = jsonDecode(contents);
        print(jsonMap);
        fromJson(jsonMap);
      }
    } catch (e) {
      print("readFromFile: $e");
    }
  }

  void writeToFile() async {
    try {
      final file = await Storage.getLocalFile('todoey.txt');
      String json = jsonEncode(toJson());

      // Write the file
      file.writeAsString(json);
    } catch (e) {
      print("writeToFile: $e");
    }
  }

  void fromJson(Map<String, dynamic> json) {
    _tasks = [];
    List<dynamic> jsonItems = json['items'];

    for (var item in jsonItems) {
      _tasks.add(Task.fromJson(item));
    }
  }

  List _encodeToJson(List<Task> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  Map<String, dynamic> toJson() {
    return {'items': _encodeToJson(_tasks)};
  }

  void toggleData(int index) {
    _tasks[index].toggleDone();
    writeToFile();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    writeToFile();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addTask(String taskToAdd) {
    if (taskToAdd.isNotEmpty) {
      _tasks.add(Task(name: taskToAdd));
      writeToFile();
      notifyListeners();
    }
  }

  int get taskCount {
    return _tasks.length;
  }

//  void addTask(String newTaskTitle) {
//    final task = Task(name: newTaskTitle);
//    _tasks.add(task);
//    notifyListeners();
//  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    writeToFile();
    notifyListeners();
  }
}
