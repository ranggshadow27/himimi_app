import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hiimimi/app/theme.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> userData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = userData['email'];
    controller.nameC.text = userData['name'];
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
                    "Update Profile.",
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
                    "Change your profile here",
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
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          enabled: false,
                          fillColor: primaryBgColor,
                          filled: true,
                          labelText: "example@email.com",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          disabledBorder: OutlineInputBorder(
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
                        "Name",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: controller.nameC,
                        autocorrect: false,
                        // obscuringCharacter: "x",
                        style: interSemiBold.copyWith(color: textColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          labelText: "name",
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
                        "Avatar",
                        style: interMedium.copyWith(
                          fontSize: 14,
                          color: primaryDarkBlue,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryBgColor,
                              elevation: 0,
                              fixedSize: Size(128, 46),
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              side: BorderSide(
                                color: primaryLightBlue,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Pick an Image",
                              style: interMedium.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                          GetBuilder<UpdateProfileController>(
                            builder: (controller) {
                              if (controller.image != null) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: Image.file(
                                      File(controller.image!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else {
                                if (userData["avatar"] != null) {
                                  return Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          child: Image.network(
                                            userData["avatar"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            if (controller.isLoading.isFalse) {
                                              controller.deleteAvatar(
                                                  userData['uid']);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: secondaryBgColor,
                                            elevation: 0,
                                            fixedSize: Size(80, 24),
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            side: BorderSide(
                                              color: secondaryRed,
                                              width: 1,
                                            ),
                                          ),
                                          child: controller.isLoading.isFalse
                                              ? Text(
                                                  "Delete",
                                                  style: interSemiBold.copyWith(
                                                    color: secondaryRed,
                                                    fontSize: 14,
                                                  ),
                                                )
                                              : Container(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text("No Selected Images");
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.updateProfile(userData['uid']);
                            }
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
                                ? "UPDATE PROFILE"
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
