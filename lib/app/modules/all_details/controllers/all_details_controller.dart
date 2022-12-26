import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AllDetailsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Map<String, dynamic> userInfo = Get.arguments;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllData() async {
    String uid = userInfo['uid'];

    return await firestore
        .collection("users")
        .doc(uid)
        .collection("data")
        .orderBy("date", descending: true)
        .get();
  }
}
