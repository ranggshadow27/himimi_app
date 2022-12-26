import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hiimimi/app/theme.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_details_controller.dart';

class AllDetailsView extends GetView<AllDetailsController> {
  Map<String, dynamic> userInfo = Get.arguments;

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
          "Task History",
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        children: [
          SizedBox(height: 48),
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: secondaryBgColor,
            ),
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: primaryBlue,
                  ),
                  child: ClipOval(
                    child:
                        userInfo['avatar'] != null && userInfo['avatar'] != ""
                            ? Image.network(
                                userInfo['avatar'],
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://ui-avatars.com/api/?background=5C7EEC&bold=true&color=FEFFFF&name=${userInfo['name']}}",
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userInfo["name"],
                      style: interSemiBold.copyWith(
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      userInfo["email"],
                      style: interLight.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          GetBuilder<AllDetailsController>(
            builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.getAllData(),
              builder: (context, snapshotAllData) {
                if (snapshotAllData.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshotAllData.data?.docs.length == 0 ||
                    snapshotAllData.data?.docs == null) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text("Belum ada Data"),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshotAllData.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userAllData =
                        snapshotAllData.data!.docs[index].data();
                    DateTime formatCreatedAt = DateFormat("yyyy-MM-dd")
                        .parse(userAllData['createdAt']);

                    DateTime now = DateTime.now();
                    DateTime currentTime =
                        new DateTime(now.year, now.month, now.day);

                    return Padding(
                      padding: EdgeInsets.only(bottom: 22),
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
                            if (currentTime == formatCreatedAt)
                              Container(
                                height: 34,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: primaryBlue,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Center(
                                  child: Text(
                                    "New Task!",
                                    style: interSemiBold.copyWith(
                                      fontSize: 12,
                                      color: secondaryBgColor,
                                    ),
                                  ),
                                ),
                              ),
                            if (currentTime == formatCreatedAt)
                              SizedBox(height: 30),
                            Text(
                              "Daily Task",
                              style: interBold.copyWith(color: textColor),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${DateFormat("EEEE, d MMMM yyyy").format(DateTime.parse(userAllData['date']))}",
                              style: interRegular.copyWith(color: textColor),
                            ),
                            SizedBox(height: 12),
                            Divider(
                              color: primaryBgColor,
                              thickness: 2,
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${userAllData['taskComplete'].toString()}",
                                        style: interBold.copyWith(
                                          color:
                                              userAllData['taskComplete'] <= 2
                                                  ? secondaryRed
                                                  : primaryBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " of",
                                        style: interRegular.copyWith(
                                            color: textColor),
                                      ),
                                      TextSpan(
                                        text: " 5 ",
                                        style: interBold.copyWith(
                                            color: primaryBlue),
                                      ),
                                      TextSpan(
                                        text: "Task Complete",
                                        style: interMedium.copyWith(
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  userAllData['taskComplete'] <= 2
                                      ? FontAwesomeIcons.solidCircleXmark
                                      : FontAwesomeIcons.solidCircleCheck,
                                  color: userAllData['taskComplete'] <= 2
                                      ? secondaryRed
                                      : primaryBlue,
                                  size: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                  Routes.DETAILS,
                                  arguments: userAllData,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: textColor,
                                foregroundColor: textColor,
                                fixedSize: Size(160, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                enableFeedback: true,
                              ),
                              child: Text(
                                "More Details",
                                style: interSemiBold.copyWith(
                                  // fontSize: 16,
                                  color: secondaryBgColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class taskTile extends StatelessWidget {
  const taskTile(
      {Key? key,
      required this.userAllData,
      required this.links,
      required this.text})
      : super(key: key);

  final Map<String, dynamic> userAllData;
  final String text;
  final String links;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          userAllData[links]
              ? FontAwesomeIcons.solidCircleCheck
              : FontAwesomeIcons.solidCircleXmark,
          size: 14,
          color: userAllData[links] ? primaryBlue : secondaryRed,
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
