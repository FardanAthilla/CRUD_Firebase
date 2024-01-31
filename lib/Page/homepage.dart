import 'package:crud_firebase/Page/sidebar.dart';
import 'package:crud_firebase/Page/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud_firebase/todo_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Notes", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1B1B1B),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Sidebar(),
      body: Container(
        color: Color(0xFF1B1B1B),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView(
                  children: todoController.todoList
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: Card(
                            elevation: 3,
                            color: Color(0xFF222222),
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                e.title!,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Color(0xFFD5EFF2),
                                ),
                              ),
                              subtitle: Text(e.description!,
                                  style: TextStyle(color: Color(0xFFA8BCBF))),
                              trailing: SizedBox(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        todoController.deleteTodo(e.id!);
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        Component.showAddTodoBottomSheet(
                                            context, todoController);
                                      },
                                      child: const Icon(Icons.edit),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Component.showAddTodoBottomSheet(context, todoController);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
