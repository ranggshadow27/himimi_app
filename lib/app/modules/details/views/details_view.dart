import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hiimimi/app/routes/app_pages.dart';
import 'package:hiimimi/app/theme.dart';
import 'package:intl/intl.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  final Map<String, dynamic> userData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      appBar: AppBar(
        backgroundColor: primaryBgColor,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 100,
        toolbarHeight: 60,
        title: Text(
          "Task Detail",
          style: interBold.copyWith(
            color: textColor,
            fontSize: 20,
          ),
        ),
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
      //
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  color: secondaryBgColor,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Daily Task | Day ${userData['dayof'].toString()}",
                      style: interBold.copyWith(color: textColor),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${DateFormat("EEEE, d MMMM yyyy").format(DateTime.parse(userData['date']))}",
                      style: interRegular.copyWith(color: textColor),
                    ),
                    SizedBox(height: 12),
                    Divider(
                      color: primaryBgColor,
                      thickness: 2,
                    ),
                    SizedBox(height: 34),
                    Container(
                      width: 170,
                      // color: Colors.red,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          taskTile(
                            userData: userData,
                            text: "Sedekah Subuh",
                            links: "sedekah",
                          ),
                          SizedBox(height: 12),
                          taskTile(
                            userData: userData,
                            text: "Dzikir Setelah Sholat",
                            links: "dzikir",
                          ),
                          SizedBox(height: 12),
                          taskTile(
                            userData: userData,
                            text: "Sholat Dhuha",
                            links: "dhuha",
                          ),
                          SizedBox(height: 12),
                          taskTile(
                            userData: userData,
                            text: "Membaca Al-Waqiah",
                            links: "al-waqiah",
                          ),
                          SizedBox(height: 12),
                          taskTile(
                            userData: userData,
                            text: "Membaca Al-Mulk",
                            links: "al-mulk",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 42),
                    Text(
                      "Date Created",
                      style: interBold.copyWith(color: textColor),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${DateFormat("EEEE, d MMMM yyyy \n HH:mm aa").format(DateTime.parse(userData['createdAt']))}",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class taskTile extends StatelessWidget {
  const taskTile(
      {Key? key,
      required this.userData,
      required this.links,
      required this.text})
      : super(key: key);

  final Map<String, dynamic> userData;
  final String text;
  final String links;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          userData[links]
              ? FontAwesomeIcons.solidCircleCheck
              : FontAwesomeIcons.solidCircleXmark,
          size: 14,
          color: userData[links] ? primaryBlue : secondaryRed,
        ),
        SizedBox(width: 14),
        Text(
          text,
          style: interMedium.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
