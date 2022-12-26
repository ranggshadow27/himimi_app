import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/controllers/page_index_controller.dart';
import 'package:hiimimi/app/routes/app_pages.dart';
import 'package:hiimimi/app/theme.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  final pageController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> userData = snapshot.data!.data()!;
              String defaultAvatar =
                  "https://ui-avatars.com/api/?name=${userData['name']}}";
              return Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Center(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(36),
                          decoration: BoxDecoration(
                            color: secondaryBgColor,
                            borderRadius: BorderRadius.circular(55),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: primaryBlue,
                                  child: Image.network(
                                    userData['avatar'] != null
                                        ? userData['avatar'] != ""
                                            ? userData['avatar']
                                            : defaultAvatar
                                        : defaultAvatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  thickness: 2,
                                  color: primaryBgColor,
                                ),
                              ),
                              SizedBox(height: 18),
                              Text(
                                userData['name'],
                                style: interBold.copyWith(
                                    color: textColor, fontSize: 16),
                              ),
                              SizedBox(height: 6),
                              Text(
                                userData['email'],
                                style: interLight.copyWith(color: textColor),
                              ),
                              SizedBox(height: 48),
                              Tile(
                                text: "Update Profile",
                                link: Routes.UPDATE_PROFILE,
                                arguments: userData,
                                icon: FontAwesomeIcons.userGear,
                              ),
                              Tile(
                                text: "Update Password",
                                link: Routes.UPDATE_PASSWORD,
                                arguments: userData,
                                icon: FontAwesomeIcons.lock,
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Get.toNamed(Routes.LOGIN);
                                  Get.snackbar("Logout", "Berhasil Logout");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryRed,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width, 65),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Text(
                                  "LOGOUT",
                                  style: interBold.copyWith(
                                    fontSize: 16,
                                    color: secondaryBgColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Tidak dapat Memuat Data User"),
              );
            }
          }),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: secondaryBgColor,
        height: 60,
        elevation: 0,
        items: [
          TabItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 20,
              color:
                  pageController.pageIndex.value == 0 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.notesMedical,
              size: 22,
              color:
                  pageController.pageIndex.value == 1 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidAddressBook,
              size: 22,
              color:
                  pageController.pageIndex.value == 2 ? primaryBlue : textColor,
            ),
          ),
          TabItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 28,
              color:
                  pageController.pageIndex.value == 3 ? primaryBlue : textColor,
            ),
          ),
        ],
        initialActiveIndex: pageController.pageIndex.value,
        onTap: (index) => pageController.changePage(index),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.text,
    required this.link,
    required this.arguments,
    required this.icon,
  }) : super(key: key);

  final String text;
  final String link;
  final Map<String, dynamic> arguments;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: primaryBgColor,
          highlightColor: primaryBgColor,
          onTap: () {
            Get.toNamed(link, arguments: arguments);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryBgColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    child: Icon(
                      icon,
                      color: primaryBlue,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      text,
                      style: interMedium.copyWith(
                        color: textColor,
                      ),
                    ),
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
