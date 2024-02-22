import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/Page/Navigation/Navigation.dart';
import 'package:crud_firebase/color.dart';
import 'package:crud_firebase/Controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/Model/todo_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatelessWidget {
  final TodoModel todo;

  DetailPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.find<TodoController>();
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: todo.description);

    bool isEdited = false;
    return WillPopScope(
      onWillPop: () async {
        if (isEdited) {
          bool confirm = await Get.defaultDialog(
            title: "Confirm",
            middleText:
                "Do you want to leave this page without saving your changes?",
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
          return confirm;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail",
            style: TextStyle(
              color: Warna.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Warna.background,
          foregroundColor: Warna.white,
        ),
        body: Container(
          color: Warna.background,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        title: TextFormField(
                          maxLines: null,
                          controller: titleController,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Warna.white,
                              fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            isEdited = true;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Color(0xff888888)),
                          ),
                        ),
                        subtitle: Container(
                          width: 400,
                          child: TextFormField(
                            maxLines: null,
                            controller: descriptionController,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Warna.white,
                            ),
                            onChanged: (value) {
                              isEdited = true;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Color(0xff888888)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !todoController.isLoading.value,
          child: Container(
            color: Warna.carddark,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              child: Row(
                children: <Widget>[
                  IconButton(
                    tooltip: todo.isArchive != null && todo.isArchive!
                        ? 'Unarchive'
                        : 'Archive',
                    color: Warna.white,
                    icon: Icon(
                      todo.isArchive != null && todo.isArchive!
                          ? Icons.unarchive_outlined
                          : Icons.archive_outlined,
                    ),
                    onPressed: () async {
                      String message = '';
                      if (todo.isArchive != null && todo.isArchive!) {
                        await todoController.unarchiveTodo(todo.id!);
                        await todoController.getTodo();
                        message = 'Note has been unarchived';
                      } else {
                        await todoController.archiveTodo(todo.id!);
                        await todoController.getTodo();
                        message = 'Note has been archived';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Get.back();
                    },
                  ),
                  IconButton(
                    tooltip: 'Image',
                    color: Warna.white,
                    icon: const Icon(Icons.image_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Favorite',
                    color: Warna.white,
                    icon: const Icon(Icons.people_alt_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Copy',
                    color: Warna.white,
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text:
                              '${titleController.text}\n${descriptionController.text}',
                        ),
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }).catchError((error) {
                        print('Error copying to clipboard: $error');
                      });
                    },
                  ),
                  IconButton(
                    tooltip: 'Save',
                    color: Warna.white,
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      todoController.updateTodo(
                        todo.id!,
                        titleController.text,
                        descriptionController.text,
                        Timestamp.now(),
                      );
                      todoController.update();
                      isEdited = false;
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Delete',
                    color: Warna.danger,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm",
                        middleText:
                            "Are you sure you want to delete this notes?",
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              todoController.deleteTodo(todo.id!);
                              Get.off(Navigation());
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
