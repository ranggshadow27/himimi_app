import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterUserController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

//Tambah User ke Firebase Auth
  Future<void> registerUser() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "Password@123",
        );

        //Tambah data user ke Cloud Firestore sesuai dari data FirebaseAuth user
        if (userCredential.user != null) {
          String userUid = userCredential.user!.uid;

          await firestore.collection('users').doc(userUid).set(
            {
              'uid': userUid,
              'name': nameC.text,
              'email': emailC.text,
              'createdAt': DateTime.now().toIso8601String(),
            },
          );
          isLoading.value = false;
          Get.back();
          Get.snackbar("Sukses", "Berhasil mendaftarkan user.");
        }

        print(userCredential);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Eror", "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Eror", "The account already exists for that email.");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("General Eror", "Gatau erornya itu ${e}");
      }
    } else {
      Get.snackbar("Eror", "Isi dulu kolomnya");
    }
  }
}
