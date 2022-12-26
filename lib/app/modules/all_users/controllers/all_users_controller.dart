import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hiimimi/app/controllers/page_index_controller.dart';

class AllUsersController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllUsers() async* {
    // String uid = auth.currentUser!.uid;

    yield* await firestore.collection("users").snapshots();
  }
}
