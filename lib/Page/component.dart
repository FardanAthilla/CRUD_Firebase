import 'package:crud_firebase/color.dart';
import 'package:crud_firebase/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Component {
  static void showAddTodoBottomSheet(
      BuildContext context, TodoController todoController) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Warna.carddark,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  maxLines: null,
                  controller: todoController.title,
                  style: TextStyle(
                      fontSize: 24,
                      color: Warna.white,
                      fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Color(0xff888888))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: 400,
                      child: TextFormField(
                        controller: todoController.description,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 14,
                          color: Warna.semiwhite,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Color(0xff888888)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      todoController.addTodo();
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Warna.card
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Warna.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
