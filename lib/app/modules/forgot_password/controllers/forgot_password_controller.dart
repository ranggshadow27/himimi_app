import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

//Send Forgot Password by Email
  void forgotPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.back();
        Get.snackbar("Sukses", "Silahkan cek emailmu.");
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat ngirim Email, ${e}");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
