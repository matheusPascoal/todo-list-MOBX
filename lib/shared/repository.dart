import 'dart:convert';

import 'package:estudo/shared/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String key = "todosList";

class Repository {
  static Future<bool> saveList(List<TodoModel> todos) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs
        .setStringList(key, todos.map<String>((e) => e.jsonToString()).toList())
        .then((value) => true)
        .catchError((error) => false);
  }

  static getList() async {
    var prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(key);
    if (list != null) {
      return list
          .map<TodoModel>((e) => TodoModel.fromJson(json.decode(e)))
          .toList();
    }
    return <TodoModel>[];
  }
}
