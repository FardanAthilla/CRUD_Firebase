import 'package:crud_firebase/Page/DetailPage.dart';
import 'package:crud_firebase/Page/SearchPage.dart';
import 'package:crud_firebase/Page/sidebar.dart';
import 'package:crud_firebase/Page/component.dart';
import 'package:crud_firebase/color.dart';
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
        title: Text(
          "Notes",
          style: TextStyle(
            color: Warna.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.white,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Warna.white),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Warna.white),
            onPressed: () {
              Get.to(SearchPage(controller: TodoController()));
            },
          ),
        ],
      ),
      drawer: Sidebar(),
      body: Container(
        color: Warna.background,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () {
                  if (todoController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (todoController.todoList.isEmpty) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          'Assets/nodata.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      children: todoController.todoList
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Warna.card,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => DetailPage(todo: e));
                                  },
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      e.title!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color: Warna.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Text(
                                    e.description!,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Warna.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Warna.carddark,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Checkbox',
                color: Warna.white,
                icon: const Icon(Icons.check_box_outlined),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Image',
                color: Warna.white,
                icon: const Icon(Icons.image_outlined),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Share',
                color: Warna.white,
                icon: const Icon(Icons.people_alt_outlined),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Add Data',
                color: Warna.main,
                icon: const Icon(Icons.add),
                onPressed: () {
                  Component.showAddTodoBottomSheet(context, todoController);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
