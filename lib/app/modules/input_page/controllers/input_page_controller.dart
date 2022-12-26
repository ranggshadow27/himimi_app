import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hiimimi/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../controllers/page_index_controller.dart';

class InputPageController extends GetxController {
  RxBool isSedekahSelected = false.obs;
  RxBool isDzikirSelected = false.obs;
  RxBool isDhuhaSelected = false.obs;
  RxBool isWaqiahSelected = false.obs;
  RxBool isMulkSelected = false.obs;

  final pageController = Get.find<PageIndexController>();

  RxBool isLoading = false.obs;
  RxInt pageIndex = 0.obs;

  TextEditingController dateC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? pickDate;
  int? totalDay;

  int completeTask = 0;

  void onTapSedekah() async {
    if (isSedekahSelected.isFalse) {
      isSedekahSelected.value = true;
      completeTask += 1;
    } else {
      isSedekahSelected.value = false;
      completeTask -= 1;
    }

    // print(isSedekahSelected);
  }

  void submitTask(String inputTask) async {
    if (inputTask == "isMulkSelected") {
      if (isMulkSelected.isFalse) {
        isMulkSelected.value = true;
        completeTask += 1;
        print("Al-Mulk => ${isMulkSelected.value}");
        print(completeTask);
      } else {
        isMulkSelected.value = false;
        completeTask -= 1;
        print("Al-Mulk => ${isMulkSelected.value}");
        print(completeTask);
      }
    }
    if (inputTask == "isWaqiahSelected") {
      if (isWaqiahSelected.isFalse) {
        isWaqiahSelected.value = true;
        completeTask += 1;
        print("isWaqiahSelected => ${isWaqiahSelected.value}");
        print(completeTask);
      } else {
        isWaqiahSelected.value = false;
        completeTask -= 1;
        print("isWaqiahSelected => ${isWaqiahSelected.value}");
        print(completeTask);
      }
    }
    if (inputTask == "isSedekahSelected") {
      if (isSedekahSelected.isFalse) {
        isSedekahSelected.value = true;
        completeTask += 1;
        print("isSedekahSelected => ${isSedekahSelected.value}");
        print(completeTask);
      } else {
        isSedekahSelected.value = false;
        completeTask -= 1;
        print("isSedekahSelected => ${isSedekahSelected.value}");
        print(completeTask);
      }
    }
    if (inputTask == "isDhuhaSelected") {
      if (isDhuhaSelected.isFalse) {
        isDhuhaSelected.value = true;
        completeTask += 1;
        print("isDhuhaSelected => ${isDhuhaSelected.value}");
        print(completeTask);
      } else {
        isDhuhaSelected.value = false;
        completeTask -= 1;
        print("isDhuhaSelected => ${isDhuhaSelected.value}");
        print(completeTask);
      }
    }
    if (inputTask == "isDzikirSelected") {
      if (isDzikirSelected.isFalse) {
        isDzikirSelected.value = true;
        completeTask += 1;
        print("isDzikirSelected => ${isDzikirSelected.value}");
        print(completeTask);
      } else {
        isDzikirSelected.value = false;
        completeTask -= 1;
        print("isDzikirSelected => ${isDzikirSelected.value}");
        print(completeTask);
      }
    }
  }

  Future<void> submitData() async {
    print(pickDate);
    // totalDay = totalData;

    try {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      DateTime now = DateTime.now();
      DateTime firstDay = DateTime.parse("2022-12-01 00:00:00");
      // DateTime currentDay = new DateTime(now.day, now.month, now.year);

      if (pickDate != null) {
        String dateId = DateFormat("yyyy-MM-dd").format(pickDate!);
        Duration diff = pickDate!.difference(firstDay);
        Duration currDiff =
            pickDate!.difference(DateTime(now.year, now.month, now.day));
        int isToday = currDiff.inDays;
        int totalDay = diff.inDays;

        String dateStatus = DateFormat("EEEE, dd MMMM yyyy").format(pickDate!);

        if (isToday <= 0) {
          await firestore
              .collection("users")
              .doc(uid)
              .collection("data")
              .doc(dateId)
              .set(
            {
              "date": dateId,
              "createdAt": now.toIso8601String(),
              "al-waqiah": isWaqiahSelected.value,
              "al-mulk": isMulkSelected.value,
              "dzikir": isDzikirSelected.value,
              "dhuha": isDhuhaSelected.value,
              "sedekah": isSedekahSelected.value,
              "dayof": totalDay,
              "taskComplete": completeTask,
            },
          );

          // print("hari ke -> ${pickDate}");
          // print("hari ke -> ${totalDay.toString()}");
          // print("${completeTask.toString()} of 5 Complete");
          print("Ini Hari ke -> ${isToday.toString()}");
          pageController.changePage(0);
          Get.snackbar("Berhasil", "Data berhasil di update.");
        } else {
          Get.snackbar("Error",
              "Maaf cuma bisa input data hari ini dan sebelumnya aja ya bebiii");
        }
      } else {
        pickDate = now;
        Duration diff = pickDate!.difference(firstDay);
        int totalDay = diff.inDays;

        String dateId = DateFormat("yyyy-MM-dd").format(pickDate!);
        String dateStatus = DateFormat("EEEE, dd MMMM yyyy").format(pickDate!);

        await firestore
            .collection("users")
            .doc(uid)
            .collection("data")
            .doc(dateId)
            .set(
          {
            "date": dateId,
            "createdAt": now.toIso8601String(),
            "al-waqiah": isWaqiahSelected.value,
            "al-mulk": isMulkSelected.value,
            "dzikir": isDzikirSelected.value,
            "dhuha": isDhuhaSelected.value,
            "sedekah": isSedekahSelected.value,
            "dayof": totalDay,
            "taskComplete": completeTask,
          },
        );

        // print("hari ke -> ${totalDay.toString()}");
        // print("${completeTask.toString()} of 5 Complete");
        pageController.changePage(0);
        Get.snackbar("Berhasil", "Data berhasil di update.");
      }

      // print(dateId);
      // print(dateStatus);
    } catch (e) {
      Get.snackbar("Error", "Ngga Berhasil! , eror:${e}");
    } finally {
      isLoading.value = false;
    }
  }

  void datePick(DateTime startPick) {
    pickDate = startPick;

    // update();
    // Get.back();
  }
}
