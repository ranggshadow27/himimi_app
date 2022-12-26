import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hiimimi/app/controllers/page_index_controller.dart';
import 'package:hiimimi/app/theme.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/input_page_controller.dart';

class InputPageView extends GetView<InputPageController> {
  final pageController = Get.find<PageIndexController>();

  // bool isSelected = false;
  final String dateNowd =
      DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    controller.dateC.text = dateNowd;
    return Scaffold(
      backgroundColor: primaryBgColor,
      appBar: AppBar(
        backgroundColor: primaryBgColor,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 100,
        toolbarHeight: 80,
        title: Text(
          "Input Task",
          style: interBold.copyWith(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
      //
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            decoration: BoxDecoration(
              color: secondaryBgColor,
              borderRadius: BorderRadius.circular(55),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text(
                  "Pick a Date :",
                  style:
                      interSemiBold.copyWith(color: primaryBlue, fontSize: 14),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: controller.dateC,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  style: interSemiBold.copyWith(
                    color: textColor,
                    fontSize: 14,
                  ),
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 400,
                          child: SfDateRangePicker(
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialDisplayDate: DateTime.now(),
                            showActionButtons: true,
                            showNavigationArrow: true,
                            onCancel: () => Get.back(),
                            onSubmit: (p0) {
                              print(p0);
                              DateTime dateNow =
                                  DateFormat("yyyy-MM-dd").parse(p0.toString());

                              String dateNowFormat =
                                  DateFormat("EEEE, dd MMMM yyyy")
                                      .format(dateNow);

                              controller.dateC.text = dateNowFormat;
                              controller.datePick(dateNow);
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    fillColor: secondaryBgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: primaryBlue,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: primaryBgColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28),
                Text(
                  "Select Tasks :",
                  style:
                      interSemiBold.copyWith(color: primaryBlue, fontSize: 14),
                ),
                SizedBox(height: 8),
                TaskTile(
                  controller: controller,
                  c: controller,
                  inputTask: "isSedekahSelected",
                  title: "Sedekah Subuh",
                  input: controller.isSedekahSelected,
                ),
                TaskTile(
                  controller: controller,
                  c: controller,
                  inputTask: "isDzikirSelected",
                  title: "Dzikir Setelah Sholat",
                  input: controller.isDzikirSelected,
                ),
                TaskTile(
                  controller: controller,
                  c: controller,
                  inputTask: "isDhuhaSelected",
                  title: "Sholat Dhuha",
                  input: controller.isDhuhaSelected,
                ),
                TaskTile(
                  controller: controller,
                  c: controller,
                  inputTask: "isWaqiahSelected",
                  title: "Membaca Al-Waqiah",
                  input: controller.isWaqiahSelected,
                ),
                TaskTile(
                  controller: controller,
                  c: controller,
                  inputTask: "isMulkSelected",
                  title: "Membaca Al-Mulk",
                  input: controller.isMulkSelected,
                ),
                SizedBox(height: 28),
                Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.submitData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      fixedSize: Size(MediaQuery.of(context).size.width, 65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      controller.isLoading.isFalse
                          ? "Submit Task"
                          : "Please Wait",
                      style: interBold.copyWith(
                        fontSize: 14,
                        color: secondaryBgColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: Obx(
        () => ConvexAppBar(
          style: TabStyle.reactCircle,
          backgroundColor: secondaryBgColor,
          height: 60,
          elevation: 0,
          items: [
            TabItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 20,
                color: pageController.pageIndex.value == 0
                    ? primaryBlue
                    : textColor,
              ),
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.notesMedical,
                size: 28,
                color: pageController.pageIndex.value == 1
                    ? primaryBlue
                    : textColor,
              ),
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.solidAddressBook,
                size: 22,
                color: pageController.pageIndex.value == 2
                    ? primaryBlue
                    : textColor,
              ),
            ),
            TabItem(
              icon: Icon(
                FontAwesomeIcons.solidUser,
                size: 20,
                color: pageController.pageIndex.value == 3
                    ? primaryBlue
                    : textColor,
              ),
            ),
          ],
          initialActiveIndex: pageController.pageIndex.value,
          onTap: (index) => pageController.changePage(index),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.controller,
    required this.c,
    required this.inputTask,
    required this.input,
    required this.title,
  }) : super(key: key);

  final InputPageController controller;
  final InputPageController c;
  final String inputTask;
  final String title;
  final RxBool input;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Material(
          color: input.isTrue ? primaryBgColor : secondaryBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 2,
              color: input.isTrue ? primaryLightBlue : primaryBgColor,
            ),
          ),
          child: InkWell(
            splashColor: primaryBgColor,
            highlightColor: primaryBgColor,
            // radius: 40,
            onTap: () {
              controller.submitTask(inputTask);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    child: Icon(
                      input.isTrue
                          ? FontAwesomeIcons.solidCircleCheck
                          : FontAwesomeIcons.solidCircleXmark,
                      size: 18,
                      color: input.isTrue ? primaryBlue : secondaryRed,
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      title,
                      style: interMedium.copyWith(
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
