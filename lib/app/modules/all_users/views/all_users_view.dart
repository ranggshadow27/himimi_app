import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/controllers/page_index_controller.dart';
import 'package:hiimimi/app/theme.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_users_controller.dart';

class AllUsersView extends GetView<AllUsersController> {
  final pageController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      appBar: AppBar(
        backgroundColor: primaryBgColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 85,
        title: Text(
          "Select User",
          style: interBold.copyWith(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamAllUsers(),
        builder: (context, snapshotAllData) {
          if (snapshotAllData.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshotAllData.data?.docs.length == 0 ||
              snapshotAllData.data?.docs == null) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Text("Belum ada User"),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(35),
            itemCount: snapshotAllData.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> allUser =
                  snapshotAllData.data!.docs[index].data();

              return Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Tile(allUser: allUser),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: secondaryBgColor,
        height: 60,
        elevation: 0,
        items: [
          TabItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 20,
              color:
                  pageController.pageIndex.value == 0 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.notesMedical,
              size: 22,
              color:
                  pageController.pageIndex.value == 1 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidAddressBook,
              size: 28,
              color:
                  pageController.pageIndex.value == 2 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 20,
              color:
                  pageController.pageIndex.value == 3 ? primaryBlue : textColor,
            ),
          ),
        ],
        initialActiveIndex: pageController.pageIndex.value,
        onTap: (index) => pageController.changePage(index),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.allUser,
  }) : super(key: key);

  final Map<String, dynamic> allUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: secondaryBgColor,
      elevation: 3,
      shadowColor: Color.fromARGB(45, 36, 36, 36),
      borderRadius: BorderRadius.circular(90),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.ALL_DETAILS, arguments: allUser),
        borderRadius: BorderRadius.circular(90),
        child: Container(
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: primaryBlue,
                ),
                child: ClipOval(
                  child: allUser['avatar'] != null && allUser['avatar'] != ""
                      ? Image.network(
                          allUser['avatar'],
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://ui-avatars.com/api/?background=5C7EEC&bold=true&color=FEFFFF&name=${allUser['name']}}",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    allUser["name"],
                    style: interSemiBold.copyWith(
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    allUser["email"],
                    style: interLight.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
