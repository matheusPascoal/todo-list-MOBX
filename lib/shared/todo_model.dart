import 'dart:convert';

import 'package:mobx/mobx.dart';
part 'todo_model.g.dart';

class TodoModel = _TodoModelBase with _$TodoModel;

abstract class _TodoModelBase with Store {
  @observable
  bool? value = false;
  String? title;
  String? description;
  _TodoModelBase({this.value, this.title, this.description});

  _TodoModelBase.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = {};
    data['value'] = value;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

  String jsonToString() {
    var decode = json.encode(tojson());
    return decode;
  }
}
