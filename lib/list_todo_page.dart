import 'package:estudo/page_store.dart';
import 'package:estudo/shared/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  final PageStore _store = PageStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de coisas a fazer"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _store.titleController,
                        decoration: InputDecoration(labelText: "Titulo"),
                      ),
                      TextField(
                        controller: _store.descriptionController,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      TextButton(
                          onPressed: () {
                            _store.todos.add(TodoModel(
                              title: _store.titleController.text,
                              description: _store.descriptionController.text,
                              value: false,
                            ));
                            _store.saveList();

                            _store.titleController.clear();
                            _store.descriptionController.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Salvar"))
                    ],
                  ),
                ),
              );
            },
            child: Icon(Icons.add)),
        body: Observer(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: _store.todos.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: ListTile(
                      onLongPress: () {
                        _store.titleController.text =
                            _store.todos[index].title!;
                        _store.descriptionController.text =
                            _store.todos[index].description!;
                        setState(() {});
                        Scaffold.of(context).showBottomSheet(
                          (context) => Container(
                            height: 200,
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _store.titleController,
                                  decoration:
                                      InputDecoration(labelText: "Titulo"),
                                ),
                                TextField(
                                  controller: _store.descriptionController,
                                  decoration:
                                      InputDecoration(labelText: "Descrição"),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _store.todos[index].title =
                                          _store.titleController.text;
                                      _store.todos[index].description =
                                          _store.descriptionController.text;
                                      _store.saveList();
                                      _store.titleController.clear();
                                      _store.descriptionController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Salvar"))
                              ],
                            ),
                          ),
                        );
                      },
                      leading: Observer(builder: (_) {
                        return Checkbox(
                          onChanged: (value) {
                            _store.todos[index].value = value;
                            _store.saveList();
                          },
                          value: _store.todos[index].value,
                        );
                      }),
                      title: Text(_store.todos[index].title!),
                      subtitle: Text(_store.todos[index].description!),
                      trailing: IconButton(
                        onPressed: () {
                          _store.todos.removeAt(index);
                          _store.saveList();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
