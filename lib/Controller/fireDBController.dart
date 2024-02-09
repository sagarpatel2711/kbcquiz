import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:kbcquiz/Modal/userResponceModal.dart';
import 'package:kbcquiz/Utilitys/logger.dart';

import '../LocalDB/localDB.dart';

class FireDBController extends GetxController {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final userResponceModal = Rxn<UserResponceModal>();

  createNewUser(String userName, String userEmail, String userPhotoUrl,
      String uID) async {
    try {
      if (await getUser()) {
        logger.i("User already exists");
      } else {
        await _firestore.collection("users").doc(_currentUser!.uid).set({
          "name": userName,
          "email": userEmail,
          'money': 0,
          'rank': "N/A",
          "photoUrl": userPhotoUrl,
          'level': 0
        }).then((value) async {
          await LocalDB.saveMoney(0);
          await LocalDB.saveRank("NA");
          await LocalDB.saveLevel(0);
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> getUser() async {
    String user = "";
    await _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .get()
        .then((value) async {
      user = value.data().toString();
      await LocalDB.saveMoney(999989);
      await LocalDB.saveRank("444");
      await LocalDB.saveLevel(45);
    });
    if (user.toString() == "null") {
      return false;
    } else {
      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .get()
          .then((value) async {
        user = value.data().toString();
        await LocalDB.saveMoney(value["money"]);
        await LocalDB.saveRank(value["rank"]);
        await LocalDB.saveLevel(value["level"]);
      });
      return true;
    }
  }
}
