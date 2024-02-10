import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:kbcquiz/Modal/userResponceModal.dart';
import 'package:kbcquiz/Utilitys/logger.dart';

import '../LocalDB/localDB.dart';

class FireDBController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final userResponceModal = Rxn<UserResponceModal>();
  RxList<Map<String, dynamic>> listQuizzes = <Map<String, dynamic>>[].obs;
  RxInt selectedCat = 0.obs;
  RxBool enoughMoney = false.obs;

  createNewUser(String userName, String userEmail, String userPhotoUrl,
      String uID) async {
    if (await getUser()) {
      logger.i("User already exists");
    } else {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
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
  }

  Future<bool> getUser() async {
    String user = "";
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
          .doc(FirebaseAuth.instance.currentUser!.uid)
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

  Future<List<Map<String, dynamic>>> getQuizzes() async {
    await _firestore.collection('quizzes').get().then((querySnapshot) {
      for (var quiz in querySnapshot.docs) {
        Map<String, dynamic> myQuiz = quiz.data();
        myQuiz['Quizid'] = quiz.reference.id;
        listQuizzes.add(myQuiz);
      }
    });
    return listQuizzes;
  }

  Future<bool> buyQuiz(
      {String userID = "", int quizPrice = 0, String quizID = ""}) async {
    await _firestore.collection('users').doc(userID).get().then((user) {
      enoughMoney.value = quizPrice <= user.data()!['money'];
    });
    if (enoughMoney.value) {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection("unlock_quiz")
          .doc(quizID)
          .set({"unlock_at": DateTime.now()});
      logger.i("Quiz is unlock now");
      return true;
    } else {
      logger.e("Not Enough Money");
      return false;
    }
  }
}
