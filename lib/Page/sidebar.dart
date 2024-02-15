import 'package:crud_firebase/extensions/gap.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}

class Sidebar extends StatelessWidget {
  final SidebarController sidebarController = Get.put(SidebarController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Warna.carddark,
        child: GetBuilder<SidebarController>(
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
                iconTextButton(1, 'Category', Icons.category),
                iconTextButton(2, 'Archived', Icons.archive),
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

  Widget buildListItem(int index, String title, IconData iconData) {
    return InkWell(
      onTap: () {
        sidebarController.selectItem(index);
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          color: sidebarController.selectedIndex.value == index
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Icon(
              iconData,
              color: sidebarController.selectedIndex.value == index
                  ? Colors.white
                  : Colors.white54,
            ),
            SizedBox(width: 10),
            Obx(
              () => Text(
                title,
                style: TextStyle(
                  color: sidebarController.selectedIndex.value == index
                      ? Colors.white
                      : Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconTextButton(int index, String title, IconData icon) {
    return sidebarController.selectedIndex.value == index
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
              sidebarController.selectItem(index);
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

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
