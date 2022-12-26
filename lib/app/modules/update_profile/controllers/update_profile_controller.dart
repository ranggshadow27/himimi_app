import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

//Update Profile
  Future<void> updateProfile(String uid) async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> dataUpdate = {
          'name': nameC.text,
        };
        //Upload Image ke Firebase
        if (image != null) {
          File file = File(image!.path);
          String fileExt = image!.name.split(".").last;

          await storage.ref('$uid/avatar.$fileExt').putFile(file);
          String urlImage =
              await storage.ref('$uid/avatar.$fileExt').getDownloadURL();

          //Upload ke Firestore
          dataUpdate.addAll(
            {'avatar': urlImage},
          );
        }

        await firestore.collection("users").doc(uid).update(dataUpdate);
        image = null;

        Get.back();
        Get.snackbar("Berhasil", "Profile berhasil terapdet");
      } catch (e) {
        Get.snackbar("ERROR", "Maap gagal update profile, erornya: ${e}");
      } finally {
        isLoading.value = false;
      }
    }
  }

  //Image Pick
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  //Delete Image
  void deleteAvatar(String uid) async {
    try {
      isLoading.value = true;

      await firestore.collection("users").doc(uid).update(
        {
          "avatar": FieldValue.delete(),
        },
      );

      Get.back();
      Get.snackbar("Berhasil", "Avatar berhasil terapdet");
    } catch (e) {
      Get.snackbar("ERROR", "Maap gagal hapus foto profile, erornya: ${e}");
    } finally {
      isLoading.value = false;
    }
  }
}
