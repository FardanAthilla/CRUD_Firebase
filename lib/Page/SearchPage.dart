import 'package:crud_firebase/Page/DetailPage.dart';
import 'package:crud_firebase/color.dart';
import 'package:crud_firebase/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final TodoController controller;

  const SearchPage({Key? key, required this.controller}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.card,
        foregroundColor: Warna.white,
        title: TextField(
          controller: searchController,
          style: TextStyle(color: Warna.white),
          decoration: InputDecoration(
            hintText: 'Search Your Notes',
            hintStyle: TextStyle(color: Warna.semiwhite),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (searchController.text.isNotEmpty) {
                widget.controller.searchTodo(searchController.text);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: Warna.background,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (widget.controller.todoList.isEmpty) {
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
                    children: widget.controller.todoList
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
                                      fontWeight: FontWeight.bold,
                                    ),
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
