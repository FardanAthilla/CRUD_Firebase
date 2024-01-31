import 'package:crud_firebase/todo_controller.dart';
import 'package:crud_firebase/todo_model.dart';
import 'package:flutter/material.dart';

class Component {
  static void showUpdateTodoBottomSheet(
      BuildContext context, TodoController todoController, TodoModel todo) {
    TextEditingController updatedTitleController =
        TextEditingController(text: todo.title);
    TextEditingController updatedDescriptionController =
        TextEditingController(text: todo.description);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: updatedTitleController,
                decoration: const InputDecoration(
                  labelText: 'Updated Title',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: updatedDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Updated Description',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  todoController.updatedTitle.text =
                      updatedTitleController.text;
                  todoController.description.text =
                      updatedDescriptionController.text;
                  todoController.updateTodo(todo);
                  Navigator.pop(context);
                },
                child: const Text('Update Todo'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showAddTodoBottomSheet(
      BuildContext context, TodoController todoController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: todoController.title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: todoController.description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  todoController.addTodo();
                  Navigator.pop(context);
                },
                child: const Text('Add Todo'),
              ),
            ],
          ),
        );
      },
    );
  }
}
