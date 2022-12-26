import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/controllers/page_index_controller.dart';
import 'package:hiimimi/app/routes/app_pages.dart';
import 'package:hiimimi/app/theme.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: ListView(
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  Map<String, dynamic> userData = snapshot.data!.data()!;
                  String defaultAvatar =
                      "https://ui-avatars.com/api/?name=${userData['name']}}";

                  return Padding(
                    padding: EdgeInsets.all(36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to Dashboard",
                          style: interBold.copyWith(
                              fontSize: 20, color: textColor),
                        ),
                        Text(
                          "your information is shown here.",
                          style: interLight.copyWith(
                              fontSize: 12, color: textColor),
                        ),
                        SizedBox(height: 28),
                        Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: secondaryBgColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[200],
                                  child: Image.network(
                                    userData['avatar'] != null
                                        ? userData['avatar'] != ""
                                            ? userData['avatar']
                                            : defaultAvatar
                                        : defaultAvatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${userData['name']}",
                                    style: interBold.copyWith(color: textColor),
                                  ),
                                  Text(
                                    "${userData['email']}",
                                    style: interLight.copyWith(
                                        color: textColor, fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 26),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            color: secondaryBgColor,
                          ),
                          child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.todayTask(),
                            builder: (context, snapshotToday) {
                              if (snapshotToday.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Text("data"),
                                );
                              }
                              Map<String, dynamic>? todayTask =
                                  snapshotToday.data?.data();

                              String today = DateFormat("EEEE, dd MMMM yyyy")
                                  .format(DateTime.now());

                              DateTime now = DateTime.now();

                              String test = DateFormat("dd").format(now);

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    today,
                                    style: interBold.copyWith(
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    test == "20"
                                        ? "Happy Anniversary!"
                                        : "dont forget to love me.",
                                    style: interLight.copyWith(
                                      color: textColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 34,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: primaryBlue,
                                          ),
                                          child: Text(
                                            "Today Task",
                                            style: interSemiBold.copyWith(
                                              color: secondaryBgColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TaskList(
                                          todayTask: todayTask,
                                          task: 'sedekah',
                                          title: 'Sedekah Subuh',
                                        ),
                                        TaskList(
                                          todayTask: todayTask,
                                          task: 'dzikir',
                                          title: 'Dzikir Setelah Sholat',
                                        ),
                                        TaskList(
                                          todayTask: todayTask,
                                          task: 'dhuha',
                                          title: 'Sholat Dhuha',
                                        ),
                                        TaskList(
                                          todayTask: todayTask,
                                          task: 'al-waqiah',
                                          title: 'Membaca Al-Waqiah',
                                        ),
                                        TaskList(
                                          todayTask: todayTask,
                                          task: 'al-mulk',
                                          title: 'Membaca Al-Mulk',
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () =>
                                              pageController.changePage(1),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryBlue,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                65),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                            ),
                                          ),
                                          child: Text(
                                            "Update Task",
                                            style: interBold.copyWith(
                                              fontSize: 14,
                                              color: secondaryBgColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                Routes.ALL_DETAILS,
                                                arguments: userData,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: BorderSide(
                                                width: 1,
                                                color: primaryBlue,
                                              ),
                                              elevation: 0,
                                              backgroundColor: secondaryBgColor,
                                              foregroundColor: primaryBlue,
                                              shadowColor: Colors.transparent,
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  65),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(28),
                                              ),
                                              enableFeedback: true,
                                            ),
                                            child: Text(
                                              "Task History",
                                              style: interSemiBold.copyWith(
                                                // fontSize: 16,
                                                color: primaryBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * .24,
                              color: primaryLightBlue,
                            ),
                            Text(
                              "Last 3 Days",
                              style: interSemiBold.copyWith(
                                color: primaryBlue,
                              ),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * .24,
                              color: primaryLightBlue,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamLastDataUser(),
                          builder: (context, snapshotData) {
                            if (snapshotData.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshotData.data?.docs.length == 0 ||
                                snapshotData.data?.docs == null) {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text("Belum ada Data"),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshotData.data?.docs.length,
                              itemBuilder: (context, index) {
                                //Isi Data
                                Map<String, dynamic> userData = snapshotData
                                    .data!.docs.reversed
                                    .toList()[index]
                                    .data();

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 22),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(55),
                                      color: secondaryBgColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 30,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Daily Task",
                                          style: interBold.copyWith(
                                              color: textColor),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${DateFormat("EEEE, d MMMM yyyy").format(DateTime.parse(userData['date']))}",
                                          style: interRegular.copyWith(
                                              color: textColor),
                                        ),
                                        SizedBox(height: 12),
                                        Divider(
                                          color: primaryBgColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${userData['taskComplete'].toString()}",
                                                    style: interBold.copyWith(
                                                      color: userData[
                                                                  'taskComplete'] <=
                                                              2
                                                          ? secondaryRed
                                                          : primaryBlue,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: " of",
                                                    style:
                                                        interRegular.copyWith(
                                                            color: textColor),
                                                  ),
                                                  TextSpan(
                                                    text: " 5 ",
                                                    style: interBold.copyWith(
                                                        color: primaryBlue),
                                                  ),
                                                  TextSpan(
                                                    text: "Task Complete",
                                                    style: interMedium.copyWith(
                                                        color: textColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              userData['taskComplete'] <= 2
                                                  ? FontAwesomeIcons
                                                      .solidCircleXmark
                                                  : FontAwesomeIcons
                                                      .solidCircleCheck,
                                              color:
                                                  userData['taskComplete'] <= 2
                                                      ? secondaryRed
                                                      : primaryBlue,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(
                                              Routes.DETAILS,
                                              arguments: userData,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: textColor,
                                            foregroundColor: textColor,
                                            fixedSize: Size(160, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                            ),
                                            enableFeedback: true,
                                          ),
                                          child: Text(
                                            "More Details",
                                            style: interSemiBold.copyWith(
                                              // fontSize: 16,
                                              color: secondaryBgColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Tidak dapat memuat data"),
                  );
                }
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.toNamed(Routes.REGISTER_USER),
      //   child: Icon(FontAwesomeIcons.usersRectangle),
      // ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: secondaryBgColor,
        height: 60,
        elevation: 0,
        items: [
          TabItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 28,
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
              size: 22,
              color:
                  pageController.pageIndex.value == 2 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 20,
              color:
                  pageController.pageIndex.value == 2 ? primaryBlue : textColor,
            ),
          ),
        ],
        initialActiveIndex: 0,
        onTap: (index) => pageController.changePage(index),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.todayTask,
    required this.title,
    required this.task,
  }) : super(key: key);

  final Map<String, dynamic>? todayTask;
  final String title;
  final String task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 14,
      ),
      child: Row(
        children: [
          Icon(
            todayTask?[task] != null
                ? todayTask![task]
                    ? FontAwesomeIcons.solidCircleCheck
                    : FontAwesomeIcons.solidCircleXmark
                : FontAwesomeIcons.solidCircleXmark,
            size: 20,
            color: todayTask?[task] != null
                ? todayTask![task]
                    ? primaryBlue
                    : secondaryRed
                : secondaryRed,
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: interMedium.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
