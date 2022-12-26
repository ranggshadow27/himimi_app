import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/theme.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      appBar: AppBar(
        backgroundColor: primaryBgColor,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 100,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            FontAwesomeIcons.arrowLeftLong,
            color: primaryBlue,
            size: 32,
          ),
          // splashColor: Colors.transparent,
          splashRadius: 20,
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 34, vertical: 28),
              decoration: BoxDecoration(
                color: secondaryBgColor,
                borderRadius: BorderRadius.circular(55),
              ),
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Text(
                    "Update Password.",
                    style: interBold.copyWith(
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: primaryBgColor,
                    thickness: 2,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Change your account password.",
                    style: interLight.copyWith(
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      passwordField(
                        controller: controller,
                        text: "Old Password",
                        textEditingController: controller.oldPasswordC,
                      ),
                      SizedBox(height: 22),
                      Text(
                        "New Password",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      passwordField(
                        controller: controller,
                        text: "New Password",
                        textEditingController: controller.newPasswordC,
                      ),
                      SizedBox(height: 22),
                      Text(
                        "Confirm Password",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      passwordField(
                        controller: controller,
                        text: "Confirm Password",
                        textEditingController: controller.confirmPasswordC,
                      ),
                      SizedBox(height: 60),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            controller.updatePassword();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: primaryBgColor,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 65),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            enableFeedback: true,
                          ),
                          child: Text(
                            controller.isLoading.value == false
                                ? "CONFIRM"
                                : "LOADING ..",
                            style: interBold.copyWith(
                              fontSize: 16,
                              color: secondaryBgColor,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class passwordField extends StatelessWidget {
  const passwordField({
    Key? key,
    required this.controller,
    required this.text,
    required this.textEditingController,
  }) : super(key: key);

  final UpdatePasswordController controller;

  final String text;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: textEditingController,
        autocorrect: false,
        obscureText: controller.isPassword.value,
        // obscuringCharacter: "x",
        style: interSemiBold.copyWith(color: textColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          labelText: text,
          suffixIcon: IconButton(
            onPressed: () {
              controller.isPassword.toggle();
            },
            icon: Icon(
              controller.isPassword.value
                  ? FontAwesomeIcons.solidEyeSlash
                  : FontAwesomeIcons.solidEye,
              color: primaryBlue,
              size: 16,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryBlue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: primaryLightBlue,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
