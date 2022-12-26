import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/theme.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
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
                    "Forgot Password.",
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
                    "Enter email for reset your password",
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
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          controller.forgotPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: primaryBgColor,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enableFeedback: true,
                        ),
                        child: Text(
                          "CONFIRM",
                          style: interBold.copyWith(
                            fontSize: 16,
                            color: secondaryBgColor,
                          ),
                        ),
                      )
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
