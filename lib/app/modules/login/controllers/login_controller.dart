import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiimimi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final UserCredential userCredential =
            await auth.signInWithEmailAndPassword(
                email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          if (passC.text == "Password@123") {
            isLoading.value = false;
            Get.offAllNamed(Routes.NEW_PASSWORD);
          } else {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME);
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "Akun tidak terdaftar.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", 'Passwordnya salah.');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", 'ini error General\n ${e}');
      }
    } else {
      Get.snackbar("Error", "Mohon diisi terlebih dahulu.");
    }
  }
}
