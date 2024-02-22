import 'package:crud_firebase/Page/DetailPage.dart';
import 'package:crud_firebase/color.dart';
import 'package:crud_firebase/Controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchivedPage extends StatelessWidget {
  const ArchivedPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());
    return Container(
      color: Warna.background,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (todoController.isLoading.value) {
                  return const Center(
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
                        .where((e) => e.isArchive != false)
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
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.title!,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Warna.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Archived',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
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
    );
  }
}
