import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hiimimi/app/routes/app_pages.dart';
import 'package:hiimimi/app/theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
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
                    "Login Here.",
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
                    "Please login before continue.",
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
                        "Email",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: controller.emailC,
                        autocorrect: false,
                        style: interSemiBold.copyWith(color: textColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          labelText: "example@email.com",
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
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      Obx(
                        () => TextField(
                          controller: controller.passC,
                          autocorrect: false,
                          obscureText: controller.isPassword.value,
                          // obscuringCharacter: "x",
                          style: interSemiBold.copyWith(color: textColor),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            labelText: "Password",
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Get.toNamed(Routes.FORGOT_PASSWORD),
                            child: Text(
                              "Forgot Password?",
                              style: interMedium.copyWith(
                                color: secondaryRed,
                                fontSize: 12,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: primaryBgColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            controller.login();
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
                                ? "LOG IN"
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
