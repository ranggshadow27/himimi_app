import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;

  TextEditingController oldPasswordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (oldPasswordC.text.isNotEmpty &&
        newPasswordC.text.isNotEmpty &&
        confirmPasswordC.text.isNotEmpty) {
      if (newPasswordC.text == confirmPasswordC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
            email: emailUser,
            password: oldPasswordC.text,
          );

          await auth.currentUser!.updatePassword(confirmPasswordC.text);
          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: emailUser,
            password: confirmPasswordC.text,
          );

          Get.back();
          Get.snackbar("Berhasil", "Sukses Update Password");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Error", "Password lama salah!");
          } else {
            Get.snackbar("Error",
                "Gagal Update Password, errornya: ${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar("Error", "Gagal Update Password, errornya: ${e}");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "Password baru gacocok");
      }
    } else {
      Get.snackbar("Error", "Tolong diisi dulu dongg");
    }
  }
}
