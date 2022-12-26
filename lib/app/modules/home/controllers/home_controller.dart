import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastDataUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("data")
        .orderBy("date")
        .limitToLast(3)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> todayTask() async* {
    String uid = auth.currentUser!.uid;
    DateTime now = DateTime.now();

    String dateNow = DateFormat("yyyy-MM-dd").format(now);
    print(dateNow);

    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("data")
        .doc(dateNow)
        .snapshots();
  }

  // List<String> words = [
  //   "a",
  //   "b",
  //   "c",
  //   "d",
  //   "e",
  // ];
}
