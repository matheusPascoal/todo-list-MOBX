import 'package:estudo/shared/repository.dart';
import 'package:estudo/shared/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'page_store.g.dart';

class PageStore = _PageStoreBase with _$PageStore;

abstract class _PageStoreBase with Store {
  _PageStoreBase() {
    autorun((_) async {
      await getList();
    });
  }
  @observable
  ObservableList<TodoModel> todos = <TodoModel>[].asObservable();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @action
  getList() async {
    todos.clear();
    var result = await Repository.getList();
    todos.addAll(result);
  }

  saveList() async {
    var result = await Repository.saveList(todos);
  }
}
