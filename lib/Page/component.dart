import 'dart:io';

import 'package:crud_firebase/color.dart';
import 'package:crud_firebase/Controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Component {
  static void showAddTodoBottomSheet(
      BuildContext context, TodoController todoController) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final ImagePicker _picker = ImagePicker();
    Rx<File?> _image = Rx<File?>(null);

    void getImage() async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image.value = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }

    void removeImage() {
      _image.value = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Warna.background,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  maxLines: 1,
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
                Obx(() {
                  return _image.value != null
                      ? Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Image.file(
                              _image.value!,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.7,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              color: Warna.carddark,
                              icon: Icon(Icons.cancel),
                              onPressed: removeImage,
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: getImage,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.7,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Warna.carddark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_photo_alternate,
                                color: Warna.white,
                                size:
                                    32, 
                              ),
                            ),
                          ),
                        );
                }),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Container(
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          todoController.addTodo();
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Warna.card),
                      child: Text(
                        'Add',
                        style: TextStyle(color: Warna.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
