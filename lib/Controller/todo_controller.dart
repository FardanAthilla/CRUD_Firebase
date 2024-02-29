import 'package:crud_firebase/Model/todo_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController updatedTitle = TextEditingController();
  TextEditingController description = TextEditingController();

  RxBool isLoading = true.obs;

  final uId = const Uuid();
  final db = FirebaseFirestore.instance;

  RxList<TodoModel> todoList = RxList<TodoModel>();

  @override
  void onInit() {
    super.onInit();
    getTodo();
  }

  Future<void> addTodo() async {
    String id = uId.v4();
    var newTodo = TodoModel(
      id: id,
      title: title.text,
      description: description.text,
      isArchive: false,
      createdAt: Timestamp.now(),
    );
    await db.collection("todo").doc(id).set(newTodo.toJson());
    title.clear();
    description.clear();
    getTodo();
    print("Todo added to Database");
  }

  Future<void> getTodo() async {
    todoList.clear();
    await db
        .collection("todo")
        .orderBy("createdAt", descending: true)
        .get()
        .then((allTodo) {
      for (var todo in allTodo.docs) {
        todoList.add(
          TodoModel.fromJson(
            todo.data(),
          ),
        );
      }
    });
    isLoading.value = false;
    print("Get Todo");
  }

  Future<void> archiveTodo(String id) async {
    try {
      var todo = todoList.firstWhere((todo) => todo.id == id);
      todo.isArchive = true;
      await db.collection("todo").doc(id).update({'isArchive': true});
      print("Todo Archived");
    } catch (e) {
      print("Error archiving todo: $e");
    }
  }

  Future<void> unarchiveTodo(String id) async {
    try {
      var todo = todoList.firstWhere((todo) => todo.id == id);
      todo.isArchive = false;
      await db.collection("todo").doc(id).update({'isArchive': false});
      print("Todo Unarchived");
    } catch (e) {
      print("Error unarchiving todo: $e");
    }
  }

  Future<void> deleteTodo(String id) async {
    await db.collection("todo").doc(id).delete();
    print("Todo Deleted");
    getTodo();
  }

  Future<void> updateTodo(String id, String updatedTitle,
      String updatedDescription, Timestamp createdAt) async {
    try {
      var updatedTodo = TodoModel(
        id: id,
        title: updatedTitle,
        description: updatedDescription,
        createdAt: createdAt,
      );

      var existingTodoSnapshot = await db.collection("todo").doc(id).get();
      var existingTodoData = existingTodoSnapshot.data();
      if (existingTodoData != null &&
          existingTodoData.containsKey('isArchive')) {
        var existingIsArchive = existingTodoData['isArchive'];

        if (existingIsArchive != null) {
          updatedTodo.isArchive = existingIsArchive;
        }
      }

      await db.collection("todo").doc(id).update(updatedTodo.toJson());
      getTodo();
      isLoading.value = false;
      Get.back();
      print("Todo Updated");
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> searchTodo(String query) async {
    todoList.clear();

    query = query.toLowerCase();
    await db.collection("todo").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String title = doc.data()['title'].toString().toLowerCase();
        if (title.contains(query)) {
          todoList.add(
            TodoModel.fromJson(
              doc.data(),
            ),
          );
        }
      });
    });
    print("Search Todo");
  }
}
