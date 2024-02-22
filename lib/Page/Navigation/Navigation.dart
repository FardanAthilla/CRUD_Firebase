import 'package:crud_firebase/Page/Navigation/Archived/ArchivedPage.dart';
import 'package:crud_firebase/Page/Navigation/HomePage/Home.dart';
import 'package:crud_firebase/Page/SearchPage.dart';
import 'package:crud_firebase/Page/component.dart';
import 'package:crud_firebase/extensions/gap.dart';
import 'package:crud_firebase/Controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/color.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(
          () => IndexedStack(
            index: navigationController.selectedIndex.value,
            children: [
              AppbarTitle("Notes"),
              AppbarTitle("Archived"),
              AppbarTitle("Notes"),
              AppbarTitle("Notes"),
              AppbarTitle("Notes"),
              AppbarTitle("Notes"),
            ],
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
      body: Obx(
        () => IndexedStack(
          index: navigationController.selectedIndex.value,
          children: const [
            HomePage(),
            ArchivedPage(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
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

  Widget Sidebar() {
    return Drawer(
      child: Material(
        color: Warna.carddark,
        child: GetBuilder<NavigationController>(
          builder: (controller) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: kToolbarHeight,
                  color: Warna.carddark,
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Warna.white,
                      ),
                      SizedBox(width: 30),
                      Text(
                        "Notes",
                        style: TextStyle(
                          color: Warna.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                iconTextButton(0, 'Notes', Icons.note),
                iconTextButton(1, 'Archive', Icons.archive),
                iconTextButton(2, 'Category', Icons.category),
                iconTextButton(3, 'Trashbin', Icons.delete),
                iconTextButton(4, 'Appreance', Icons.edit),
                iconTextButton(5, 'User', Icons.people),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget AppbarTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Warna.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget iconTextButton(int index, String title, IconData icon) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    return navigationController.selectedIndex.value == index
        ? Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Warna.card,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Row(
              children: [
                Icon(icon, color: Warna.white),
                Text(
                  title,
                  style: TextStyle(color: Warna.white),
                )
              ].withSpaceBetween(width: 10),
            ),
          )
        : TextButton(
            onPressed: () {
              navigationController.selectItem(index);
              Get.back();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000)),
              backgroundColor: Warna.carddark,
              foregroundColor: Warna.semiwhite,
            ),
            child: Row(
              children: [
                Icon(icon, color: Warna.semiwhite),
                Text(
                  title,
                  style: TextStyle(
                      color: Warna.semiwhite, fontWeight: FontWeight.normal),
                )
              ].withSpaceBetween(width: 10),
            ),
          );
  }
}
