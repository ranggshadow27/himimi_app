import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiimimi/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  RxBool isPassword = true.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "Password@123") {
        try {
          isLoading.value = true;
          String currentUserEmail = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: currentUserEmail,
            password: newPassC.text,
          );

          Get.offAllNamed(Routes.HOME);
          Get.snackbar("Berhasil", "Password baru diterapkan");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "Passwordnya terlalu lemah.");
          }
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "Jangan pake password default lagi dong.");
      }
    } else {
      Get.snackbar("Error", "Ya diisi dulu dong");
    }
  }
}
